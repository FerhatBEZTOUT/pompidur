-- readme : En cas de mauvaise manipulation, exécutez la totalité de ce fichier pour avoir la BD et les données de départ

-- ===============================================================================================================
-- ============================================== CREATION BDD ===================================================
-- ===============================================================================================================


DROP TABLE IF EXISTS ecrire;
DROP TABLE IF EXISTS empreinter;
DROP TABLE IF EXISTS exemplaire;
DROP TABLE IF EXISTS ouvrage;
DROP TABLE IF EXISTS auteur;
DROP TABLE IF EXISTS editeur;
DROP TABLE IF EXISTS reserver;
DROP TABLE IF EXISTS terminal;
DROP TABLE IF EXISTS materiel;
DROP TABLE IF EXISTS salle;
DROP TABLE IF EXISTS carte;
DROP TABLE IF EXISTS employe;
DROP TABLE IF EXISTS adherent;
DROP TABLE IF EXISTS utilisateur;

DROP SEQUENCE IF EXISTS user_seq;
DROP SEQUENCE IF EXISTS aut_seq;
DROP SEQUENCE IF EXISTS edit_seq;
DROP SEQUENCE IF EXISTS carte_seq;
DROP SEQUENCE IF EXISTS terminal_seq;
DROP SEQUENCE IF EXISTS materiel_seq;


DROP TYPE IF EXISTS DROIT_TYPE;

-- ================================= utilisateur ================================1
CREATE SEQUENCE user_seq START 1000001;
CREATE TABLE utilisateur (
    id_user INT,
    nom_user VARCHAR(30) NOT NULL,
    prenom_user VARCHAR(30) NOT NULL,
    date_naiss_user DATE,
    email_user VARCHAR(80) NOT NULL UNIQUE,
    mdp_user CHAR(60) NOT NULL,
    photo_user TEXT,
    tel_user CHAR(10),
    rue_user VARCHAR(100),
    code_post_user CHAR(5),
    ville_user VARCHAR(50),
    hasFullAccess BOOLEAN NOT NULL DEFAULT FALSE,
    
    CONSTRAINT pk_utilisateur PRIMARY KEY (id_user),
    CONSTRAINT ck_id CHECK (id_user>1000000 AND id_user<10000000),
    CONSTRAINT ck_nom CHECK (length(nom_user)>0),
    CONSTRAINT ck_prenom CHECK (length(prenom_user)>0),
    CONSTRAINT ck_datenaiss CHECK (date_naiss_user<=CURRENT_DATE),
    CONSTRAINT ck_email CHECK (email_user LIKE '%_@__%.__%')

);



-- ================================= adherent ================================2
CREATE TABLE adherent (
    id_adh INT,
    pseudo_adh VARCHAR(20) NOT NULL,

    CONSTRAINT pk_adherent PRIMARY KEY (id_adh),
    CONSTRAINT fk_adh_user FOREIGN KEY(id_adh) REFERENCES utilisateur(id_user) ON DELETE CASCADE ON UPDATE CASCADE

);



CREATE TYPE DROIT_TYPE AS ENUM('ALL','READ','WRITE');
-- ================================= employe ================================3
CREATE TABLE employe (
    id_emp INT,
    roleEmp VARCHAR(25) NOT NULL,
    droit_acces DROIT_TYPE NOT NULL,
    salaire FLOAT NOT NULL,

    CONSTRAINT pk_employe PRIMARY KEY (id_emp),
    CONSTRAINT fk_adh_emp FOREIGN KEY(id_emp) REFERENCES utilisateur(id_user) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE SEQUENCE carte_seq START 1000001;
-- ================================= carte ================================4
CREATE TABLE carte (
    id_carte INT,
    date_exp DATE NOT NULL,
    carte_active BOOLEAN NOT NULL,
    id_user INT NOT NULL,

    CONSTRAINT pk_carte PRIMARY KEY (id_carte),
    CONSTRAINT ck_idcarte CHECK (id_carte>1000000 AND id_carte<10000000),
    CONSTRAINT ck_dateExp CHECK (date_exp>CURRENT_DATE + INTERVAL '1 year'),
    CONSTRAINT fk_carte_user FOREIGN KEY(id_carte) REFERENCES utilisateur(id_user) ON DELETE NO ACTION ON UPDATE CASCADE

);



-- ================================= salle ================================5
CREATE TABLE salle (
    id_salle CHAR(5),
    nom_salle VARCHAR(25) NOT NULL UNIQUE,
    etage_salle INT NOT NULL,
    batiment_salle CHAR(1) NOT NULL,

    CONSTRAINT pk_salle PRIMARY KEY (id_salle),
    CONSTRAINT ck_etage CHECK (etage_salle>-4 AND etage_salle<10)

);


CREATE SEQUENCE materiel_seq START 10001;
-- ================================= materiel ================================6
CREATE TABLE materiel (
    id_materiel INT,
    type_materiel VARCHAR(15)NOT NULL,
    date_achat_mat DATE NOT NULL,
    prix_mat FLOAT NOT NULL,
    id_salle CHAR(5) NOT NULL,

    CONSTRAINT pk_materiel PRIMARY KEY (id_materiel),
    CONSTRAINT ck_dateachat_mat CHECK (date_achat_mat>'2000-01-01'),
    CONSTRAINT ck_prixmat CHECK (prix_mat>0),
    CONSTRAINT fk_materiel_salle FOREIGN KEY(id_salle) REFERENCES salle(id_salle) ON DELETE CASCADE ON UPDATE CASCADE

);


CREATE SEQUENCE terminal_seq START 101;
-- ================================= terminal ================================7
CREATE TABLE terminal (
    id_terminal INT,
    nom_terminal VARCHAR(25) NOT NULL,
    actif BOOLEAN NOT NULL,
    id_salle CHAR(5) NOT NULL,

    CONSTRAINT pk_terminal PRIMARY KEY (id_terminal),
    CONSTRAINT ck_idterm CHECK (id_terminal>100 AND id_terminal<1000),
    CONSTRAINT fk_terminal_salle FOREIGN KEY(id_salle) REFERENCES salle(id_salle) ON DELETE CASCADE ON UPDATE CASCADE
);



-- ================================= reserver ================================8
CREATE TABLE reserver (
    id_adh INT,
    id_salle CHAR(5),
    dateTimeReserv TIMESTAMP,
    dateTimeFin TIMESTAMP NOT NULL,
    dateTimeEntree TIMESTAMP,
    dateTimeSortie TIMESTAMP,

    CONSTRAINT pk_reserver PRIMARY KEY (id_adh,id_salle,dateTimeReserv),
    CONSTRAINT ck_datetimeresrv CHECK (dateTimeReserv<dateTimeFin),
    CONSTRAINT fk_reserver_adh FOREIGN KEY(id_adh) REFERENCES adherent(id_adh) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_reserver_salle FOREIGN KEY(id_salle) REFERENCES salle(id_salle) ON DELETE CASCADE ON UPDATE CASCADE

);


CREATE SEQUENCE edit_seq START 1001;
-- ================================= editeur ================================9
CREATE TABLE editeur (
    id_edit INT,
    nom_edit VARCHAR(150) NOT NULL,
    adr_edit VARCHAR(80),
    pays_edit VARCHAR(40),

    CONSTRAINT pk_editeur PRIMARY KEY (id_edit),
    CONSTRAINT ck_idedit CHECK (id_edit>1000 AND id_edit<10000)

);


CREATE SEQUENCE aut_seq START 1000001;
-- ================================= auteur ================================10
CREATE TABLE auteur (
    id_aut INT,
    nom_aut VARCHAR(50) NOT NULL,
    prenom_aut VARCHAR(50) NOT NULL,
    email_aut VARCHAR(80),
    photo_aut TEXT,
    dateNaiss_aut DATE,
    mvment_aut VARCHAR(25),

    CONSTRAINT pk_auteur PRIMARY KEY (id_aut),
    CONSTRAINT ck_id CHECK (id_aut>1000000 AND id_aut<10000000),
    CONSTRAINT ck_datenaissaut CHECK(dateNaiss_aut<=CURRENT_DATE)

);



-- ================================= ouvrage ================================11
CREATE TABLE ouvrage (
    isbn_ouv CHAR(13),
    titre_ouv VARCHAR(255) NOT NULL,
    nbr_page INT,
    langue_ouv VARCHAR(5),
    image_ouv TEXT,
    date_parrution DATE,
    prix_ouv FLOAT,
    genre_ouv VARCHAR(25),
    theme_ouv VARCHAR(25),
    id_edit INT,

    CONSTRAINT pk_ouvrage PRIMARY KEY (isbn_ouv),
    CONSTRAINT ck_prixouv CHECK (prix_ouv>0.0),
    CONSTRAINT fk_ouv_edit FOREIGN KEY(id_edit) REFERENCES editeur(id_edit) ON DELETE SET NULL ON UPDATE CASCADE


);



-- ================================= exemplaire ================================12
CREATE TABLE exemplaire (
    id_exemp SERIAL,
    num_exemp INT,
    date_achat_exmp DATE,
    isbn_ouv CHAR(13) NOT NULL,

    CONSTRAINT pk_exemplaire PRIMARY KEY (id_exemp),
    CONSTRAINT fk_exmp_ouv FOREIGN KEY(isbn_ouv) REFERENCES ouvrage(isbn_ouv) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT ck_dateachat_mat CHECK (date_achat_exmp>'2000-01-01')

);



-- ================================= empreinter ================================13
CREATE TABLE empreinter (
    id_adh INT,
    id_exemp INT,
    date_emp DATE NOT NULL,
    dateRetourPrevue DATE NOT NULL,
    dateRetour DATE,

    CONSTRAINT pk_empreinter PRIMARY KEY (id_adh,id_exemp,date_emp),
    CONSTRAINT ck_dateemp1 CHECK (date_emp<dateRetourPrevue),
    CONSTRAINT ck_dateemp2 CHECK (date_emp<=dateRetour),
    CONSTRAINT fk_empr_exemp FOREIGN KEY(id_exemp) REFERENCES exemplaire(id_exemp) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_empr_adh FOREIGN KEY(id_adh) REFERENCES adherent(id_adh) ON DELETE NO ACTION ON UPDATE CASCADE
    
    
);



-- ================================= ecrire ================================14
CREATE TABLE ecrire (
    id_aut INT,
    isbn_ouv CHAR(13),

    CONSTRAINT pk_ecrire PRIMARY KEY (id_aut,isbn_ouv),
    CONSTRAINT fk_ecrire_aut FOREIGN KEY(id_aut) REFERENCES auteur(id_aut) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_ecrire_ouv FOREIGN KEY(isbn_ouv) REFERENCES ouvrage(isbn_ouv) ON DELETE NO ACTION ON UPDATE CASCADE

);








-- ===============================================================================================================
-- ============================================== INSERTION ======================================================
-- ===============================================================================================================

DELETE FROM ecrire;
DELETE FROM empreinter;
DELETE FROM exemplaire;
DELETE FROM ouvrage;
DELETE FROM auteur;
DELETE FROM editeur;
DELETE FROM reserver;
DELETE FROM terminal;
DELETE FROM materiel;
DELETE FROM salle;
DELETE FROM carte;
DELETE FROM employe;
DELETE FROM adherent;
DELETE FROM utilisateur;


ALTER SEQUENCE user_seq RESTART WITH 1000001;
ALTER SEQUENCE aut_seq  RESTART WITH 1000001 ;
ALTER SEQUENCE edit_seq RESTART WITH 1001 ;
ALTER SEQUENCE carte_seq RESTART WITH 1000001 ;
ALTER SEQUENCE terminal_seq RESTART WITH 101 ;
ALTER SEQUENCE materiel_seq RESTART WITH 10001 ;




-- ================================= utilisateur ================================1

INSERT INTO utilisateur VALUES (nextval('user_seq'),'admin', 'admin', '2000-01-01', 'admin@gmail.com', '$2y$10$zhrBgkUwDoldj.GGx.Pbiuffmt0wiiuIpooiwBcwLh0bVL4OcLTg2', 'https://www.clipartmax.com/png/middle/171-1717870_stockvader-predicted-cron-for-may-user-profile-icon-png.png', NULL, NULL, NULL, NULL, TRUE);
INSERT INTO utilisateur VALUES (nextval('user_seq'),'doe', 'john', '1977-04-20', 'jd@gmail.com', '$2y$10$r2dF.LJpyU5dP4k74JZUce56PZ8XpO2A8fKdwEHIKv0RNSoXPcWJq', 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png', NULL, NULL, NULL, 'Paris',TRUE);
INSERT INTO utilisateur VALUES (nextval('user_seq'),'doe', 'jenna','1982-01-03', 'jenna@gmail.com', '$2y$10$BRd8q22P6d9pvh8Ej2u7xuGXnusDV8knHscuMiIT9qWCXX2cdbNhG', 'https://phototrend.fr/wp-content/uploads/2016/05/Thibault-Copleux-12-940x627.jpg', NULL, NULL, NULL, 'Lyon',FALSE);
INSERT INTO utilisateur VALUES (nextval('user_seq'),'beztout', 'ferhat','1997-02-03', 'deter@gmail.com', '$2y$10$Ho1V7/e35YsQVnnBwqEAB.g0V3bv7x5tpSWbaRNehwjxeCMU.cFDi', 'https://media.istockphoto.com/id/1309328823/photo/headshot-portrait-of-smiling-male-employee-in-office.jpg?s=170667a&w=0&k=20&c=_7-hSDG3PL7yEDXLGdk_CbOQibGCbQXYbIQX7EnfeO0=', '0645976598','15 rue Bercy', '75012', 'Paris',FALSE);
INSERT INTO utilisateur VALUES (nextval('user_seq'),'madour', 'melissa','2000-01-01', 'meli@gmail.com', '$2y$10$Ho1V7/e35YsQVnnBwqEAB.g0V3bv7x5tpSWbaRNehwjxeCMU.cFDi', 'https://letourduweb.fr/wp-content/uploads/2019/09/profil.jpg', '0645976598','15 rue Bercy', '75012', 'Paris',FALSE);


-- ================================= adherent ================================1

INSERT INTO adherent VALUES (1000003, 'j3enn4');
INSERT INTO adherent VALUES (1000004, 'deter');
INSERT INTO adherent VALUES (1000005, 'meli');


-- ================================= employe ================================1
INSERT INTO employe VALUES (1000001, 'admin', 'ALL', 3375.23);
INSERT INTO employe VALUES (1000002, 'bibliothécaire', 'READ', 2501.49);


-- ================================= carte ================================1
INSERT INTO carte VALUES (nextval('carte_seq'),  '2029-12-31', true, 1000002);
INSERT INTO carte VALUES (nextval('carte_seq'), '2025-05-20', true, 1000004);
INSERT INTO carte VALUES (nextval('carte_seq'), '2024-01-15', true, 1000003);
insert into carte values (nextval('carte_seq'),'2025-01-20',TRUE,1000005);


-- ================================= salle ================================1
INSERT INTO salle VALUES('PC001', 'Carré', 0, 'B');
INSERT INTO salle VALUES('PC002', 'Optimus', -1, 'A');
INSERT INTO salle VALUES('EC001', 'Harry', 2, 'B');
INSERT INTO salle VALUES('EC002', 'Vision', 0, 'E');
INSERT INTO salle VALUES('EC003', 'Immersion', -2, 'C');
INSERT INTO salle VALUES('NO001', 'Dragon', 1, 'A');
INSERT INTO salle VALUES('NO002', 'Obsidienne', 3, 'B');


-- ================================= materiel ================================1
INSERT INTO materiel VALUES (nextval('materiel_seq'), 'Ordinateur', '2014-01-02', 466.99, 'PC001' );
INSERT INTO materiel VALUES (nextval('materiel_seq'), 'Ecran', '2016-01-02', 150.00, 'EC001' );
INSERT INTO materiel VALUES (nextval('materiel_seq'), 'Ecran', '2017-05-14', 195.00, 'EC002' );
INSERT INTO materiel VALUES (nextval('materiel_seq'), 'Ordinateur', '2015-12-30', 579.00, 'PC001' );
INSERT INTO materiel VALUES (nextval('materiel_seq'), 'Projecteur', '2012-05-28', 249.99, 'EC002' );
INSERT INTO materiel VALUES (nextval('materiel_seq'), 'Ordinateur', '2013-03-11', 900.00, 'PC002' );
INSERT INTO materiel VALUES (nextval('materiel_seq'), 'Ordinateur', '2016-11-16', 500.00, 'PC001' );
INSERT INTO materiel VALUES (nextval('materiel_seq'), 'Imprimante', '2016-07-24', 120.00, 'PC001' );
INSERT INTO materiel VALUES (nextval('materiel_seq'), 'Ordinateur', '2019-06-25', 500.00, 'PC002' );
INSERT INTO materiel VALUES (nextval('materiel_seq'), 'Scanner', '2015-04-30', 150.00, 'PC002' );
INSERT INTO materiel VALUES (nextval('materiel_seq'), 'Ordinateur', '2019-11-21', 650.00, 'PC001' );
INSERT INTO materiel VALUES (nextval('materiel_seq'), 'Ecran', '2016-04-16', 245.50, 'EC002');
INSERT INTO materiel VALUES (nextval('materiel_seq'), 'Ordinateur', '2015-05-05', 599.99, 'PC001' );
INSERT INTO materiel VALUES (nextval('materiel_seq'), 'Projecteur', '2012-12-17', 130.00, 'EC001' );


-- ================================= terminal ================================1
INSERT INTO terminal VALUES (nextval('terminal_seq'), 'term1', true, 'PC001');
INSERT INTO terminal VALUES (nextval('terminal_seq'), 'term2', true, 'PC002');
INSERT INTO terminal VALUES (nextval('terminal_seq'), 'term3', true, 'EC001');
INSERT INTO terminal VALUES (nextval('terminal_seq'), 'term4', false, 'EC002');
INSERT INTO terminal VALUES (nextval('terminal_seq'), 'term5', true, 'EC003');
INSERT INTO terminal VALUES (nextval('terminal_seq'), 'term6', true, 'NO001');
INSERT INTO terminal VALUES (nextval('terminal_seq'), 'term7', true, 'NO001');


-- ================================= reserver ================================1
INSERT INTO Reserver VALUES (1000004, 'PC001', '2022-11-26 11:30:00',  '2022-12-20 12:30:00', NULL, NULL);
INSERT INTO Reserver VALUES (1000003, 'EC001', '2022-12-15 10:00:00',  '2022-12-25 11:00:00', NULL, NULL);
INSERT INTO Reserver VALUES (1000004, 'PC001', '2022-11-17 10:00:00',  '2022-11-17 12:00:00', '2022-11-17 10:05:00', '2022-11-17 11:55:00');


-- ================================= editeur ================================1
INSERT INTO editeur VALUES (nextval('edit_seq'), 'lelivrescolaire.fr', '14 Rue Rhin et Danube, 69009 LYON', 'FR' );
INSERT INTO editeur VALUES (nextval('edit_seq'), 'Fantastic Edition ', '15 rue du Berger, 75002 Paris', 'FR' );
INSERT INTO editeur VALUES (nextval('edit_seq'), 'Paper House', 'Mohrenstrasse 37, 10117 Berlin', 'GER' );
INSERT INTO editeur(id_edit,nom_edit,pays_edit) VALUES(1004,'Harvard University Press','USA');
INSERT INTO editeur(id_edit,nom_edit,pays_edit) VALUES(1005,'Harvard University Press (Cambridge  MA)/Wm Heinemann Ltd. (London)','USA');
INSERT INTO editeur(id_edit,nom_edit,pays_edit) VALUES(1006,'Amereon Ltd','USA');
INSERT INTO editeur(id_edit,nom_edit,pays_edit) VALUES(1007,'Harvard University Press (Cambridge)','USA');
INSERT INTO editeur(id_edit,nom_edit,pays_edit) VALUES(1008,'Trafalgar Square Publishing','UK');
INSERT INTO editeur(id_edit,nom_edit,pays_edit) VALUES(1009,'International Polygonics','UK');
INSERT INTO editeur(id_edit,nom_edit,pays_edit) VALUES(1010,'P. F. Collier and Sons','UK');
INSERT INTO editeur(id_edit,nom_edit,pays_edit) VALUES(1011,'Thomas Y. Crowell Company','UK');
INSERT INTO editeur(id_edit,nom_edit,pays_edit) VALUES(1012,'Random House Books for Young Readers','AUS');
INSERT INTO editeur(id_edit,nom_edit,pays_edit) VALUES(1013,'International Publishers (NYC)','USA');
INSERT INTO editeur(id_edit,nom_edit,pays_edit) VALUES(1014,'Scholastic Inc.','UK');
INSERT INTO editeur(id_edit,nom_edit,pays_edit) VALUES(1015,'Chatto and Windus','USA');
INSERT INTO editeur(id_edit,nom_edit,pays_edit) VALUES(1016,'Bantam Classics','UK');
INSERT INTO editeur(id_edit,nom_edit,pays_edit) VALUES(1017,'Fawcett crest','GER');
INSERT INTO editeur(id_edit,nom_edit,pays_edit) VALUES(1018,'Dramatists Play Service','UK');
INSERT INTO editeur(id_edit,nom_edit,pays_edit) VALUES(1019,'Harcourt Brace Jovanovich','USA');
INSERT INTO editeur(id_edit,nom_edit,pays_edit) VALUES(1020,'Laurel','FR');
INSERT INTO editeur(id_edit,nom_edit,pays_edit) VALUES(1021,'Penguin Classics','FR');
INSERT INTO editeur(id_edit,nom_edit,pays_edit) VALUES(1022,'Vintage','ITA');
INSERT INTO editeur(id_edit,nom_edit,pays_edit) VALUES(1023,'New Directions Publishing Corporation','USA');
INSERT INTO editeur(id_edit,nom_edit,pays_edit) VALUES(1024,'Dover Publications','USA');
INSERT INTO editeur(id_edit,nom_edit,pays_edit) VALUES(1025,'Dover Publications (NY)','USA');
INSERT INTO editeur(id_edit,nom_edit,pays_edit) VALUES(1026,'Doubleday Books','FR');
INSERT INTO editeur(id_edit,nom_edit,pays_edit) VALUES(1027,'Random House','UK');
INSERT INTO editeur(id_edit,nom_edit,pays_edit) VALUES(1028,'Signet Books (NY)','POL');
INSERT INTO editeur(id_edit,nom_edit,pays_edit) VALUES(1029,'Library of Liberal Arts/Bobb-Merrill (Indianapolis  IN)','POR');
INSERT INTO editeur(id_edit,nom_edit,pays_edit) VALUES(1030,'Vintage Books','FIN');
INSERT INTO editeur(id_edit,nom_edit,pays_edit) VALUES(1031,'Perfection Learning','FIN');
INSERT INTO editeur(id_edit,nom_edit,pays_edit) VALUES(1032,'International Publishers','USA');
INSERT INTO editeur(id_edit,nom_edit,pays_edit) VALUES(1033,'Yale University Press (New Haven  CT)','USA');
INSERT INTO editeur(id_edit,nom_edit,pays_edit) VALUES(1034,'Berkley Books','GER');
INSERT INTO editeur(id_edit,nom_edit,pays_edit) VALUES(1035,'W.W. Norton & Company  Inc. (NY)','USA');
INSERT INTO editeur(id_edit,nom_edit,pays_edit) VALUES(1036,'Mariner Books','UK');
INSERT INTO editeur(id_edit,nom_edit,pays_edit) VALUES(1037,'Penguin/Viking Compass (Non-Classics)','SUE');


-- ================================= auteur ================================1
INSERT INTO auteur VALUES (nextval('aut_seq'), 'Meyer', 'Stephenine', NULL, 'https://images-na.ssl-images-amazon.com/images/I/31N5IJ6wiUL.jpg', '1973-12-24', 'romantisme');
INSERT INTO auteur VALUES (nextval('aut_seq'), 'Yvan', 'Monka', 'yvan.m@gmail.com', 'https://www.phosphore.com/wp-content/uploads/2022/09/YVAN_MONKA_025-e1664177114446.jpg', '1970-02-15');
INSERT INTO auteur VALUES (nextval('aut_seq'), 'Hugo', 'Victor', NULL, 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/25/Victor_Hugo_001.jpg/260px-Victor_Hugo_001.jpg', '1802-02-26', 'romantisme');
INSERT INTO auteur VALUES (nextval('aut_seq'), 'Dumas', 'Alexandre', NULL, 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Alexandre_Dumas.jpg/483px-Alexandre_Dumas.jpg', '1802-07-24', 'romantisme');
INSERT INTO auteur(id_aut,nom_aut,prenom_aut,photo_aut,dateNaiss_aut,mvment_aut) VALUES (1000005,'Annalise ','Sears','https://i.pinimg.com/originals/d7/37/94/d737946d153beb56555ed95ab0af1ee1.jpg','1913-01-01','romantisme');
INSERT INTO auteur(id_aut,nom_aut,prenom_aut,photo_aut,dateNaiss_aut,mvment_aut) VALUES (1000006,'Rebekah','Friedman','https://books.forbes.com/wp-content/uploads/2022/07/90106f31-8c96-40e6-b0ca-934fef74ab69-2-819x1024.jpg','1913-01-02','romantisme');
INSERT INTO auteur(id_aut,nom_aut,prenom_aut,photo_aut,dateNaiss_aut,mvment_aut) VALUES (1000007,'Casey','Rodgers','https://s26162.pcdn.co/wp-content/uploads/2018/01/neil.png','1919-01-01','réalisme');
INSERT INTO auteur(id_aut,nom_aut,prenom_aut,photo_aut,dateNaiss_aut,mvment_aut) VALUES (1000008,'Kacie','Boyd','https://texasteenbookfestival.org/wp-content/uploads/2019/07/Mary-HK-Choi-Author-Photo_hr.jpg','1919-01-02','réalisme');
INSERT INTO auteur(id_aut,nom_aut,prenom_aut,photo_aut,dateNaiss_aut,mvment_aut) VALUES (1000009,'Helena','Perry','https://images.squarespace-cdn.com/content/v1/54c0f332e4b00608c425fc71/1519389889675-XDCDNT1I2P7302X5KY6I/Elsa-64.jpg?format=1000w','1921-01-01','symbolisme');
INSERT INTO auteur(id_aut,nom_aut,prenom_aut,photo_aut,dateNaiss_aut,mvment_aut) VALUES (1000010,'Beau','Reid','https://miro.medium.com/max/500/0*Esklxlx9-hdrlMqO.png','1923-01-01','humanisme');
INSERT INTO auteur(id_aut,nom_aut,prenom_aut,photo_aut,dateNaiss_aut,mvment_aut) VALUES (1000011,'Juliette ','George','https://i.pinimg.com/200x/8b/f3/e8/8bf3e8085625e5cfb284e94ed139b4e6.jpg','1925-01-01','romantisme');
INSERT INTO auteur(id_aut,nom_aut,prenom_aut,photo_aut,dateNaiss_aut,mvment_aut) VALUES (1000012,'Betty','Parsons','https://gatekeeperpress.com/wp-content/uploads/Dean-Koontz.jpg','1925-01-09','romantisme');
INSERT INTO auteur(id_aut,nom_aut,prenom_aut,photo_aut,dateNaiss_aut,mvment_aut) VALUES (1000013,'Kaya','Mayo','https://i.pinimg.com/originals/72/df/15/72df155183b7920370a45131c7762bbb.jpg','1928-01-01','humanisme');
INSERT INTO auteur(id_aut,nom_aut,prenom_aut,photo_aut,dateNaiss_aut,mvment_aut) VALUES (1000014,'Allan ','Bowers','https://scribemedia.com/wp-content/uploads/2015/09/eric-ries.png','1929-01-01','réalisme');
INSERT INTO auteur(id_aut,nom_aut,prenom_aut,photo_aut,dateNaiss_aut,mvment_aut) VALUES (1000015,'Heather ','Bowers','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZ7zLHQJvJN9arpeYZ_HV32m-HNc3msdbAGw&usqp=CAU','1931-01-12','symbolisme');
INSERT INTO auteur(id_aut,nom_aut,prenom_aut,photo_aut,dateNaiss_aut,mvment_aut) VALUES (1000016,'Drew ','Francis','https://www.jefferydeaver.com/wp-content/uploads/2021/03/Niko-Giovanni-Coniglio-200x300.png','1935-01-01','symbolisme');
INSERT INTO auteur(id_aut,nom_aut,prenom_aut,photo_aut,dateNaiss_aut,mvment_aut) VALUES (1000017,'Stephen ','Sloan','https://miro.medium.com/max/800/0*Ty1Vn1voczy6UdeT.png','1940-01-01','humanisme');
INSERT INTO auteur(id_aut,nom_aut,prenom_aut,photo_aut,dateNaiss_aut,mvment_aut) VALUES (1000018,'Aleeza','Lawson','https://cdn-bcmawriter.pressidium.com/wp-content/uploads/2017/03/Ian-Sutherland.jpg','1943-01-01','romantisme');
INSERT INTO auteur(id_aut,nom_aut,prenom_aut,photo_aut,dateNaiss_aut,mvment_aut) VALUES (1000019,'Tony','Patel','https://untpress.unt.edu/assets/images/people/b/brown-peter.jpg?v=1667408673','1947-12-09','romantisme');
INSERT INTO auteur(id_aut,nom_aut,prenom_aut,photo_aut,dateNaiss_aut,mvment_aut) VALUES (1000020,'Emre ','Barron','https://untpress.unt.edu/assets/images/people/a/alger-dean.jpg?v=1667408673','1948-01-06','humanisme');
INSERT INTO auteur(id_aut,nom_aut,prenom_aut,photo_aut,dateNaiss_aut,mvment_aut) VALUES (1000021,'Nataniel','Fowler','https://i.pinimg.com/474x/40/57/58/4057588bdfe653ac447950fe5e63b0a1--business-headshots-professional-headshots.jpg','1949-01-01','réalisme');
INSERT INTO auteur(id_aut,nom_aut,prenom_aut,photo_aut,dateNaiss_aut,mvment_aut) VALUES (1000022,'Bryn','Decker','https://untpress.unt.edu/assets/images/people/b/barnett-john-t.jpg?v=1667408673','1949-01-12','symbolisme');
INSERT INTO auteur(id_aut,nom_aut,prenom_aut,photo_aut,dateNaiss_aut,mvment_aut) VALUES (1000023,'Owen ','Guzman','https://www.sandburg.org/img/John-T-Barnett_portrait.jpg','1950-01-11','symbolisme');




-- ================================= ouvrage ================================1
INSERT INTO ouvrage VALUES('9782298011531', 'fascination', 512, 'fr', 'https://m.media-amazon.com/images/I/611tYNxepyL.jpg', '2005-10-05', 25.0, 'narratif', 'vampires', 1003 );
INSERT INTO ouvrage VALUES('9782377601479', 'math 2de', 352, 'fr', 'https://assets.lls.fr/books/978-2-37760-147-9-MA2_P_2019.png', '2010-02-05', 13.5, 'éducatif', 'maths', 1001 );
INSERT INTO ouvrage VALUES('9782253096337', 'les misérables', 1630, 'fr', 'https://m.media-amazon.com/images/I/510ypkdwIYL.jpg', '1862-01-01', 13.9, 'narratif', 'amour', 1002 );
INSERT INTO ouvrage VALUES ('9780674990333','On Duties (De Officiis)',448,'en','https://m.media-amazon.com/images/I/41QhzOHWCzL._SX313_BO1,204,203,200_.jpg','1913-01-01',12.5497210953239,'narratif','argent',1004);
INSERT INTO ouvrage VALUES ('9780674990395','Agricola / Germania / Dialogue on Oratory',384,'de','https://m.media-amazon.com/images/I/61KrcnD9rbL.jpg','1914-01-01',30.9631947710877,'théatral','amour',1004);
INSERT INTO ouvrage VALUES ('9780674991200','History of the Peloponnesian War: Bk. 1-2',496,'fr','https://m.media-amazon.com/images/I/51ALisQrO4L._AC_SY780_.jpg','1919-01-01',56.7634059863491,'épistolaire','économie',1004);
INSERT INTO ouvrage VALUES ('9780674991224','History of the Peloponnesian War: Bk. 5-6',400,'fr','https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1347498289l/1444.jpg','1921-01-01',53.6528664262534,'argumentatif','économie',1004);
INSERT INTO ouvrage VALUES ('9780674991354','The Library 1  Books 1-3.9',464,'fr','https://pictures.abebooks.com/isbn/9780674991354-us.jpg','1921-01-01',50.6567963330188,'poétique','ambition',1005);
INSERT INTO ouvrage VALUES ('9780674991873','History of the Peloponnesian War  Bk. 7-8',480,'en','https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1347632483l/1459.jpg','1923-01-01',50.0580009318134,'théatral','absurde',1004);
INSERT INTO ouvrage VALUES ('9780674992023','Scripta Minora: Hiero/Agesilaus/Constitution of the Lacedaemonians/Ways & Means/Cavalry Commander/Art of Horsemanship/On Hunting/Constitution of the Athenians',576,'de','https://m.media-amazon.com/images/I/417INx3AdiL._SX338_BO1,204,203,200_.jpg','1925-01-01',13.006496245469,'narratif','angoisse',1004);
INSERT INTO ouvrage VALUES ('9780891906797','The Great Gatsby',182,'en','https://m.media-amazon.com/images/I/61z0MrB6qOS.jpg','1925-01-09',17.2737112563223,'narratif','éducation',1006);
INSERT INTO ouvrage VALUES ('9780674992405','Discourses  Books 3-4. The Enchiridion (Loeb Classical Library #218)',576,'en','https://www.loebclassics.com/view/covers/LCL218.png','1928-01-01',2.0038886847772,'narratif','amour',1007);
INSERT INTO ouvrage VALUES ('9780674992559','The Art of Love and Other Poems',400,'en','https://m.media-amazon.com/images/I/41jeU8A8-DL._AC_SY780_.jpg','1929-01-01',10.0533363726415,'narratif','amour',1004);
INSERT INTO ouvrage VALUES ('9781851588527','Raised on Rock: Growing Up at Graceland',192,'en','https://m.media-amazon.com/images/I/41R9540AJNL._AC_SY780_.jpg','1931-01-12',33.2026331987943,'théatral','amour',1008);
INSERT INTO ouvrage VALUES ('9780930330019','Murder from the East',312,'en','https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1588571052i/48890214.jpg','1935-01-01',42.0121266240962,'narratif','argent',1009);
INSERT INTO ouvrage VALUES ('9781117066035','For Whom the Bell Tolls',503,'en','https://m.media-amazon.com/images/I/71huFMKlLTL.jpg','1940-01-01',18.8788517970838,'théatral','amour',1010);
INSERT INTO ouvrage VALUES ('9780690134490','Betsy and Tacy Go Downtown (Betsy-Tacy  #4)',180,'en','https://m.media-amazon.com/images/I/61UdfP9Jm2L._AC_SY780_.jpg','1943-01-01',18.0085760843647,'narratif','économie',1011);
INSERT INTO ouvrage VALUES ('9780394800837','McElligots Pool',64,'en','https://m.media-amazon.com/images/I/A1QE4d1unJL.jpg','1947-12-09',31.2784258185719,'théatral','économie',1012);
INSERT INTO ouvrage VALUES ('9780717802418','The Communist Manifesto',48,'en','https://m.media-amazon.com/images/I/31AfmhYzOXL.jpg','1948-01-06',49.9585178700502,'épistolaire','ambition',1013);
INSERT INTO ouvrage VALUES ('9780439454001','Math fables',40,'en','https://m.media-amazon.com/images/I/514KeAS40bL._AC_SY780_.jpg','1949-01-01',17.1310574980789,'argumentatif','absurde',1014);
INSERT INTO ouvrage VALUES ('9780701106546','Seven Types of Ambiguity',272,'en','https://m.media-amazon.com/images/M/MV5BMTlhZWQ4ZTAtMzViNS00OGVlLTk1YmEtODU5YzZjZGJmYTU3XkEyXkFqcGdeQXVyMTAwNjg5MTM@._V1_FMjpg_UX1000_.jpg','1949-01-12',34.1720713476515,'poétique','angoisse',1015);
INSERT INTO ouvrage VALUES ('9780553213607','Cyrano de Bergerac',208,'en','https://www.enseignants.hachette-education.com/sites/default/files/images/livres/couv/9782013949866-001-T.jpeg','1950-01-11',52.4265772335837,'théatral','éducation',1016);
INSERT INTO ouvrage VALUES ('9780449015414','The Currents of Space (Galactic Empire  #2)',192,'en','https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1328110000i/85434.jpg','1952-01-01',16.3530314156846,'narratif','amour',1017);
INSERT INTO ouvrage VALUES ('9780822210894','A Streetcar Named Desire',107,'en','https://upload.wikimedia.org/wikipedia/commons/f/fe/A_Streetcar_Named_Desire_%281951%29.jpg','1952-01-12',17.1670822414252,'narratif','amour',1018);
INSERT INTO ouvrage VALUES ('9780451526915','Arrowsmith',428,'en','https://upload.wikimedia.org/wikipedia/commons/1/14/Arrowsmith_poster.jpg','1953-01-06',28.3908162796394,'narratif','amour',1019);
INSERT INTO ouvrage VALUES ('9780440391548','The Turn of the Screw/Daisy Miller',192,'en','https://m.media-amazon.com/images/I/41rJ1qCzfaL._SX341_BO1,204,203,200_.jpg','1954-01-08',54.2066296081304,'narratif','argent',1020);
INSERT INTO ouvrage VALUES ('9780140446388','The Histories',622,'en','https://kbimages1-a.akamaihd.net/dcd743bd-951a-4349-baad-578f136c9412/1200/1200/False/the-histories-36.jpg','1954-01-09',10.7743668426237,'théatral','amour',1021);
INSERT INTO ouvrage VALUES ('9780394700021','The Stranger',154,'de','https://images.ctfassets.net/4cd45et68cgf/aXpogGacw8gMlQ1myxRWp/c0957190d2702297172da00f40504d26/EN_TheStranger_Main_Vertical_RGB_PRE.jpeg?w=2560','1954-12-09',37.2388142422937,'narratif','économie',1022);
INSERT INTO ouvrage VALUES ('9780811200912','The Selected Poems of Federico GarcÃ­a Lorca',180,'fr','https://m.media-amazon.com/images/I/41XHPTyCybL.jpg','1955-01-06',29.7004999200804,'théatral','économie',1023);
INSERT INTO ouvrage VALUES ('9780394700137','James Joyces Ulysses',405,'en','https://upload.wikimedia.org/wikipedia/commons/a/ab/JoyceUlysses2.jpg','1955-12-01',24.8656305804159,'narratif','ambition',1022);
INSERT INTO ouvrage VALUES ('9780394800844','On Beyond Zebra!',64,'en','https://m.media-amazon.com/images/I/51Iv6uiTOOL._SX361_BO1,204,203,200_.jpg','1955-12-09',30.9935483611371,'théatral','absurde',1012);
INSERT INTO ouvrage VALUES ('9780486202914','The Will to Believe  Human Immortality and Other Essays in Popular Philosophy',448,'en','https://m.media-amazon.com/images/I/51xBHo-FLuL.jpg','1956-01-06',46.2588799911363,'épistolaire','angoisse',1024);
INSERT INTO ouvrage VALUES ('9780486201122','The Philosophy of History',457,'de','https://m.media-amazon.com/images/I/51M082G8Z0L.jpg','1956-01-06',22.4549711878933,'argumentatif','éducation',1024);
INSERT INTO ouvrage VALUES ('9780486203942','Fads and Fallacies in the Name of Science',384,'en','https://m.media-amazon.com/images/I/51AEbPVV1CL._AC_SY780_.jpg','1957-01-06',50.3480263871103,'poétique','amour',1025);
INSERT INTO ouvrage VALUES ('9780385017336','Love Poems and Sonnets',160,'en','https://m.media-amazon.com/images/I/51SN6TFQ+cL._SX331_BO1,204,203,200_.jpg','1957-03-09',36.7417013333449,'théatral','amour',1026);
INSERT INTO ouvrage VALUES ('9780394415765','Atlas Shrugged',1168,'de','https://m.media-amazon.com/images/I/81-N8W4ZgUL.jpg','1957-12-10',18.778623081984,'narratif','amour',1027);
INSERT INTO ouvrage VALUES ('9780451621603','The Oedipus Plays of Sophocles',390,'en','https://kbimages1-a.akamaihd.net/01f78b9b-5988-4f1f-b3fd-c4def2d0e6b6/1200/1200/False/oedipus-rex-8.jpg','1958-01-09',42.29932645599,'narratif','argent',1028);
INSERT INTO ouvrage VALUES ('9780024021502','On Christian Doctrine',191,'en','https://m.media-amazon.com/images/I/51k1IdmME4L._AC_SY780_.jpg','1958-11-01',12.805596773063,'narratif','amour',1029);
INSERT INTO ouvrage VALUES ('9780394701493','Three Famous Short Novels: Spotted Horses Old Man the Bear',320,'en','https://m.media-amazon.com/images/I/91Ft1x3AQjL.jpg','1958-12-02',31.9547338135607,'narratif','économie',1030);
INSERT INTO ouvrage VALUES ('9780812416114','Lord of the Flies',208,'de','https://m.media-amazon.com/images/I/81jlbxMyR4L.jpg','1959-01-07',56.410627950478,'théatral','économie',1031);
INSERT INTO ouvrage VALUES ('9780717801336','The Modern Prince and Other Writings',192,'en','https://m.media-amazon.com/images/I/91kneJav00L.jpg','1959-01-10',51.9439362130167,'narratif','ambition',1032);
INSERT INTO ouvrage VALUES ('9780300000894','Psychoanalysis and Religion',126,'de','https://upload.wikimedia.org/wikipedia/en/c/cb/Psychoanalysis-and-religion-fromm-bkcover.jpg','1959-10-09',42.1191810692813,'théatral','absurde',1033);
INSERT INTO ouvrage VALUES ('9780394800769','Happy Birthday to You!',64,'en','https://m.media-amazon.com/images/I/51xHgwuohnL._SX359_BO1,204,203,200_.jpg','1959-12-08',27.4495302952333,'narratif','angoisse',1012);
INSERT INTO ouvrage VALUES ('9780425144305','Paws Before Dying (A Dog Lovers Mystery  #4)',197,'en','https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1388698125l/39361.jpg','1960-01-01',53.4245641968608,'théatral','éducation',1034);
INSERT INTO ouvrage VALUES ('9780393096231','Civilization and Its Discontents',121,'en','https://m.media-amazon.com/images/I/71uKQhCzsuL.jpg','1961-01-12',23.6481284928711,'épistolaire','amour',1035);
INSERT INTO ouvrage VALUES ('9780156701761','The Orwell Reader: Fiction  Essays  and Reportage',480,'en','https://m.media-amazon.com/images/I/41VodN4nx9L._SX329_BO1,204,203,200_.jpg','1961-08-03',41.1792159098271,'argumentatif','amour',1036);
INSERT INTO ouvrage VALUES ('9780670000968','Complete Short Stories  Vol 2',303,'de','https://m.media-amazon.com/images/I/915MWrHBfwL.jpg','1961-10-07',42.060586602782,'poétique','amour',1037);
INSERT INTO ouvrage VALUES ('9780394701844','The Town',371,'en','https://m.media-amazon.com/images/I/61mDRVrN4BL.jpg','1961-12-02',10.6479914768547,'théatral','argent',1030);



-- ================================= exemplaire ================================1
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2020-01-05','9782253096337');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-01-06','9782253096337');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2018-05-01','9782298011531');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2020-06-14','9782377601479');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2020-07-12','9782377601479');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2020-06-14','9782298011531');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2019-07-12','9782377601479');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-12-11','9782298011531');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2020-01-15','9780674990333');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2020-01-16','9780674990333');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2020-01-17','9780674990333');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (4,'2020-01-18','9780674990333');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2020-01-19','9780674990395');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2020-01-20','9780674990395');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2020-01-21','9780674990395');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (4,'2020-01-22','9780674990395');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2020-01-23','9780674991200');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2020-01-24','9780674991200');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2020-01-25','9780674991200');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2020-01-26','9780674991224');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2020-01-27','9780674991224');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2020-01-28','9780674991224');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-01','9780674991354');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-02','9780674991354');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-03','9780674991354');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (4,'2021-03-04','9780674991354');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-05','9780674991873');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-06','9780674991873');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-07','9780674991873');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (4,'2021-03-08','9780674991873');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (5,'2021-03-09','9780674991873');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-10','9780674992023');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-11','9780674992023');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-12','9780674992023');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (4,'2021-03-13','9780674992023');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (5,'2021-03-13','9780674992023');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (6,'2021-03-13','9780674992023');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9780891906797');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-13','9780891906797');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-13','9780891906797');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9780674992405');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-13','9780674992405');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-13','9780674992405');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9780674992559');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-13','9780674992559');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-13','9780674992559');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9781851588527');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-13','9781851588527');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-13','9781851588527');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (4,'2021-03-13','9781851588527');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-11','9780930330019');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-12','9780930330019');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9781117066035');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-13','9781117066035');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9780690134490');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-13','9780690134490');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9780394800837');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-13','9780394800837');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9780717802418');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-13','9780717802418');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-13','9780717802418');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9780439454001');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-13','9780439454001');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-13','9780439454001');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9780701106546');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-11','9780701106546');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-12','9780701106546');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9780553213607');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-13','9780553213607');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-13','9780553213607');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9780449015414');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-13','9780449015414');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-13','9780449015414');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9780822210894');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-13','9780822210894');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-13','9780822210894');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9780451526915');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-13','9780451526915');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-13','9780451526915');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9780440391548');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-11','9780440391548');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-12','9780440391548');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9780140446388');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-13','9780140446388');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-13','9780140446388');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9780394700021');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-13','9780394700021');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-13','9780394700021');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9780811200912');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-13','9780811200912');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-13','9780811200912');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9780394700137');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-13','9780394700137');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-13','9780394700137');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9780394800844');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-11','9780394800844');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-12','9780394800844');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9780486202914');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-13','9780486202914');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-13','9780486202914');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9780486201122');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-13','9780486201122');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-13','9780486201122');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9780486203942');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-13','9780486203942');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-13','9780486203942');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9780385017336');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-13','9780385017336');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-13','9780385017336');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9780394415765');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-11','9780394415765');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-12','9780394415765');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9780451621603');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-13','9780451621603');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-13','9780451621603');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9780024021502');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-13','9780024021502');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-13','9780024021502');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9780394701493');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-13','9780394701493');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-13','9780394701493');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9780812416114');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-13','9780812416114');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-13','9780812416114');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9780717801336');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-11','9780717801336');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-12','9780717801336');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9780300000894');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-13','9780300000894');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-13','9780300000894');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9780394800769');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-13','9780394800769');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-13','9780394800769');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9780425144305');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-13','9780425144305');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-13','9780425144305');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9780393096231');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-13','9780393096231');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-13','9780393096231');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9780156701761');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-13','9780156701761');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-11','9780156701761');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-12','9780670000968');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-13','9780670000968');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-13','9780670000968');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (1,'2021-03-13','9780394701844');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (2,'2021-03-13','9780394701844');
INSERT INTO exemplaire(num_exemp,date_achat_exmp,isbn_ouv) VALUES (3,'2021-03-13','9780394701844');


-- ================================= empreinter ================================1
INSERT INTO empreinter VALUES (1000003, 1, '2022-02-05', '2022-02-20', '2022-02-18');
INSERT INTO empreinter VALUES (1000004, 1, '2022-03-12', '2022-03-27', '2022-03-27');
INSERT INTO empreinter VALUES (1000003, 2, '2022-03-27', '2022-04-11', null);
INSERT INTO empreinter VALUES (1000003, 5, '2022-02-05', '2022-02-20', '2022-02-18');
INSERT INTO empreinter VALUES (1000004, 10, '2022-04-12', '2022-04-27', null);
INSERT INTO empreinter VALUES (1000003, 14, '2022-04-27', '2022-05-11', '2022-05-11');
INSERT INTO empreinter VALUES (1000003, 11, '2022-03-05', '2022-03-20', '2022-03-18');
INSERT INTO empreinter VALUES (1000004, 15, '2022-03-12', '2022-03-27', '2022-03-27');
INSERT INTO empreinter VALUES (1000003, 20, '2022-01-27', '2022-02-11', '2022-04-13');
INSERT INTO empreinter VALUES (1000003, 11, '2022-04-05', '2022-04-20', '2022-04-18');
INSERT INTO empreinter VALUES (1000004, 11, '2022-11-12', '2022-11-27', null);
INSERT INTO empreinter VALUES (1000003, 13, '2022-11-27', '2022-12-11', null);
INSERT INTO empreinter VALUES (1000003, 33, '2022-11-05', '2022-11-20', null);
INSERT INTO empreinter VALUES (1000004, 12, '2022-11-12', '2022-11-27', null);
INSERT INTO empreinter VALUES (1000003, 22, '2022-11-27', '2022-12-11', null);


-- ================================= ecrire ================================1
INSERT INTO ecrire VALUES (1000001,'9782298011531');
INSERT INTO ecrire VALUES (1000002,'9782377601479');
INSERT INTO ecrire VALUES (1000003,'9782253096337');
INSERT INTO ecrire VALUES (1000004,'9780674990333');
INSERT INTO ecrire VALUES (1000005,'9780674990395');
INSERT INTO ecrire VALUES (1000006,'9780674991200');
INSERT INTO ecrire VALUES (1000007,'9780674991224');
INSERT INTO ecrire VALUES (1000008,'9780674991354');
INSERT INTO ecrire VALUES (1000009,'9780674991873');
INSERT INTO ecrire VALUES (1000010,'9780674992023');
INSERT INTO ecrire VALUES (1000011,'9780891906797');
INSERT INTO ecrire VALUES (1000012,'9780674992405');
INSERT INTO ecrire VALUES (1000013,'9780674992559');
INSERT INTO ecrire VALUES (1000014,'9781851588527');
INSERT INTO ecrire VALUES (1000015,'9780930330019');
INSERT INTO ecrire VALUES (1000016,'9781117066035');
INSERT INTO ecrire VALUES (1000017,'9780690134490');
INSERT INTO ecrire VALUES (1000018,'9780394800837');
INSERT INTO ecrire VALUES (1000019,'9780717802418');
INSERT INTO ecrire VALUES (1000020,'9780439454001');
INSERT INTO ecrire VALUES (1000021,'9780701106546');
INSERT INTO ecrire VALUES (1000022,'9780553213607');
INSERT INTO ecrire VALUES (1000023,'9780449015414');
INSERT INTO ecrire VALUES (1000004,'9780822210894');
INSERT INTO ecrire VALUES (1000005,'9780451526915');
INSERT INTO ecrire VALUES (1000006,'9780440391548');
INSERT INTO ecrire VALUES (1000007,'9780140446388');
INSERT INTO ecrire VALUES (1000008,'9780394700021');
INSERT INTO ecrire VALUES (1000009,'9780811200912');
INSERT INTO ecrire VALUES (1000010,'9780394700137');
INSERT INTO ecrire VALUES (1000011,'9780394800844');
INSERT INTO ecrire VALUES (1000012,'9780486202914');
INSERT INTO ecrire VALUES (1000013,'9780486201122');
INSERT INTO ecrire VALUES (1000014,'9780486203942');
INSERT INTO ecrire VALUES (1000015,'9780385017336');
INSERT INTO ecrire VALUES (1000016,'9780394415765');
INSERT INTO ecrire VALUES (1000017,'9780451621603');
INSERT INTO ecrire VALUES (1000018,'9780024021502');
INSERT INTO ecrire VALUES (1000019,'9780394701493');
INSERT INTO ecrire VALUES (1000020,'9780812416114');
INSERT INTO ecrire VALUES (1000021,'9780717801336');
INSERT INTO ecrire VALUES (1000022,'9780300000894');
INSERT INTO ecrire VALUES (1000023,'9780394800769');
INSERT INTO ecrire VALUES (1000004,'9780425144305');
INSERT INTO ecrire VALUES (1000005,'9780393096231');
INSERT INTO ecrire VALUES (1000006,'9780156701761');
INSERT INTO ecrire VALUES (1000007,'9780670000968');
INSERT INTO ecrire VALUES (1000008,'9780394701844');
INSERT INTO ecrire VALUES (1000009,'9780674990333');
INSERT INTO ecrire VALUES (1000010,'9780674990395');
INSERT INTO ecrire VALUES (1000011,'9780674991200');
INSERT INTO ecrire VALUES (1000012,'9780674991224');
INSERT INTO ecrire VALUES (1000013,'9780674991354');
INSERT INTO ecrire VALUES (1000014,'9781117066035');
INSERT INTO ecrire VALUES (1000015,'9780690134490');
INSERT INTO ecrire VALUES (1000016,'9780717802418');
INSERT INTO ecrire VALUES (1000017,'9780439454001');
INSERT INTO ecrire VALUES (1000018,'9780701106546');
INSERT INTO ecrire VALUES (1000019,'9780553213607');
INSERT INTO ecrire VALUES (1000020,'9780449015414');
INSERT INTO ecrire VALUES (1000021,'9780822210894');
INSERT INTO ecrire VALUES (1000022,'9780451526915');
INSERT INTO ecrire VALUES (1000023,'9780440391548');
INSERT INTO ecrire VALUES (1000004,'9780140446388');
INSERT INTO ecrire VALUES (1000005,'9780486203942');
INSERT INTO ecrire VALUES (1000006,'9780385017336');
INSERT INTO ecrire VALUES (1000007,'9780394415765');
INSERT INTO ecrire VALUES (1000008,'9780425144305');
INSERT INTO ecrire VALUES (1000009,'9780393096231');
INSERT INTO ecrire VALUES (1000010,'9780156701761');
INSERT INTO ecrire VALUES (1000011,'9780670000968');
INSERT INTO ecrire VALUES (1000012,'9780394701844');
