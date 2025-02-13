-- Table pour stocker les informations sur les avions
CREATE TABLE avion (
    id SERIAL PRIMARY KEY,
    modele VARCHAR(100) NOT NULL,
    siege_business INT NOT NULL,
    siege_eco INT NOT NULL,
    date_fabrication DATE NOT NULL
);

-- Table pour stocker les informations sur les villes
CREATE TABLE ville (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL
);

-- Table pour stocker les informations sur les utilisateurs
CREATE TABLE user (
    id SERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL
);

-- Table pour stocker les informations sur les vols
CREATE TABLE vol (
    id SERIAL PRIMARY KEY,
    avion_id INT REFERENCES avion(id) ON DELETE CASCADE,
    ville_depart_id INT REFERENCES ville(id) ON DELETE CASCADE,
    ville_arrivee_id INT REFERENCES ville(id) ON DELETE CASCADE,
    date_depart TIMESTAMP NOT NULL,
    date_arrivee TIMESTAMP NOT NULL
);

-- Table pour stocker les réservations
CREATE TABLE reservation (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES user(id) ON DELETE CASCADE,
    vol_id INT REFERENCES vol(id) ON DELETE CASCADE,
    type_siege VARCHAR(50) NOT NULL CHECK (type_siege IN ('Business', 'Eco')), -- Pas besoin d'une table séparée
    date_reservation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    statut VARCHAR(50) DEFAULT 'confirmé'
);

-- Table pour stocker les promotions par vol
CREATE TABLE promotion (
    id SERIAL PRIMARY KEY,
    vol_id INT REFERENCES vol(id) ON DELETE CASCADE,
    type_siege VARCHAR(50) NOT NULL CHECK (type_siege IN ('Business', 'Eco')),
    pourcentage_promotion INT NOT NULL,
    date_debut TIMESTAMP NOT NULL,
    date_fin TIMESTAMP NOT NULL
);



-- Insertion d'un avion
INSERT INTO avion (modele, siege_business, siege_eco, date_fabrication)
VALUES ('Boeing 737', 20, 150, '2020-01-01');

-- Insertion de villes
INSERT INTO ville (nom) VALUES ('Paris'), ('New York');

-- Insertion d'un utilisateur
INSERT INTO user (username, password) VALUES ('Jean Dupont', '123456');

-- Insertion d'un vol
INSERT INTO vol (avion_id, ville_depart_id, ville_arrivee_id, date_depart, date_arrivee)
VALUES (1, 1, 2, '2023-10-15 14:00:00', '2023-10-15 20:00:00');

-- Insertion d'une promotion pour un vol
INSERT INTO promotion (vol_id, type_siege, pourcentage_promotion, date_debut, date_fin)
VALUES (1, 'Business', 10, '2023-10-01 00:00:00', '2023-10-14 23:59:59');

-- Insertion d'une réservation
INSERT INTO reservation (user_id, vol_id, type_siege, date_reservation, statut)
VALUES (1, 1, 'Business', '2023-10-10 10:00:00', 'confirmé');