package model;

import java.util.Objects;

import annotation.Table;

@Table(prefixe = "VIL")
public class Ville {
    private String id;
    private String nom;

    // Constructeurs
    public Ville() {}

    public Ville(String id, String nom) {
        this.id = id;
        this.nom = nom;
    }

    // Getters et setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    // Equals et hashCode
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Ville ville = (Ville) o;
        return Objects.equals(id, ville.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    // toString
    @Override
    public String toString() {
        return "Ville{" +
                "id='" + id + '\'' +
                ", nom='" + nom + '\'' +
                '}';
    }
}