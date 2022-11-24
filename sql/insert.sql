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

INSERT INTO utilisateur VALUES 
(nextval('user_seq'),'admin', 'admin', '2000-01-01', 'admin@gmail.com', '$2y$10$zhrBgkUwDoldj.GGx.Pbiuffmt0wiiuIpooiwBcwLh0bVL4OcLTg2', NULL, NULL, NULL, NULL, NULL, TRUE);

INSERT INTO utilisateur VALUES 
(nextval('user_seq'),'doe', 'john', '1977-04-20', 'jd@gmail.com', '$2y$10$r2dF.LJpyU5dP4k74JZUce56PZ8XpO2A8fKdwEHIKv0RNSoXPcWJq', NULL, NULL, NULL, NULL, 'Paris',FALSE);

INSERT INTO utilisateur VALUES 
(nextval('user_seq'),'doe', 'jenna','1982-01-03', 'jenna@gmail.com', '$2y$10$BRd8q22P6d9pvh8Ej2u7xuGXnusDV8knHscuMiIT9qWCXX2cdbNhG', NULL, NULL, NULL, NULL, 'Lyon',FALSE);

INSERT INTO utilisateur VALUES 
(nextval('user_seq'),'beztout', 'ferhat','1997-02-03', 'deter@gmail.com', '$2y$10$Ho1V7/e35YsQVnnBwqEAB.g0V3bv7x5tpSWbaRNehwjxeCMU.cFDi', NULL, '0645976598','15 rue Bercy', '75012', 'Paris',FALSE);


-- ================================= adherent ================================1

INSERT INTO adherent VALUES 
(1000003, 'j3enn4');

INSERT INTO adherent VALUES 
(1000004, 'deter');


-- ================================= employe ================================1
INSERT INTO employe VALUES 
(1000001, 'admin', 'ALL', 3375.23);


INSERT INTO employe VALUES 
(1000002, 'bibliothécaire', 'READ', 2501.49);


-- ================================= carte ================================1
INSERT INTO carte VALUES 
(nextval('carte_seq'),  '2029-12-31', true, 1000002);

INSERT INTO carte VALUES 
(nextval('carte_seq'), '2025-05-20', true, 1000004);

INSERT INTO carte VALUES 
(nextval('carte_seq'), '2024-01-15', true, 1000003);


-- ================================= salle ================================1
INSERT INTO salle VALUES
('PC001', 'Carré', 0, 'B');

INSERT INTO salle VALUES
('PC002', 'Optimus', -1, 'A');

INSERT INTO salle VALUES
('EC001', 'Harry', 2, 'B');

INSERT INTO salle VALUES
('EC002', 'Vision', 0, 'E');

INSERT INTO salle VALUES
('EC003', 'Immersion', -2, 'C');

INSERT INTO salle VALUES
('NO001', 'Dragon', 1, 'A');

INSERT INTO salle VALUES
('NO002', 'Obsidienne', 3, 'B');


-- ================================= materiel ================================1
INSERT INTO materiel VALUES 
(nextval('materiel_seq'), 'Ordinateur', '2014-01-02', 466.99, 'PC001' );

INSERT INTO materiel VALUES 
(nextval('materiel_seq'), 'Ecran', '2016-01-02', 150.00, 'EC001' );

INSERT INTO materiel VALUES 
(nextval('materiel_seq'), 'Ecran', '2017-05-14', 195.00, 'EC002' );

INSERT INTO materiel VALUES 
(nextval('materiel_seq'), 'Ordinateur', '2015-12-30', 579.00, 'PC001' );

INSERT INTO materiel VALUES 
(nextval('materiel_seq'), 'Projecteur', '2012-05-28', 249.99, 'EC002' );

INSERT INTO materiel VALUES 
(nextval('materiel_seq'), 'Ordinateur', '2013-03-11', 900.00, 'PC002' );

INSERT INTO materiel VALUES 
(nextval('materiel_seq'), 'Ordinateur', '2016-11-16', 500.00, 'PC001' );

INSERT INTO materiel VALUES 
(nextval('materiel_seq'), 'Imprimante', '2016-07-24', 120.00, 'PC001' );

INSERT INTO materiel VALUES 
(nextval('materiel_seq'), 'Ordinateur', '2019-06-25', 500.00, 'PC002' );

INSERT INTO materiel VALUES 
(nextval('materiel_seq'), 'Scanner', '2015-04-30', 150.00, 'PC002' );

INSERT INTO materiel VALUES 
(nextval('materiel_seq'), 'Ordinateur', '2019-11-21', 650.00, 'PC001' );

INSERT INTO materiel VALUES 
(nextval('materiel_seq'), 'Ecran', '2016-04-16', 245.50, 'EC002');

INSERT INTO materiel VALUES 
(nextval('materiel_seq'), 'Ordinateur', '2015-05-05', 599.99, 'PC001' );

INSERT INTO materiel VALUES 
(nextval('materiel_seq'), 'Projecteur', '2012-12-17', 130.00, 'EC001' );


-- ================================= terminal ================================1
INSERT INTO terminal VALUES 
(nextval('terminal_seq'), 'term1', true, 'PC001');

INSERT INTO terminal VALUES 
(nextval('terminal_seq'), 'term2', true, 'PC002');

INSERT INTO terminal VALUES 
(nextval('terminal_seq'), 'term3', true, 'EC001');

INSERT INTO terminal VALUES 
(nextval('terminal_seq'), 'term4', false, 'EC002');

INSERT INTO terminal VALUES 
(nextval('terminal_seq'), 'term5', true, 'EC003');

INSERT INTO terminal VALUES 
(nextval('terminal_seq'), 'term6', true, 'NO001');

INSERT INTO terminal VALUES 
(nextval('terminal_seq'), 'term7', true, 'NO001');


-- ================================= reserver ================================1
INSERT INTO Reserver VALUES 
(1000004, 'PC001', '2022-11-16 11:30:00',  '2022-11-16 12:30:00');

INSERT INTO Reserver VALUES 
(1000003, 'EC001', '2022-11-25 10:00:00',  '2022-11-25 11:00:00');

INSERT INTO Reserver VALUES 
(1000004, 'PC001', '2022-11-17 10:00:00',  '2022-11-17 12:00:00');


-- ================================= editeur ================================1
INSERT INTO editeur VALUES 
(nextval('edit_seq'), 'lelivrescolaire.fr', '14 Rue Rhin et Danube, 69009 LYON', 'France' );

INSERT INTO editeur VALUES 
(nextval('edit_seq'), 'Fantastic Edition ', '15 rue du Berger, 75002 Paris', 'France' );

INSERT INTO editeur VALUES 
(nextval('edit_seq'), 'Paper House', 'Mohrenstrasse 37, 10117 Berlin', 'Allemagne' );



-- ================================= auteur ================================1
INSERT INTO auteur VALUES 
(nextval('aut_seq'), 'Meyer', 'Stephenine', NULL, NULL, '1973-12-24', 'romantisme');

INSERT INTO auteur VALUES 
(nextval('aut_seq'), 'Yvan', 'Monka', 'yvan.m@gmail.com', NULL, '1970-02-15');

INSERT INTO auteur VALUES 
(nextval('aut_seq'), 'Hugo', 'Victor', NULL, NULL, '1802-02-26', 'romantisme');

INSERT INTO auteur VALUES 
(nextval('aut_seq'), 'Dumas', 'Alexandre', NULL, NULL, '1802-07-24', 'romantisme');




-- ================================= ouvrage ================================1
INSERT INTO ouvrage VALUES
('9782298011531', 'fascination', 512, 'fr', NULL, '2005-10-05', 25.0, 'narratif', 'vampires', 1003 );

INSERT INTO ouvrage VALUES
('9782377601479', 'math 2de', 352, 'fr', NULL, '2010-02-05', 13.5, 'éducatif', 'maths', 1001 );

INSERT INTO ouvrage VALUES
('9782253096337', 'les misérables', 1630, 'fr', NULL, '1862-01-01', 13.9, 'narratif', 'amour', 1002 );



-- ================================= exemplaire ================================1
INSERT INTO exemplaire (num_exemp, date_achat_exmp, isbn_ouv) VALUES
(1, '2020-01-05', '9782253096337');

INSERT INTO exemplaire (num_exemp, date_achat_exmp, isbn_ouv) VALUES
(2, '2021-01-06', '9782253096337');

INSERT INTO exemplaire (num_exemp, date_achat_exmp, isbn_ouv) VALUES
(1, '2018-05-01 ', '9782298011531');

INSERT INTO exemplaire (num_exemp, date_achat_exmp, isbn_ouv) VALUES
(2, '2020-06-14', '9782377601479');

INSERT INTO exemplaire (num_exemp, date_achat_exmp, isbn_ouv) VALUES
(3, '2020-07-12', '9782377601479');

INSERT INTO exemplaire (num_exemp, date_achat_exmp, isbn_ouv) VALUES
(2, '2020-06-14', '9782298011531');

INSERT INTO exemplaire (num_exemp, date_achat_exmp, isbn_ouv) VALUES
(1, '2019-07-12', '9782377601479');

INSERT INTO exemplaire (num_exemp, date_achat_exmp, isbn_ouv) VALUES
(3, '2021-12-11 ', '9782298011531');


-- ================================= empreinter ================================1
INSERT INTO empreinter VALUES 
(1000003, 1, '2022-02-05', '2022-02-20', '2022-02-18');

INSERT INTO empreinter VALUES 
(1000004, 1, '2022-03-12', '2022-03-27', '2022-03-27');

INSERT INTO empreinter VALUES 
(1000003, 2, '2022-03-27', '2022-04-11', '2022-04-13');


-- ================================= ecrire ================================1
INSERT INTO ecrire VALUES 
(1000001, '9782298011531');

INSERT INTO ecrire VALUES 
(1000002, '9782377601479');

INSERT INTO ecrire VALUES 
(1000003, '9782253096337');