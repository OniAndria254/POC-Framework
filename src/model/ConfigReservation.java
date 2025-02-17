package model;
import java.time.LocalDateTime;

import annotation.Table;

@Table(nom = "config_reservation", prefixe = "CON")
public class ConfigReservation {

    private String id;
    private LocalDateTime date_config;
    private Integer nb_heure_res;
    private Integer nb_heure_annulation;

    // Constructors
    public ConfigReservation() {
    }

    public ConfigReservation(String id, LocalDateTime date_config, Integer nb_heure_res, Integer nb_heure_annulation) {
        this.id = id;
        this.date_config = date_config;
        this.nb_heure_res = nb_heure_res;
        this.nb_heure_annulation = nb_heure_annulation;
    }

    // Getters and Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public LocalDateTime getDate_config() {
        return date_config;
    }

    public void setDate_config(LocalDateTime date_config) {
        this.date_config = date_config;
    }

    public Integer getNb_heure_res() {
        return nb_heure_res;
    }

    public void setNb_heure_res(Integer nb_heure_res) {
        this.nb_heure_res = nb_heure_res;
    }

    public Integer getNb_heure_annulation() {
        return nb_heure_annulation;
    }

    public void setNb_heure_annulation(Integer nb_heure_annulation) {
        this.nb_heure_annulation = nb_heure_annulation;
    }
}
