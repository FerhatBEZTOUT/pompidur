import re
import socket  # Import du module socket

import connexionBD as BD

NO_RSP = "NO_RESPONSE"
tailleBuffer = 1024


# =============================== Fonction pour recevoir un message d'un client ==========================================
def recevoir(connexion):
    try:
        message = connexion.recv(tailleBuffer)
        message = message.decode("UTF-8")
        message = message.strip()
        return message
    except Exception as e:
        print("Erreur lors de la récéption : " + str(e))
        envoyer(connexion, "BYE")
        return NO_RSP  # pas de réponse du client


# ========================================== Fonction pour envoyer un message à un client ==========================================
def envoyer(connexion, message):
    try:
        message = message + "\n"
        connexion.send(message.encode())
    except:
        print("Connexion perdue avec le client")
        connexion.close()


# ========================================== Fonction pour faire une requête et retourner un curseur ==========================================
# ========================================== (curseur : un objet qui pointe sur la ligne -1 des lignes récupérés)
def sql(sql_query, sql_params):
    try:
        curr = BD.connBD.cursor()
        curr.execute(sql_query, sql_params)
        return curr
    except Exception as e:
        print(e)
        return curr


# ========================================== Fonction pour attendre un BYE du client ==========================================
def waitForBye(connexion):
    mssg = recevoir(connexion)
    if mssg == 'BYE':
        print("client : BYE")
        print("Fermeture de la connexion...")
        connexion.close()
    else:
        print("Pas de réponse du client")
        print("Fermeture de la connexion...")
        connexion.close()





# ========================================== Main ==========================================
soc = socket.socket()  # Creation d'un objet socket
host = "localhost"  # adresse du serveur
port = 2004  # on reserve un port
try:
    soc.bind((host, port))  # liaison du socket avec l'hôte et le numéro de port
    soc.listen(4)  # activation du mode écoute du socket (serveur) avec le nombre maximum de connexions simulatanées
    print("serveur lancé")

except Exception as error:
    print("Impossible de lancer le serveur")
    print(error)
    exit(1)

while True:
    conn, addr = soc.accept()  # Attente et autorisation de connexions sur le socket "soc". accept() renvoie une paire (conn,addr)
    # conn : est l'objet socket envoyé par le client
    # addr : l'adresse et le port bindés dans le socket "conn"

    conn.settimeout(10)  # Timeout de 7 secondes
    print("connexion etablie :", addr)
    msg = recevoir(conn)
    print("client : " + msg)
    if msg == 'HELLO':  # Il faut un "HELLO" pour continuer la communication, sinon la connexion se ferme instantanément
        envoyer(conn, "IDENTIFY")
        idcarte = recevoir(conn)

        print("client : " + idcarte)
        if idcarte != NO_RSP:

            if re.match('^[0-9]{7}$', idcarte):
                # Requête pour l'id_user d'une carte (vérification de l'existence de la carte implicite)
                query = 'SELECT id_user FROM carte WHERE id_carte=%s AND carte_active=TRUE AND date_exp>CURRENT_DATE'
                cur = sql(query, (idcarte,))
                if cur.rowcount:
                    carte = cur.fetchone()
                    iduser = carte[0]
                    # requête pour vérifier si un utilisateur a les pleins droits
                    query = 'SELECT hasfullaccess FROM utilisateur WHERE id_user=%s'
                    cur = sql(query, (iduser,))
                    if cur.rowcount:
                        userRow = cur.fetchone()  # récupérer champ hasfullaccess
                        if userRow[0]:  # le champ utilisateur."hasfullaccess" == true
                            envoyer(conn, "PRIVILIGED")
                            waitForBye(conn)
                            conn.close()
                        else:
                            envoyer(conn, "CarteOK")
                            idterminal = recevoir(conn)
                            print("client : " + idterminal)
                            if re.match('^[0-9]{3}$', idterminal):
                                # requête pour récupérer la salle auquel ce terminal est associé
                                query = 'SELECT id_salle FROM terminal WHERE id_terminal=%s AND actif=true'
                                cur = sql(query, (idterminal,))
                                r = cur.fetchone()
                                idSalle = r[0]
                                # requete pour récupérer la date et l'heure de reservation d'une salle par un adhérent (vérification de l'existence de cette reservation implicite)
                                query = 'SELECT dateTimeReserv FROM reserver WHERE id_adh=%s AND id_salle=%s AND dateTimeReserv<=NOW() AND dateTimeFin>=NOW()'
                                cur = sql(query, (iduser, idSalle,))
                                if cur.rowcount:
                                    envoyer(conn,"ReservOK")
                                    msg = recevoir(conn)
                                    print("client: " + msg)
                                    r = cur.fetchone()  # recuperer le résultat de la requete dans "r"
                                    dateTimeReserv = r[0]   # recuperer le champ "dateTimeReserv"
                                    if re.match('^saveMe$', msg):
                                        # mise à jour de la date et heure d'entrée à la salle
                                        query="UPDATE reserver SET datetimeentree=NOW() WHERE id_adh=%s AND id_salle=%s AND dateTimeReserv=%s"
                                        cur = sql(query, (iduser, idSalle, dateTimeReserv,))
                                        if (cur.rowcount==1):
                                            BD.connBD.commit()   # il faut commit après un UPDATE pour que l'update soit pris en compte
                                            print("Enregistrement de l'entrée réussi")
                                            envoyer(conn, "EnregOK")
                                        else:
                                            print("Echec de l'enregistrement de l'entrée")
                                            envoyer(conn, "EnregNO")
                                        waitForBye(conn)

                                else:
                                    print("Cette salle n'est pas reservée en ce moment par cette carte")
                                    envoyer(conn,"ReservNO")
                                    waitForBye(conn)
                            else:
                                print("ID terminal non reçu")
                                envoyer(conn, "idTerminalNO")
                                waitForBye(conn)
                    else:
                        print("carte existe mais n'est associée à personne (Erreur critique, structure de la bdd a été modifiée)")
                        envoyer(conn, "CarteNO")
                        waitForBye(conn)
                else:
                    print("numéro carte valide mais n'existe pas dans la BD")
                    envoyer(conn, "CarteNO")
                    waitForBye(conn)
            else:
                print("Numéro de carte non valide (doit contenir 7 chiffres uniquement)")
                envoyer(conn, "CarteNO")
                waitForBye(conn)
        else:
            print("ID carte non reçu (Error: NO_RESPONSE)")
            envoyer(conn, "CarteNO")
            waitForBye(conn)
    else:
        print("Pas de HELLO, pas de chocolat")
        envoyer(conn, "BYE")
        conn.close()
