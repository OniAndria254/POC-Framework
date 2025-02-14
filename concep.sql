-- drop database if exists ticketing;

-- create database ticketing;

-- \c ticketing;

-- CREATE TABLE utilisateur(
--    Id_utilisateur SERIAL,
--    username VARCHAR(50)  NOT NULL,
--    password VARCHAR(255)  NOT NULL,
--    PRIMARY KEY(Id_utilisateur)
-- );

-- CREATE TABLE ville(
--    Id_ville SERIAL,
--    nom VARCHAR(50)  NOT NULL,
--    PRIMARY KEY(Id_ville)
-- );

-- CREATE TABLE type_siege(
--    Id_type_siege SERIAL,
--    nom_type VARCHAR(50)  NOT NULL,
--    PRIMARY KEY(Id_type_siege)
-- );

-- CREATE TABLE avion(
--    Id_avion SERIAL,
--    modele VARCHAR(50) ,
--    date_fabrication DATE,
--    siege_business INTEGER,
--    siege_eco INTEGER,
--    PRIMARY KEY(Id_avion)
-- );

-- CREATE TABLE vol(
--    Id_vol SERIAL,
--    prix_business NUMERIC(15,2)   NOT NULL,
--    prix_eco NUMERIC(15,2)   NOT NULL,
--    date_depart TIMESTAMP,
--    date_arrivee TIMESTAMP,
--    Id_ville_depart INTEGER NOT NULL,
--    Id_ville_arrivee INTEGER NOT NULL,
--    Id_avion INTEGER NOT NULL,
--    PRIMARY KEY(Id_vol),
--    FOREIGN KEY(Id_ville_depart) REFERENCES ville(Id_ville),
--    FOREIGN KEY(Id_ville_arrivee) REFERENCES ville(Id_ville),
--    FOREIGN KEY(Id_avion) REFERENCES avion(Id_avion)
-- );

-- CREATE TABLE statut(
--    Id_statut SERIAL,
--    libelle VARCHAR(50)  NOT NULL,
--    PRIMARY KEY(Id_statut)
-- );

-- CREATE TABLE reservation(
--    Id_reservation SERIAL,
--    date_reservation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--    Id_statut INTEGER NOT NULL,
--    Id_type_siege INTEGER NOT NULL,
--    Id_vol INTEGER NOT NULL,
--    Id_utilisateur INTEGER NOT NULL,
--    PRIMARY KEY(Id_reservation),
--    FOREIGN KEY(Id_statut) REFERENCES statut(Id_statut),
--    FOREIGN KEY(Id_type_siege) REFERENCES type_siege(Id_type_siege),
--    FOREIGN KEY(Id_vol) REFERENCES vol(Id_vol),
--    FOREIGN KEY(Id_utilisateur) REFERENCES utilisateur(Id_utilisateur)
-- );


-- CREATE TABLE promotion(
--    Id_promotion SERIAL,
--    pourcentage NUMERIC(15,2)   NOT NULL,
--    nb_sieges_promotion INTEGER NOT NULL,
--    nb_sieges_restant INTEGER,
--    date_debut TIMESTAMP,
--    date_fin TIMESTAMP,
--    Id_type_siege INTEGER NOT NULL,
--    Id_vol INTEGER NOT NULL,
--    PRIMARY KEY(Id_promotion),
--    FOREIGN KEY(Id_type_siege) REFERENCES type_siege(Id_type_siege),
--    FOREIGN KEY(Id_vol) REFERENCES vol(Id_vol)
-- );

-- CREATE TABLE config_reservation(
--    Id_config_reservation SERIAL,
--    nb_heure_res INTEGER,
--    nb_heure_annulation INTEGER,
--    date_config TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--    PRIMARY KEY(Id_config_reservation)
-- );


-- CREATE OR REPLACE FUNCTION check_delai_reservation() RETURNS TRIGGER AS $$
-- DECLARE
--     delai_reservation INTERVAL;
--     date_vol TIMESTAMP;
-- BEGIN
--     -- Récupérer le délai de réservation depuis la table config_reservation
--     SELECT nb_heure_res INTO delai_reservation
--     FROM config_reservation order by date_config DESC
--     LIMIT 1;

--     -- Convertir le nombre d'heures en intervalle
--     delai_reservation := delai_reservation || ' hours';

--     -- Récupérer la date de départ du vol
--     SELECT date_depart INTO date_vol
--     FROM vol
--     WHERE Id_vol = NEW.Id_vol;

--     -- Vérifier si la réservation est faite dans le délai
--     IF (date_vol - delai_reservation) < NOW() THEN
--         RAISE EXCEPTION 'La réservation doit être faite au moins % heures avant le vol.', delai_reservation;
--     END IF;

--     RETURN NEW;
-- END;
-- $$ LANGUAGE plpgsql;

-- -- Appliquer le trigger à la table reservation
-- CREATE TRIGGER trigger_delai_reservation
-- BEFORE INSERT ON reservation
-- FOR EACH ROW EXECUTE FUNCTION check_delai_reservation();



-- CREATE OR REPLACE FUNCTION check_delai_annulation() RETURNS TRIGGER AS $$
-- DECLARE
--     delai_annulation INTERVAL;
--     date_vol TIMESTAMP;
-- BEGIN
--     -- Récupérer le délai d'annulation depuis la table config_reservation
--     SELECT nb_heure_annulation INTO delai_annulation
--     FROM config_reservation order by date_config DESC
--     LIMIT 1;

--     -- Convertir le nombre d'heures en intervalle
--     delai_annulation := delai_annulation || ' hours';

--     -- Récupérer la date de départ du vol
--     SELECT date_depart INTO date_vol
--     FROM vol
--     WHERE Id_vol = OLD.Id_vol;

--     -- Vérifier si l'annulation est faite dans le délai
--     IF (date_vol - delai_annulation) < NOW() THEN
--         RAISE EXCEPTION 'L''annulation doit être faite au moins % heures avant le vol.', delai_annulation;
--     END IF;

--     RETURN OLD;
-- END;
-- $$ LANGUAGE plpgsql;

-- -- Appliquer le trigger à la table reservation
-- CREATE TRIGGER trigger_delai_annulation
-- BEFORE DELETE ON reservation
-- FOR EACH ROW EXECUTE FUNCTION check_delai_annulation();