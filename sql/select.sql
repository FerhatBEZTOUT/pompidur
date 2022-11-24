SELECT U.id_user, U.hasfullaccess FROM Utilisateur U 
JOIN carte C ON U.id_user=C.id_user
WHERE C.id_carte=%s AND C.date_exp<CURRENT_DATE