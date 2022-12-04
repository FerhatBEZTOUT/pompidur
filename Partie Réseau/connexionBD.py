import psycopg2

import db_config

try:
    connBD = psycopg2.connect("dbname="+db_config.dbname+" user="+db_config.user+" host="+db_config.host+" password="+db_config.password+"")
    print('connexion au serveur BD réussie')
except Exception as error:
    print(error)
    print('\nImpossible de se connecter au serveur BD')
    exit()

