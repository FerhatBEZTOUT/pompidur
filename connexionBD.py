import psycopg2
try:
    connBD = psycopg2.connect("dbname='pampidur_bdd' user='pampidur' host='postgresql-pampidur.alwaysdata.net' password='Ma3dnous!!'")
    print('connexion au serveur BD réussie')
except Exception as error:
    print(error)
    print('\nImpossible de se connecter au serveur BD')
    exit()

