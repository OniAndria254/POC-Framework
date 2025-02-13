package model;

import java.time.LocalDateTime;

public class Promotion {
    private int id;
    private Vol vol;
    private String typeSiege; // "Business" ou "Eco"
    private int pourcentagePromotion;
    private LocalDateTime dateDebut;
    private LocalDateTime dateFin;

    // Constructeurs, getters et setters
    public Promotion() {}

    public Promotion(int id, Vol vol, String typeSiege, int pourcentagePromotion, LocalDateTime dateDebut, LocalDateTime dateFin) {
        this.id = id;
        this.vol = vol;
        this.typeSiege = typeSiege;
        this.pourcentagePromotion = pourcentagePromotion;
        this.dateDebut = dateDebut;
        this.dateFin = dateFin;
    }

    // Getters et setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public Vol getVol() { return vol; }
    public void setVol(Vol vol) { this.vol = vol; }
    public String getTypeSiege() { return typeSiege; }
    public void setTypeSiege(String typeSiege) { this.typeSiege = typeSiege; }
    public int getPourcentagePromotion() { return pourcentagePromotion; }
    public void setPourcentagePromotion(int pourcentagePromotion) { this.pourcentagePromotion = pourcentagePromotion; }
    public LocalDateTime getDateDebut() { return dateDebut; }
    public void setDateDebut(LocalDateTime dateDebut) { this.dateDebut = dateDebut; }
    public LocalDateTime getDateFin() { return dateFin; }
    public void setDateFin(LocalDateTime dateFin) { this.dateFin = dateFin; }
}