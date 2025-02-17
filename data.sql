-- Création des séquences
CREATE SEQUENCE seq_utilisateur START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_ville START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_type_siege START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_avion START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_vol START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_statut START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_reservation START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_promotion START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_config_reservation START WITH 1 INCREMENT BY 1;

-- Insertion des utilisateurs
INSERT INTO utilisateur (id, username, password, role)
VALUES ('USR' || nextval('seq_utilisateur'), 'admin', 'admin', 'ADMIN');

INSERT INTO utilisateur (id, username, password, role)
VALUES ('USR' || nextval('seq_utilisateur'), 'client1', 'client1', 'USER');

INSERT INTO utilisateur (id, username, password, role)
VALUES ('USR' || nextval('seq_utilisateur'), 'client2', 'client2', 'USER');

-- Insertion des villes
INSERT INTO ville (id, nom)
VALUES ('VIL' || nextval('seq_ville'), 'Paris'),
       ('VIL' || nextval('seq_ville'), 'New York'),
       ('VIL' || nextval('seq_ville'), 'Tokyo'),
       ('VIL' || nextval('seq_ville'), 'Londres');

-- Insertion des types de sièges
INSERT INTO type_siege (id, nom_type)
VALUES ('TYP' || nextval('seq_type_siege'), 'Business'),
       ('TYP' || nextval('seq_type_siege'), 'Eco');

-- Insertion des avions
INSERT INTO avion (id, modele, date_fabrication, siege_business, siege_eco)
VALUES ('AVI' || nextval('seq_avion'), 'Boeing 737', '2020-01-01', 20, 150),
       ('AVI' || nextval('seq_avion'), 'Airbus A320', '2019-05-15', 15, 120),
       ('AVI' || nextval('seq_avion'), 'Boeing 787', '2021-03-10', 30, 200);

-- Insertion des vols
INSERT INTO vol (id, prix_business, prix_eco, date_depart, date_arrivee, Id_ville_depart, Id_ville_arrivee, Id_avion)
VALUES ('VOL' || nextval('seq_vol'), 500.00, 200.00, '2025-01-15 14:00:00', '2025-01-15 20:00:00', 'VIL1', 'VIL2', 'AVI1'),
       ('VOL' || nextval('seq_vol'), 600.00, 250.00, '2025-01-16 10:00:00', '2025-01-16 18:00:00', 'VIL2', 'VIL3', 'AVI2'),
       ('VOL' || nextval('seq_vol'), 400.00, 150.00, '2025-01-17 08:00:00', '2025-01-17 12:00:00', 'VIL1', 'VIL4', 'AVI3');

-- Insertion des statuts
INSERT INTO statut (id, libelle)
VALUES ('STA' || nextval('seq_statut'), 'Reservé');

-- Insertion des réservations
INSERT INTO reservation (id, Id_statut, Id_type_siege, Id_vol, Id_utilisateur)
VALUES ('RES' || nextval('seq_reservation'), 'STA1', 'TYP1', 'VOL1', 'USR2'),
       ('RES' || nextval('seq_reservation'), 'STA1', 'TYP2', 'VOL2', 'USR2'),
       ('RES' || nextval('seq_reservation'), 'STA1', 'TYP2', 'VOL3', 'USR3');

-- Insertion des promotions
INSERT INTO promotion (id, Id_vol, Id_type_siege, pourcentage_promotion, nb_sieges_promotion, date_debut, date_fin)
VALUES ('PRO' || nextval('seq_promotion'), 'VOL1', 'TYP1', 10.00, 5, '2025-01-01 00:00:00', '2025-01-14 23:59:59'),
       ('PRO' || nextval('seq_promotion'), 'VOL2', 'TYP2', 15.00, 10, '2025-01-01 00:00:00', '2025-01-15 23:59:59'),
       ('PRO' || nextval('seq_promotion'), 'VOL3', 'TYP2', 20.00, 8, '2025-01-01 00:00:00', '2025-01-16 23:59:59');

-- Insertion de la configuration de réservation
INSERT INTO config_reservation (id, nb_heure_res, nb_heure_annulation)
VALUES ('CON' || nextval('seq_config_reservation'), 2, 1);
