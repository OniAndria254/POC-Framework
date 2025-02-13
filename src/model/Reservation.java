package model;

import java.time.LocalDateTime;

public class Reservation {
    private int id;
    private User user;
    private Vol vol;
    private String typeSiege; // "Business" ou "Eco"
    private LocalDateTime dateReservation;
    private String statut;

    // Constructeurs, getters et setters
    public Reservation() {}

    public Reservation(int id, User user, Vol vol, String typeSiege, LocalDateTime dateReservation, String statut) {
        this.id = id;
        this.user = user;
        this.vol = vol;
        this.typeSiege = typeSiege;
        this.dateReservation = dateReservation;
        this.statut = statut;
    }

    // Getters et setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
    public Vol getVol() { return vol; }
    public void setVol(Vol vol) { this.vol = vol; }
    public String getTypeSiege() { return typeSiege; }
    public void setTypeSiege(String typeSiege) { this.typeSiege = typeSiege; }
    public LocalDateTime getDateReservation() { return dateReservation; }
    public void setDateReservation(LocalDateTime dateReservation) { this.dateReservation = dateReservation; }
    public String getStatut() { return statut; }
    public void setStatut(String statut) { this.statut = statut; }
}