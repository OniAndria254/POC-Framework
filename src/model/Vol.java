package model;

import java.time.LocalDateTime;

import java.time.LocalDateTime;
import java.util.Objects;

import annotation.Colonne;
import annotation.Table;

@Table(nom = "vol", prefixe = "VOL")
public class Vol {
    // @Colonne(value = "id_vol")
    private String id;
    private double prix_business;
    private double prix_eco;
    private LocalDateTime date_depart;
    private LocalDateTime date_arrivee;
    private String id_ville_depart;
    private String id_ville_arrivee;
    private String id_avion;

    // Constructeurs
    public Vol() {}

    public Vol(String id, double prix_business, double prix_eco, LocalDateTime date_depart, LocalDateTime date_arrivee, String id_ville_depart, String id_ville_arrivee, String id_avion) {
        this.id = id;
        this.prix_business = prix_business;
        this.prix_eco = prix_eco;
        this.date_depart = date_depart;
        this.date_arrivee = date_arrivee;
        this.id_ville_depart = id_ville_depart;
        this.id_ville_arrivee = id_ville_arrivee;
        this.id_avion = id_avion;
    }

    // Getters et setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public double getPrix_business() {
        return prix_business;
    }

    public void setPrix_business(double prix_business) {
        this.prix_business = prix_business;
    }

    public double getPrix_eco() {
        return prix_eco;
    }

    public void setPrix_eco(double prix_eco) {
        this.prix_eco = prix_eco;
    }

    public LocalDateTime getDate_depart() {
        return date_depart;
    }

    public void setDate_depart(LocalDateTime date_depart) {
        this.date_depart = date_depart;
    }

    public LocalDateTime getDate_arrivee() {
        return date_arrivee;
    }

    public void setDate_arrivee(LocalDateTime date_arrivee) {
        this.date_arrivee = date_arrivee;
    }

    public String getId_ville_depart() {
        return id_ville_depart;
    }

    public void setId_ville_depart(String id_ville_depart) {
        this.id_ville_depart = id_ville_depart;
    }

    public String getId_ville_arrivee() {
        return id_ville_arrivee;
    }

    public void setId_ville_arrivee(String id_ville_arrivee) {
        this.id_ville_arrivee = id_ville_arrivee;
    }

    public String getId_avion() {
        return id_avion;
    }

    public void setId_avion(String id_avion) {
        this.id_avion = id_avion;
    }

    // Equals et hashCode
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Vol vol = (Vol) o;
        return Objects.equals(id, vol.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    // toString
    @Override
    public String toString() {
        return "Vol{" +
                "id='" + id + '\'' +
                ", prix_business=" + prix_business +
                ", prix_eco=" + prix_eco +
                ", date_depart=" + date_depart +
                ", date_arrivee=" + date_arrivee +
                ", id_ville_depart='" + id_ville_depart + '\'' +
                ", id_ville_arrivee='" + id_ville_arrivee + '\'' +
                ", id_avion='" + id_avion + '\'' +
                '}';
    }
}