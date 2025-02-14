drop database if exists ticketing;

create database ticketing;

\c ticketing;

-- Table utilisateur
CREATE TABLE utilisateur (
    Id_utilisateur VARCHAR(50) PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL DEFAULT 'USER', -- Ou Id_role INTEGER NOT NULL
    CONSTRAINT chk_role CHECK (role IN ('ADMIN', 'USER')) -- Si vous utilisez une contrainte CHECK
);

-- Table ville
CREATE TABLE ville (
    Id_ville VARCHAR(50) PRIMARY KEY,
    nom VARCHAR(50) NOT NULL
);

-- Table type_siege
CREATE TABLE type_siege (
    Id_type_siege VARCHAR(50) PRIMARY KEY,
    nom_type VARCHAR(50) NOT NULL
);

-- Table avion
CREATE TABLE avion (
    Id_avion VARCHAR(50) PRIMARY KEY,
    modele VARCHAR(50),
    date_fabrication DATE,
    siege_business INTEGER,
    siege_eco INTEGER
);

-- Table vol
CREATE TABLE vol (
    Id_vol VARCHAR(50) PRIMARY KEY,
    prix_business NUMERIC(15,2) NOT NULL,
    prix_eco NUMERIC(15,2) NOT NULL,
    date_depart TIMESTAMP,
    date_arrivee TIMESTAMP,
    Id_ville_depart VARCHAR(50) NOT NULL,
    Id_ville_arrivee VARCHAR(50) NOT NULL,
    Id_avion VARCHAR(50) NOT NULL,
    FOREIGN KEY (Id_ville_depart) REFERENCES ville(Id_ville),
    FOREIGN KEY (Id_ville_arrivee) REFERENCES ville(Id_ville),
    FOREIGN KEY (Id_avion) REFERENCES avion(Id_avion)
);

-- Table statut
CREATE TABLE statut (
    Id_statut VARCHAR(50) PRIMARY KEY,
    libelle VARCHAR(50) NOT NULL
);

-- Table reservation
CREATE TABLE reservation (
    Id_reservation VARCHAR(50) PRIMARY KEY,
    date_reservation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Id_statut VARCHAR(50) NOT NULL,
    Id_type_siege VARCHAR(50) NOT NULL,
    Id_vol VARCHAR(50) NOT NULL,
    Id_utilisateur VARCHAR(50) NOT NULL,
    FOREIGN KEY (Id_statut) REFERENCES statut(Id_statut),
    FOREIGN KEY (Id_type_siege) REFERENCES type_siege(Id_type_siege),
    FOREIGN KEY (Id_vol) REFERENCES vol(Id_vol),
    FOREIGN KEY (Id_utilisateur) REFERENCES utilisateur(Id_utilisateur)
);

-- Table promotion
CREATE TABLE promotion (
    Id_promotion VARCHAR(50) PRIMARY KEY,
    Id_vol VARCHAR(50) NOT NULL,
    Id_type_siege VARCHAR(50) NOT NULL,
    pourcentage_promotion NUMERIC(5,2) NOT NULL,
    nb_sieges_promotion INTEGER NOT NULL,
    date_debut TIMESTAMP NOT NULL,
    date_fin TIMESTAMP NOT NULL,
    FOREIGN KEY (Id_vol) REFERENCES vol(Id_vol),
    FOREIGN KEY (Id_type_siege) REFERENCES type_siege(Id_type_siege)
);

-- Table config_reservation
CREATE TABLE config_reservation (
    Id_config_reservation VARCHAR(50) PRIMARY KEY,
    date_config TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    nb_heure_res INTEGER,
    nb_heure_annulation INTEGER
);