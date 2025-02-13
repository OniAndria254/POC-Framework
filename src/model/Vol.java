package model;

import java.time.LocalDateTime;

public class Vol {
    private int id;
    private Avion avion;
    private Ville villeDepart;
    private Ville villeArrivee;
    private LocalDateTime dateDepart;
    private LocalDateTime dateArrivee;

    // Constructeurs, getters et setters
    public Vol() {}

    public Vol(int id, Avion avion, Ville villeDepart, Ville villeArrivee, LocalDateTime dateDepart, LocalDateTime dateArrivee) {
        this.id = id;
        this.avion = avion;
        this.villeDepart = villeDepart;
        this.villeArrivee = villeArrivee;
        this.dateDepart = dateDepart;
        this.dateArrivee = dateArrivee;
    }

    // Getters et setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public Avion getAvion() { return avion; }
    public void setAvion(Avion avion) { this.avion = avion; }
    public Ville getVilleDepart() { return villeDepart; }
    public void setVilleDepart(Ville villeDepart) { this.villeDepart = villeDepart; }
    public Ville getVilleArrivee() { return villeArrivee; }
    public void setVilleArrivee(Ville villeArrivee) { this.villeArrivee = villeArrivee; }
    public LocalDateTime getDateDepart() { return dateDepart; }
    public void setDateDepart(LocalDateTime dateDepart) { this.dateDepart = dateDepart; }
    public LocalDateTime getDateArrivee() { return dateArrivee; }
    public void setDateArrivee(LocalDateTime dateArrivee) { this.dateArrivee = dateArrivee; }
}