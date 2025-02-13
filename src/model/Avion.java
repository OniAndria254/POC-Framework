package model;

import java.time.LocalDate;

public class Avion {
    private int id;
    private String modele;
    private int siegeBusiness;
    private int siegeEco;
    private LocalDate dateFabrication;

    // Constructeurs, getters et setters
    public Avion() {}

    public Avion(int id, String modele, int siegeBusiness, int siegeEco, LocalDate dateFabrication) {
        this.id = id;
        this.modele = modele;
        this.siegeBusiness = siegeBusiness;
        this.siegeEco = siegeEco;
        this.dateFabrication = dateFabrication;
    }

    // Getters et setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getModele() { return modele; }
    public void setModele(String modele) { this.modele = modele; }
    public int getSiegeBusiness() { return siegeBusiness; }
    public void setSiegeBusiness(int siegeBusiness) { this.siegeBusiness = siegeBusiness; }
    public int getSiegeEco() { return siegeEco; }
    public void setSiegeEco(int siegeEco) { this.siegeEco = siegeEco; }
    public LocalDate getDateFabrication() { return dateFabrication; }
    public void setDateFabrication(LocalDate dateFabrication) { this.dateFabrication = dateFabrication; }
}