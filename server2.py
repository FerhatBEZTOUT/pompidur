import socket  # Import du module socket
import connexionBD as BD


soc = socket.socket()  # Creation d'un objet socket
host = "localhost"  # Nom de l'hote
port = 2004  # on reserve un port
soc.bind((host, port))  # Liaison avec le port
soc.listen(4)  # En attente d'une connexion avec nombre de client maximum
print ("serveur lancé")
while True:
    conn, addr = soc.accept()  # Etablissement de la connexion
    print("connexion etablie :", addr)
    msg = conn.recv(1024)
    msg = msg.decode("utf-8")
    msg = msg.strip()
    if msg == 'HELLO':
        print("client: " + msg)
        cur = BD.connBD.cursor()
        conn.send("id : ?\n".encode())
        msg = conn.recv(1024)
        msg = msg.decode("utf-8")
        msg = msg.strip()
        sql_query = 'SELECT * FROM utilisateur WHERE id_user=%s'
        try:
            cur.execute(sql_query, (msg,))
        except:
            print("impossible d'executer la requete")
        if cur.rowcount==1:
            conn.send("je te connais\n".encode())
            msg = conn.recv(1024)
            msg = msg.decode("utf-8")
            msg = msg.strip()
        else :
            conn.send('je te connais pas\n'.encode())
    conn.close()

