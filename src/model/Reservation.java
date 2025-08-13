package model;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

import annotation.Table;
import database.GenericRepo;
import exception.MismatchException;
import mg.itu.prom16.model.MyFile;

@Table(prefixe = "RES")
public class Reservation {
    private String id;
    private String id_booking;
    private String passenger_type;
    private LocalDateTime date_reservation;
    private String id_statut;
    private String id_type_siege;
    private String id_vol;
    private String image_path;
    private Double prix_reservation;

    // Constructeurs
    public Reservation() {}

    public Reservation(String id, LocalDateTime date_reservation, String id_statut, String id_type_siege, String id_vol) {
        this.id = id;
        this.date_reservation = date_reservation;
        this.id_statut = id_statut;
        this.id_type_siege = id_type_siege;
        this.id_vol = id_vol;
    }

    // Getters et setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getId_booking() {
        return id_booking;
    }

    public void setId_booking(String id_booking) {
        this.id_booking = id_booking;
    }

    public String getPassenger_type() {
        return passenger_type;
    }

    public void setPassenger_type(String passenger_type) {
        this.passenger_type = passenger_type;
    }

    public LocalDateTime getDate_reservation() {
        return date_reservation;
    }

    public void setDate_reservation(LocalDateTime date_reservation) {
        this.date_reservation = date_reservation;
    }

    public String getId_statut() {
        return id_statut;
    }

    public void setId_statut(String id_statut) {
        this.id_statut = id_statut;
    }

    public String getId_type_siege() {
        return id_type_siege;
    }

    public void setId_type_siege(String id_type_siege) {
        this.id_type_siege = id_type_siege;
    }

    public String getId_vol() {
        return id_vol;
    }

    public void setId_vol(String id_vol) {
        this.id_vol = id_vol;
    }

    public String getImage_path() {
        return image_path;
    }

    public void setImage_path(String image_path) {
        this.image_path = image_path;
    }

    public Double getPrix_reservation() {
        return prix_reservation;
    }

    public void setPrix_reservation(Double prix_reservation) {
        this.prix_reservation = prix_reservation;
    }

    // Equals et hashCode
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Reservation that = (Reservation) o;
        return Objects.equals(id, that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    public static void createMultipleReservations(String bookingId, Reservation baseReservation, 
                                        int nbAdults, String adultType,
                                        int nbChildren, String childType) throws SQLException, MismatchException {

        // Get latest config
        List<ConfigEnfant> configs = GenericRepo.findCondition(ConfigEnfant.class, " ORDER BY date_config DESC");
        ConfigEnfant latestConfig = configs.get(0);
        
        // Get vol for price calculation
        Vol vol = GenericRepo.findById(baseReservation.getId_vol(), Vol.class);
        Double basePrice = calculateBasePrice(vol, baseReservation.getId_type_siege());
        
        // Create adult reservations
        for (int i = 0; i < nbAdults; i++) {
            Reservation r = new Reservation();
            // Copy base reservation properties
            r.setId_booking(bookingId);
            r.setId_vol(baseReservation.getId_vol());
            r.setId_type_siege(baseReservation.getId_type_siege());
            r.setImage_path(baseReservation.getImage_path());
            r.setId_statut(baseReservation.getId_statut());
            r.setPassenger_type(adultType);
            r.setDate_reservation(baseReservation.getDate_reservation());
            
            // Apply promotion individually for each reservation
            try {
                Double finalPrice = applyPromotions(basePrice, baseReservation.getId_vol(), r);
                r.setPrix_reservation(finalPrice);
            } catch (Exception e) {
                r.setPrix_reservation(basePrice); // Fallback to base price if promotion fails
            }
            
            GenericRepo.save(r);
        }

        // Create child reservations with reduced price
        Double childDiscount = latestConfig.getPourcentage_prix() / 100.0;
        Double childBasePrice = basePrice * (1 - childDiscount);
        
        for (int i = 0; i < nbChildren; i++) {
            Reservation r = new Reservation();
            // Copy base reservation properties
            r.setId_booking(bookingId);
            r.setId_vol(baseReservation.getId_vol());
            r.setId_type_siege(baseReservation.getId_type_siege());
            r.setImage_path(baseReservation.getImage_path());
            r.setId_statut(baseReservation.getId_statut());
            r.setPassenger_type(childType);
            r.setDate_reservation(baseReservation.getDate_reservation());
            
            // Apply promotion individually for each child reservation
            try {
                Double finalPrice = applyPromotions(childBasePrice, baseReservation.getId_vol(), r);
                r.setPrix_reservation(finalPrice);
            } catch (Exception e) {
                r.setPrix_reservation(childBasePrice); // Fallback to child base price if promotion fails
            }
            
            GenericRepo.save(r);
        }
    }

    // public static void createMultipleReservations(String bookingId, Reservation baseReservation, 
    //                                             int nbAdults, String adultType,
    //                                             int nbChildren, String childType) throws Exception {
    //     // Create multiple reservations based on passenger counts
    //     for (int i = 0; i < nbAdults; i++) {
    //         createSingleReservation(bookingId, baseReservation, adultType);
    //     }
    //     for (int i = 0; i < nbChildren; i++) {
    //         createSingleReservation(bookingId, baseReservation, childType);
    //     }
    // }

    // private static void createSingleReservation(String bookingId, Reservation base, String passengerType) throws Exception {
    //     Reservation newReservation = new Reservation();
    //     newReservation.setId_booking(bookingId);
    //     newReservation.setPassenger_type(passengerType);
    //     newReservation.setId_vol(base.getId_vol());
    //     newReservation.setId_type_siege(base.getId_type_siege());
    //     newReservation.setImage_path(base.getImage_path());
    //     newReservation.setId_statut(base.getId_statut());
    //     newReservation.setPrix_reservation(base.getPrix_reservation());
    //     newReservation.setDate_reservation(base.getDate_reservation());

    //     System.out.println(newReservation.toString());
    //     GenericRepo.save(newReservation);
    // }
    public static String handleFileUpload(MyFile file) throws IOException {
        String savePath = "C:\\e-bossy\\S4\\Web Dyn\\POC-Framework\\files\\" + file.getFilename();
        try (InputStream input = file.getInputStream()) {
            Files.copy(input, Paths.get(savePath), StandardCopyOption.REPLACE_EXISTING);
        }
        return savePath;
    }

    public static Double applyPromotions(Double basePrice, String volId, Reservation reservation) throws Exception {
        String promotionCondition = " AND Id_vol = '" + volId + 
                                    "' AND Id_type_siege = '" + reservation.getId_type_siege() + 
                                    "' AND date_debut <= '" + reservation.getDate_reservation() + 
                                    "' AND date_fin >= '" + reservation.getDate_reservation() + "'";
        
        List<Promotion> activePromotions = GenericRepo.findCondition(Promotion.class, promotionCondition);
        
        if (!activePromotions.isEmpty()) {
            Promotion activePromotion = activePromotions.get(0);
            if (activePromotion.getNb_sieges_restants() > 0) {
                Double discount = basePrice * (activePromotion.getPourcentage_promotion() / 100.0);
                activePromotion.setNb_sieges_restants(activePromotion.getNb_sieges_restants() - 1);
                GenericRepo.update(activePromotion);
                return basePrice - discount;
            }
        }
        return basePrice;
    }

    public static Vol validateVolAndCapacity(Reservation reservation, int totalPassengers) throws Exception {
        // Get config reservation
        List<ConfigReservation> configs = GenericRepo.findAll(ConfigReservation.class);
        if (!configs.isEmpty()) {
            ConfigReservation config = configs.get(0);
            Vol vol = GenericRepo.findById(reservation.getId_vol(), Vol.class);
            
            // Check reservation time limit
            LocalDateTime limitTime = vol.getDate_depart().minusHours(config.getNb_heure_res());
            if (reservation.getDate_reservation().isAfter(limitTime)) {
                return null;
            }
    
            if (vol == null) return null;
            
            Avion avion = GenericRepo.findById(vol.getId_avion(), Avion.class);
            if (avion == null) return null;
    
            int capaciteDisponible = reservation.getId_type_siege().equals("TYP1") ?
                                    avion.getSiege_business() : avion.getSiege_eco();
                                   
            int nombrePlacesReservees = getNombreReservations(reservation.getId_vol(), reservation.getId_type_siege());
           
            if (nombrePlacesReservees + totalPassengers > capaciteDisponible) {
                return null;
            }
           
            return vol;
        }
        return null;
    }
    

    public static int getNombreReservations(String idVol, String idTypeSiege) throws SQLException, MismatchException {
        String condition = " AND Id_vol = '" + idVol + "' AND Id_type_siege = '" + idTypeSiege + "'";
        List<Reservation> reservations = GenericRepo.findCondition(Reservation.class, condition);
        return reservations.size();
    }

    public static Double calculateBasePrice(Vol vol, String idTypeSiege) {
        return idTypeSiege.equals("TYP1") ? vol.getPrix_business() : vol.getPrix_eco();
    }

    /**
     * Vérifie si une réservation peut être annulée selon les règles métier
     */
    public static boolean canCancelReservation(String reservationId) throws Exception {
        Reservation reservation = GenericRepo.findById(reservationId, Reservation.class);
        Vol vol = GenericRepo.findById(reservation.getId_vol(), Vol.class);
        
        // Récupérer la configuration de réservation la plus récente
        List<ConfigReservation> configs = GenericRepo.findCondition(ConfigReservation.class, " ORDER BY date_config DESC");
        if (configs.isEmpty()) {
            throw new Exception("Aucune configuration de réservation trouvée");
        }
        ConfigReservation config = configs.get(0);
        
        // Calculer la date limite d'annulation
        LocalDateTime dateDepart = vol.getDate_depart();
        LocalDateTime dateLimiteAnnulation = dateDepart.minusHours(config.getNb_heure_annulation());
        LocalDateTime maintenant = LocalDateTime.now();
        
        // Vérifier si l'annulation est faite dans le délai autorisé
        return !maintenant.isAfter(dateLimiteAnnulation);
    }

    /**
     * Annule une réservation si les conditions sont remplies
     * @return Message d'erreur ou null si succès
     */
    public static String cancelReservation(String reservationId) throws Exception {
        if (!canCancelReservation(reservationId)) {
            List<ConfigReservation> configs = GenericRepo.findCondition(ConfigReservation.class, " ORDER BY date_config DESC");
            ConfigReservation config = configs.get(0);
            return "L'annulation doit être faite au plus tard " + config.getNb_heure_annulation() + " heures avant le départ du vol.";
        }
        
        Reservation reservationToUpdate = GenericRepo.findById(reservationId, Reservation.class);
        reservationToUpdate.setId_statut("STA2"); // Status for cancelled reservation
        GenericRepo.save(reservationToUpdate);
        return null; // Pas d'erreur
    }

    /**
     * Crée une nouvelle réservation complète avec booking et validation
     * @return Message d'erreur ou null si succès
     */
    public static String createReservation(Reservation reservation, MyFile file, 
                                        int nbAdultes, int nbEnfants, String userId) throws Exception {
        try {
            // Handle file upload
            String imagePath = handleFileUpload(file);
            reservation.setImage_path(imagePath);

            // Create booking
            if (nbAdultes == 0 && nbEnfants == 0) {
                return "";
            }
            Booking booking = new Booking();
            booking.setId_vol(reservation.getId_vol());
            booking.setDate_booking(reservation.getDate_reservation());
            booking.setId_utilisateur(userId);
            booking = GenericRepo.save(booking);

            // Validate vol and capacity
            Vol vol = validateVolAndCapacity(reservation, nbAdultes + nbEnfants);
            if (vol == null) {
                List<ConfigReservation> configs = GenericRepo.findCondition(ConfigReservation.class, " ORDER BY date_config DESC");
                if (!configs.isEmpty()) {
                    ConfigReservation config = configs.get(0);

                    Vol tempVol = GenericRepo.findById(reservation.getId_vol(), Vol.class);
                    if (tempVol != null) {
                        LocalDateTime limitTime = tempVol.getDate_depart().minusHours(config.getNb_heure_res());
                        if (reservation.getDate_reservation().isAfter(limitTime)) {
                            return "La réservation doit être faite au moins " + config.getNb_heure_res() + " heures avant le départ.";
                        } else {
                            return "Il n'y a plus assez de places disponibles pour ce vol.";
                        }
                    } else {
                        return "Le vol sélectionné n'existe pas.";
                    }
                } else {
                    return "Erreur de configuration système.";
                }
            }

            // Create reservations for adults and children
            createMultipleReservations(booking.getId(), reservation, 
                                nbAdultes, "ADULT",
                                nbEnfants, "CHILD");

            return null; // Pas d'erreur
        } catch (Exception e) {
            e.printStackTrace();
            return "Une erreur s'est produite lors de la réservation: " + e.getMessage();
        }
    }


    @Override
    public String toString() {
        return "Reservation{" +
                "id='" + id + '\'' +
                ", id_booking='" + id_booking + '\'' +
                ", passenger_type='" + passenger_type + '\'' +
                ", date_reservation=" + date_reservation +
                ", id_statut='" + id_statut + '\'' +
                ", id_type_siege='" + id_type_siege + '\'' +
                ", id_vol='" + id_vol + '\'' +
                ", image_path='" + image_path + '\'' +
                ", prix_reservation=" + prix_reservation +
                '}';
    }

    public static Reservation getReservationByIdBooking(String id_booking) throws Exception {
        List<Reservation> list = GenericRepo.findCondition(Reservation.class, " AND id_booking = '" + id_booking + "' AND id_statut = 'STA1'");
        return list.get(0);

    }

    public static Integer getNbPassager(String id_booking, String passenger_type) throws Exception {
        List<Reservation> list = GenericRepo.findCondition(Reservation.class, " AND id_booking = '" + id_booking + "' AND passenger_type = '" + passenger_type + "' AND id_statut = 'STA1'");
        return list.size();
    }

    public static List<Reservation> getReservationsByIdBooking(String id_booking) throws Exception {
        List<Reservation> all = GenericRepo.findCondition(Reservation.class, " AND id_booking = '" + id_booking + "' AND id_statut = 'STA1'");
        return all;
    }

}


