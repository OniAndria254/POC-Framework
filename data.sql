CREATE SEQUENCE UTILISATEUR_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE VIL_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE TYP_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE AVI_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE VOL_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE STA_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE RES_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE PRO_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE CON_SEQ START WITH 1 INCREMENT BY 1;

INSERT INTO utilisateur (Id_utilisateur, username, password, role)
VALUES ('USR' || nextval('UTILISATEUR_SEQ'), 'admin', 'admin123', 'ADMIN');

INSERT INTO utilisateur (Id_utilisateur, username, password, role)
VALUES ('USR' || nextval('UTILISATEUR_SEQ'), 'client1', 'client123', 'USER');

INSERT INTO utilisateur (Id_utilisateur, username, password, role)
VALUES ('USR' || nextval('UTILISATEUR_SEQ'), 'client2', 'client123', 'USER');


INSERT INTO ville (Id_ville, nom)
VALUES ('VIL' || nextval('VIL_SEQ'), 'Paris'),
       ('VIL' || nextval('VIL_SEQ'), 'New York'),
       ('VIL' || nextval('VIL_SEQ'), 'Tokyo'),
       ('VIL' || nextval('VIL_SEQ'), 'Londres');

INSERT INTO type_siege (Id_type_siege, nom_type)
VALUES ('TYP' || nextval('TYP_SEQ'), 'Business'),
       ('TYP' || nextval('TYP_SEQ'), 'Eco');

INSERT INTO avion (Id_avion, modele, date_fabrication, siege_business, siege_eco)
VALUES ('AVI' || nextval('AVI_SEQ'), 'Boeing 737', '2020-01-01', 20, 150),
       ('AVI' || nextval('AVI_SEQ'), 'Airbus A320', '2019-05-15', 15, 120),
       ('AVI' || nextval('AVI_SEQ'), 'Boeing 787', '2021-03-10', 30, 200);

INSERT INTO vol (Id_vol, prix_business, prix_eco, date_depart, date_arrivee, Id_ville_depart, Id_ville_arrivee, Id_avion)
VALUES ('VOL' || nextval('VOL_SEQ'), 500.00, 200.00, '2025-01-15 14:00:00', '2025-01-15 20:00:00', 'VIL1', 'VIL2', 'AVI1'),
       ('VOL' || nextval('VOL_SEQ'), 600.00, 250.00, '2025-01-16 10:00:00', '2025-01-16 18:00:00', 'VIL2', 'VIL3', 'AVI2'),
       ('VOL' || nextval('VOL_SEQ'), 400.00, 150.00, '2025-01-17 08:00:00', '2025-01-17 12:00:00', 'VIL1', 'VIL4', 'AVI3');

INSERT INTO statut (Id_statut, libelle)
VALUES ('STA' || nextval('STA_SEQ'), 'Reservé');

INSERT INTO reservation (Id_reservation, Id_statut, Id_type_siege, Id_vol, Id_utilisateur)
VALUES ('RES' || nextval('RES_SEQ'), 'STA1', 'TYP1', 'VOL1', 'USR2'),
       ('RES' || nextval('RES_SEQ'), 'STA1', 'TYP2', 'VOL2', 'USR2'),
       ('RES' || nextval('RES_SEQ'), 'STA1', 'TYP2', 'VOL3', 'USR3');

INSERT INTO promotion (Id_promotion, Id_vol, Id_type_siege, pourcentage_promotion, nb_sieges_promotion, date_debut, date_fin)
VALUES ('PRO' || nextval('PRO_SEQ'), 'VOL1', 'TYP1', 10.00, 5, '2025-01-01 00:00:00', '2025-01-14 23:59:59'),
       ('PRO' || nextval('PRO_SEQ'), 'VOL2', 'TYP2', 15.00, 10, '2025-01-01 00:00:00', '2025-01-15 23:59:59'),
       ('PRO' || nextval('PRO_SEQ'), 'VOL3', 'TYP2', 20.00, 8, '2025-01-01 00:00:00', '2025-01-16 23:59:59');

INSERT INTO config_reservation (Id_config_reservation, nb_heure_res, nb_heure_annulation)
VALUES ('CON' || nextval('CON_SEQ'), 2, 1);