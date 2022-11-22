

-- Création base de données Pampidur


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
    photo_user BYTEA,
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
    
    CONSTRAINT pk_reserver PRIMARY KEY (id_adh,id_salle,dateTimeReserv),
    CONSTRAINT ck_datetimeresrv CHECK (dateTimeReserv<dateTimeFin),
    CONSTRAINT fk_reserver_adh FOREIGN KEY(id_adh) REFERENCES adherent(id_adh) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_reserver_salle FOREIGN KEY(id_salle) REFERENCES salle(id_salle) ON DELETE CASCADE ON UPDATE CASCADE

);


CREATE SEQUENCE edit_seq START 1001;
-- ================================= editeur ================================9
CREATE TABLE editeur (
    id_edit INT,
    nom_edit VARCHAR(60) NOT NULL,
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
    photo_aut BYTEA,
    dateNaiss_aut DATE,
    mvment_aut VARCHAR(25),

    CONSTRAINT pk_auteur PRIMARY KEY (id_aut),
    CONSTRAINT ck_id CHECK (id_aut>1000000 AND id_aut<10000000),
    CONSTRAINT ck_datenaissaut CHECK(dateNaiss_aut<=CURRENT_DATE)

);



-- ================================= ouvrage ================================11
CREATE TABLE ouvrage (
    isbn_ouv CHAR(13),
    titre_ouv VARCHAR(25) NOT NULL,
    nbr_page INT,
    langue_ouv CHAR(2),
    image_ouv BYTEA,
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
    dateRetour DATE NOT NULL,

    CONSTRAINT pk_empreinter PRIMARY KEY (id_adh,id_exemp,date_emp),
    CONSTRAINT ck_dateemp1 CHECK (date_emp<dateRetourPrevue),
    CONSTRAINT ck_dateemp2 CHECK (date_emp<dateRetour),
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