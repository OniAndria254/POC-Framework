package model;

import java.time.LocalDateTime;
import java.time.LocalDateTime;
import java.util.Objects;

import annotation.Table;

@Table(nom = "promotion", prefixe = "PRO")
public class Promotion {
    private String id;
    private String id_vol;
    private String id_type_siege;
    private double pourcentage_promotion;
    private int nb_sieges_promotion;
    private LocalDateTime date_debut;
    private LocalDateTime date_fin;

    // Constructeurs
    public Promotion() {}

    public Promotion(String id, String id_vol, String id_type_siege, double pourcentage_promotion, int nb_sieges_promotion, LocalDateTime date_debut, LocalDateTime date_fin) {
        this.id = id;
        this.id_vol = id_vol;
        this.id_type_siege = id_type_siege;
        this.pourcentage_promotion = pourcentage_promotion;
        this.nb_sieges_promotion = nb_sieges_promotion;
        this.date_debut = date_debut;
        this.date_fin = date_fin;
    }

    // Getters et setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getId_vol() {
        return id_vol;
    }

    public void setId_vol(String id_vol) {
        this.id_vol = id_vol;
    }

    public String getId_type_siege() {
        return id_type_siege;
    }

    public void setId_type_siege(String id_type_siege) {
        this.id_type_siege = id_type_siege;
    }

    public double getPourcentage_promotion() {
        return pourcentage_promotion;
    }

    public void setPourcentage_promotion(double pourcentage_promotion) {
        this.pourcentage_promotion = pourcentage_promotion;
    }

    public int getNb_sieges_promotion() {
        return nb_sieges_promotion;
    }

    public void setNb_sieges_promotion(int nb_sieges_promotion) {
        this.nb_sieges_promotion = nb_sieges_promotion;
    }

    public LocalDateTime getDate_debut() {
        return date_debut;
    }

    public void setDate_debut(LocalDateTime date_debut) {
        this.date_debut = date_debut;
    }

    public LocalDateTime getDate_fin() {
        return date_fin;
    }

    public void setDate_fin(LocalDateTime date_fin) {
        this.date_fin = date_fin;
    }
}