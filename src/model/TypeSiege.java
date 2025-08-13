package model;

import java.util.Objects;

import annotation.Table;
import database.GenericRepo;

@Table(nom = "type_siege", prefixe = "TYP")
public class TypeSiege {
    private String id;
    private String nom_type;

    // Constructeurs
    public TypeSiege() {}

    public TypeSiege(String id, String nom_type) {
        this.id = id;
        this.nom_type = nom_type;
    }

    // Getters et setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNom_type() {
        return nom_type;
    }

    public void setNom_type(String nom_type) {
        this.nom_type = nom_type;
    }

    // Equals et hashCode
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TypeSiege typeSiege = (TypeSiege) o;
        return Objects.equals(id, typeSiege.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    // toString
    @Override
    public String toString() {
        return "TypeSiege{" +
                "id='" + id + '\'' +
                ", nom_type='" + nom_type + '\'' +
                '}';
    }
    
    public static TypeSiege getById(String id) throws Exception {
        return GenericRepo.findById(id, TypeSiege.class);
    }
}