-- 1️⃣ Vider toutes les tables en respectant les contraintes
TRUNCATE TABLE 
    reservation,
    booking,
    promotion,
    config_reservation,
    config_enfant,
    vol,
    avion,
    type_siege,
    ville,
    utilisateur,
    statut
RESTART IDENTITY CASCADE;

-- 2️⃣ Réinitialiser toutes les séquences explicitement
ALTER SEQUENCE seq_utilisateur RESTART WITH 1;
ALTER SEQUENCE seq_ville RESTART WITH 1;
ALTER SEQUENCE seq_type_siege RESTART WITH 1;
ALTER SEQUENCE seq_avion RESTART WITH 1;
ALTER SEQUENCE seq_vol RESTART WITH 1;
ALTER SEQUENCE seq_statut RESTART WITH 1;
ALTER SEQUENCE seq_reservation RESTART WITH 1;
ALTER SEQUENCE seq_promotion RESTART WITH 1;
ALTER SEQUENCE seq_config_reservation RESTART WITH 1;
ALTER SEQUENCE seq_booking RESTART WITH 1;

ALTER TABLE config_enfant
ALTER COLUMN id SET DEFAULT ('CEN' || nextval('seq_config_reservation'));












-- Insertion des utilisateurs
INSERT INTO utilisateur (id, username, password, role)
VALUES ('USR' || nextval('seq_utilisateur'), 'admin', 'admin', 'ADMIN'),
       ('USR' || nextval('seq_utilisateur'), 'client1', 'client1', 'USER'),
       ('USR' || nextval('seq_utilisateur'), 'client2', 'client2', 'USER');

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
VALUES ('VOL' || nextval('seq_vol'), 500.00, 200.00, '2025-08-15 14:00:00', '2025-08-15 20:00:00', 'VIL1', 'VIL2', 'AVI1'),
       ('VOL' || nextval('seq_vol'), 600.00, 250.00, '2025-08-16 10:00:00', '2025-08-16 18:00:00', 'VIL2', 'VIL3', 'AVI2'),
       ('VOL' || nextval('seq_vol'), 400.00, 150.00, '2025-08-17 08:00:00', '2025-08-17 12:00:00', 'VIL1', 'VIL4', 'AVI3');

-- Insertion des statuts
INSERT INTO statut (id, libelle)
VALUES ('STA' || nextval('seq_statut'), 'Reservé'),
       ('STA' || nextval('seq_statut'), 'Annulé');

-- Insertion des bookings
INSERT INTO booking (id, Id_utilisateur, Id_vol)
VALUES ('BOK' || nextval('seq_booking'), 'USR2', 'VOL1'),
       ('BOK' || nextval('seq_booking'), 'USR2', 'VOL2'),
       ('BOK' || nextval('seq_booking'), 'USR3', 'VOL3');

-- Insertion des réservations
INSERT INTO reservation (id, Id_booking, passenger_type, Id_statut, Id_type_siege, Id_vol, prix_reservation)
VALUES ('RES' || nextval('seq_reservation'), 'BOK1', 'ADULT', 'STA1', 'TYP1', 'VOL1', 500.00),
       ('RES' || nextval('seq_reservation'), 'BOK2', 'CHILD', 'STA1', 'TYP2', 'VOL2', 125.00),
       ('RES' || nextval('seq_reservation'), 'BOK3', 'ADULT', 'STA1', 'TYP2', 'VOL3', 150.00);

-- Insertion des promotions
INSERT INTO promotion (id, Id_vol, Id_type_siege, pourcentage_promotion, nb_sieges_promotion, nb_sieges_restants, date_debut, date_fin)
VALUES ('PRO' || nextval('seq_promotion'), 'VOL1', 'TYP1', 10, 5, 5, '2025-01-01 00:00:00', '2025-01-14 23:59:59'),
       ('PRO' || nextval('seq_promotion'), 'VOL2', 'TYP2', 15, 10, 10, '2025-01-01 00:00:00', '2025-01-15 23:59:59'),
       ('PRO' || nextval('seq_promotion'), 'VOL3', 'TYP2', 20, 8, 8, '2025-01-01 00:00:00', '2025-01-16 23:59:59');

-- Insertion de la configuration de réservation
INSERT INTO config_reservation (id, nb_heure_res, nb_heure_annulation)
VALUES ('CON' || nextval('seq_config_reservation'), 2, 1);

-- Insertion config enfant
INSERT INTO config_enfant (id, pourcentage_prix, age_limite)
VALUES ('CEN' || nextval('seq_config_reservation'), 50, 12);




-- Met à jour la date de départ d'un vol spécifique
-- Remplace les noms de table et colonnes si nécessaire

UPDATE vol
SET date_depart = '2025-08-12 22:30:00' -- nouvelle date et heure
WHERE id = 'VOL3'; -- l'ID du vol à modifier
