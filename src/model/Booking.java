package model;

import java.time.LocalDateTime;

import annotation.Table;

@Table(nom = "booking", prefixe = "BOK")
public class Booking {
    private String id;
    private LocalDateTime date_booking;
    private String id_utilisateur;
    private String id_vol;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public LocalDateTime getDate_booking() {
        return date_booking;
    }

    public void setDate_booking(LocalDateTime date_booking) {
        this.date_booking = date_booking;
    }

    public String getId_utilisateur() {
        return id_utilisateur;
    }

    public void setId_utilisateur(String id_utilisateur) {
        this.id_utilisateur = id_utilisateur;
    }

    public String getId_vol() {
        return id_vol;
    }

    public void setId_vol(String id_vol) {
        this.id_vol = id_vol;
    }
}
