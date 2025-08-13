package controller;

import database.GenericRepo;
import exception.MismatchException;
import mg.itu.prom16.annotation.*;
import mg.itu.prom16.model.AttributeSession;
import mg.itu.prom16.model.ModelView;
import mg.itu.prom16.model.MyFile;
import model.*;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@MyControllerAnnotation(value = "reservation")
public class ReservationController {
    AttributeSession sess;

    @Get
    @Auth(profile = "USER")
    @Url(chemin = "/reservation/list")
    public ModelView listReservation() throws SQLException, MismatchException {
        ModelView mv = new ModelView();
        Utilisateur utilisateur = (Utilisateur) sess.get("connectedUser");

        List<Booking> vrai = new ArrayList<>();
        List<Booking> bookings = GenericRepo.findCondition(Booking.class, " AND id_utilisateur = '" + utilisateur.getId() + "'");
        for (Booking booking : bookings) {
            List<Reservation> list = GenericRepo.findCondition(Reservation.class, " AND id_booking = '" + booking.getId() + "' AND id_statut = 'STA1'");
            if (list.size() > 0) {
                vrai.add(booking);
            }
        }
        
        mv.addObject("bookings", vrai);
        mv.setUrl("/user/reservation/list.jsp");
        return mv;
    }

    @Get
    @Auth(profile = "USER")
    @Url(chemin = "/reservation/new")
    public ModelView savePage(@Param(paramName = "id_vol") String id) throws SQLException, MismatchException {
        ModelView mv = new ModelView();
        List<Vol> vols = GenericRepo.findAll(Vol.class);
        List<Ville> villes = GenericRepo.findAll(Ville.class);
        List<Avion> avions = GenericRepo.findAll(Avion.class);
        List<TypeSiege> typeSieges = GenericRepo.findAll(TypeSiege.class);
        Vol izy = new Vol();
        for (Vol v : vols) {
            if (v.getId().equalsIgnoreCase(id)) {
                izy = v;
            }
        }
        mv.addObject("vol", izy);
        mv.addObject("vols", vols);
        mv.addObject("villes", villes);
        mv.addObject("avions", avions);
        mv.addObject("typeSieges", typeSieges);
        mv.setUrl("/user/reservation/new.jsp");
        return mv;
    }
 
    @Get
    @Auth(profile = "USER")
    @Url(chemin = "/reservation/cancel")
    public ModelView cancelReservation(@Param(paramName = "id") String id) {
        ModelView mv = new ModelView();
        
        try {
            String errorMessage = Reservation.cancelReservation(id);
            if (errorMessage != null) {
                mv.addObject("error", errorMessage);
                mv.setUrl("/user/reservation/error.jsp");
            } else {
                mv.setUrl("redirect:/reservation/list");
            }
        } catch (Exception e) {
            e.printStackTrace();
            mv.addObject("error", "Une erreur s'est produite lors de l'annulation : " + e.getMessage());
            mv.setUrl("/user/reservation/error.jsp");
        }
        
        return mv;
    }

    @Get
    @Auth(profile = "USER")
    @Url(chemin = "/reservation/save")
    public ModelView save(@Param(paramName = "reservation") Reservation reservation, 
                    @Param(paramName = "fileUpload") MyFile file,
                    @Param(paramName = "nb_enfants") String nb_enfants, 
                    @Param(paramName = "nb_adultes") String nb_adultes) {

        ModelView mv = new ModelView();
        
        try {
            int nbAdultesInt = Integer.parseInt(nb_adultes);
            int nbEnfantsInt = Integer.parseInt(nb_enfants);
            
            Utilisateur utilisateur = (Utilisateur) sess.get("connectedUser");
            String errorMessage = Reservation.createReservation(reservation, file, 
                                                            nbAdultesInt, nbEnfantsInt, 
                                                            utilisateur.getId());
            
            if (errorMessage != null) {
                mv.addObject("error", errorMessage);
                mv.setUrl("/user/reservation/error.jsp");
            } else {
                return this.savePage(null);
            }
        } catch (NumberFormatException e) {
            mv.addObject("error", "Le nombre d'adultes et d'enfants doit être un nombre valide.");
            mv.setUrl("/user/reservation/error.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            mv.addObject("error", "Une erreur s'est produite lors de la réservation : " + e.getMessage());
            mv.setUrl("/user/reservation/error.jsp");
        }
        
        return mv;
    }

    @Get
    @Auth(profile = "USER")
    @Url(chemin = "/reservation/details")
    public ModelView detailReservation(@Param(paramName = "id") String id) throws Exception{
        ModelView mv = new ModelView();
        
        Integer nb_adultes = Reservation.getNbPassager(id, "ADULT");
        Integer nb_enfants = Reservation.getNbPassager(id, "CHILD");
        Reservation temoin = Reservation.getReservationByIdBooking(id);
        List<Reservation> all = Reservation.getReservationsByIdBooking(id);

        mv.addObject("nb_adultes", nb_adultes);
        mv.addObject("nb_enfants", nb_enfants);
        mv.addObject("temoin", temoin);
        mv.addObject("all", all);
        mv.setUrl("/user/reservation/details.jsp");
        
        return mv;
    }

}
