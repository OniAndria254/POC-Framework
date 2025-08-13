drop database if exists ticketing;

create database ticketing;

\c ticketing;

-- Table utilisateur
CREATE TABLE utilisateur (
    id VARCHAR(50) PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL DEFAULT 'USER', -- Ou Id_role INTEGER NOT NULL
    CONSTRAINT chk_role CHECK (role IN ('ADMIN', 'USER')) -- Si vous utilisez une contrainte CHECK
);

-- Table ville
CREATE TABLE ville (
    id VARCHAR(50) PRIMARY KEY,
    nom VARCHAR(50) NOT NULL
);

-- Table type_siege
CREATE TABLE type_siege (
    id VARCHAR(50) PRIMARY KEY,
    nom_type VARCHAR(50) NOT NULL
);

-- Table avion
CREATE TABLE avion (
    id VARCHAR(50) PRIMARY KEY,
    modele VARCHAR(50),
    date_fabrication DATE,
    siege_business INTEGER,
    siege_eco INTEGER
);

-- Table vol
CREATE TABLE vol (
    id VARCHAR(50) PRIMARY KEY,
    prix_business NUMERIC(15,2) NOT NULL,
    prix_eco NUMERIC(15,2) NOT NULL,
    date_depart TIMESTAMP,
    date_arrivee TIMESTAMP,
    Id_ville_depart VARCHAR(50) NOT NULL,
    Id_ville_arrivee VARCHAR(50) NOT NULL,
    Id_avion VARCHAR(50) NOT NULL,
    FOREIGN KEY (Id_ville_depart) REFERENCES ville(id),
    FOREIGN KEY (Id_ville_arrivee) REFERENCES ville(id),
    FOREIGN KEY (Id_avion) REFERENCES avion(id)
);

-- Table statut
CREATE TABLE statut (
    id VARCHAR(50) PRIMARY KEY,
    libelle VARCHAR(50) NOT NULL
);

-- Table reservation
-- Create a booking table to group reservations
CREATE TABLE booking (
    id VARCHAR(50) PRIMARY KEY,
    date_booking TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Id_utilisateur VARCHAR(50) NOT NULL,
    Id_vol VARCHAR(50) NOT NULL,
    FOREIGN KEY (Id_utilisateur) REFERENCES utilisateur(id),
    FOREIGN KEY (Id_vol) REFERENCES vol(id)
);

-- Modify reservation table to reference booking
CREATE TABLE reservation (
    id VARCHAR(50) PRIMARY KEY,
    Id_booking VARCHAR(50),
    passenger_type VARCHAR(50) NOT NULL, -- 'ADULT' or 'CHILD'
    date_reservation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Id_statut VARCHAR(50) NOT NULL,
    Id_type_siege VARCHAR(50) NOT NULL,
    Id_vol VARCHAR(50) NOT NULL,
    image_path VARCHAR(255),
    prix_reservation NUMERIC(15,2),
    FOREIGN KEY (Id_booking) REFERENCES booking(id),
    FOREIGN KEY (Id_statut) REFERENCES statut(id),
    FOREIGN KEY (Id_type_siege) REFERENCES type_siege(id),
    FOREIGN KEY (Id_vol) REFERENCES vol(id)
);


-- Table promotion
CREATE TABLE promotion (
    id VARCHAR(50) PRIMARY KEY,
    Id_vol VARCHAR(50) NOT NULL,
    Id_type_siege VARCHAR(50) NOT NULL,
    pourcentage_promotion INTEGER NOT NULL,
    nb_sieges_promotion INTEGER NOT NULL,
    nb_sieges_restants INTEGER DEFAULT 0,
    date_debut TIMESTAMP NOT NULL,
    date_fin TIMESTAMP NOT NULL,
    FOREIGN KEY (Id_vol) REFERENCES vol(id),
    FOREIGN KEY (Id_type_siege) REFERENCES type_siege(id)
);

-- Table config_reservation
CREATE TABLE config_reservation (
    id VARCHAR(50) PRIMARY KEY,
    date_config TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    nb_heure_res INTEGER,
    nb_heure_annulation INTEGER
);

CREATE TABLE config_enfant (
    id VARCHAR(50) PRIMARY KEY,
    date_config TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    pourcentage_prix INTEGER,
    age_limite INTEGER
);
