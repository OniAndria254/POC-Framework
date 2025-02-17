package model;

import java.util.Objects;

import annotation.Table;

@Table(prefixe = "STA")
public class Statut {
    private String id;
    private String libelle;

    // Constructeurs
    public Statut() {}

    public Statut(String id, String libelle) {
        this.id = id;
        this.libelle = libelle;
    }

    // Getters et setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    // Equals et hashCode
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Statut statut = (Statut) o;
        return Objects.equals(id, statut.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    // toString
    @Override
    public String toString() {
        return "Statut{" +
                "id='" + id + '\'' +
                ", libelle='" + libelle + '\'' +
                '}';
    }
}