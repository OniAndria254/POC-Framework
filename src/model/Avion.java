package model;

import java.sql.Date;
import java.util.Objects;

import annotation.Table;

@Table(nom = "avion", prefixe = "AVI")
public class Avion {
    private String id;
    private String modele;
    private Date date_fabrication;
    private int siege_business;
    private int siege_eco;

    // Constructeurs
    public Avion() {}

    public Avion(String id, String modele, Date date_fabrication, int siege_business, int siege_eco) {
        this.id = id;
        this.modele = modele;
        this.date_fabrication = date_fabrication;
        this.siege_business = siege_business;
        this.siege_eco = siege_eco;
    }

    // Getters et setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getModele() {
        return modele;
    }

    public void setModele(String modele) {
        this.modele = modele;
    }

    public Date getDate_fabrication() {
        return date_fabrication;
    }

    public void setDate_fabrication(Date date_fabrication) {
        this.date_fabrication = date_fabrication;
    }

    public int getSiege_business() {
        return siege_business;
    }

    public void setSiege_business(int siege_business) {
        this.siege_business = siege_business;
    }

    public int getSiege_eco() {
        return siege_eco;
    }

    public void setSiege_eco(int siege_eco) {
        this.siege_eco = siege_eco;
    }

    // Equals et hashCode
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Avion avion = (Avion) o;
        return Objects.equals(id, avion.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    // toString
    @Override
    public String toString() {
        return "Avion{" +
                "id='" + id + '\'' +
                ", modele='" + modele + '\'' +
                ", date_fabrication=" + date_fabrication +
                ", siege_business=" + siege_business +
                ", siege_eco=" + siege_eco +
                '}';
    }
}