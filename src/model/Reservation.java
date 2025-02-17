package model;

import java.time.LocalDateTime;

import java.time.LocalDateTime;
import java.util.Objects;

import annotation.Table;

@Table(prefixe = "RES")
public class Reservation {
    private String id;
    private LocalDateTime date_reservation;
    private String id_statut;
    private String id_type_siege;
    private String id_vol;
    private String id_utilisateur;

    // Constructeurs
    public Reservation() {}

    public Reservation(String id, LocalDateTime date_reservation, String id_statut, String id_type_siege, String id_vol, String id_utilisateur) {
        this.id = id;
        this.date_reservation = date_reservation;
        this.id_statut = id_statut;
        this.id_type_siege = id_type_siege;
        this.id_vol = id_vol;
        this.id_utilisateur = id_utilisateur;
    }

    // Getters et setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public LocalDateTime getDate_reservation() {
        return date_reservation;
    }

    public void setDate_reservation(LocalDateTime date_reservation) {
        this.date_reservation = date_reservation;
    }

    public String getId_statut() {
        return id_statut;
    }

    public void setId_statut(String id_statut) {
        this.id_statut = id_statut;
    }

    public String getId_type_siege() {
        return id_type_siege;
    }

    public void setId_type_siege(String id_type_siege) {
        this.id_type_siege = id_type_siege;
    }

    public String getId_vol() {
        return id_vol;
    }

    public void setId_vol(String id_vol) {
        this.id_vol = id_vol;
    }

    public String getId_utilisateur() {
        return id_utilisateur;
    }

    public void setId_utilisateur(String id_utilisateur) {
        this.id_utilisateur = id_utilisateur;
    }

    // Equals et hashCode
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Reservation that = (Reservation) o;
        return Objects.equals(id, that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    // toString
    @Override
    public String toString() {
        return "Reservation{" +
                "id='" + id + '\'' +
                ", date_reservation=" + date_reservation +
                ", id_statut='" + id_statut + '\'' +
                ", id_type_siege='" + id_type_siege + '\'' +
                ", id_vol='" + id_vol + '\'' +
                ", id_utilisateur='" + id_utilisateur + '\'' +
                '}';
    }
}