package controller;

import java.sql.SQLException;
import java.text.AttributedCharacterIterator.Attribute;
import java.util.ArrayList;
import java.util.List;

import database.GenericRepo;
import exception.MismatchException;
import mg.itu.prom16.annotation.*;
import mg.itu.prom16.model.AttributeSession;
import mg.itu.prom16.model.ModelView;
import mg.itu.prom16.model.Utility;
import model.Avion;
import model.Utilisateur;
import model.Ville;
import model.Vol;

@MyControllerAnnotation("vol")
public class VolController {
    AttributeSession sess;
    
    @Get
    @Auth
    @Url(chemin = "/vol/list")
    public ModelView list() throws SQLException, MismatchException {
        ModelView mv = new ModelView();
        List<Vol> vols = GenericRepo.findAll(Vol.class);
        List<Ville> villes = GenericRepo.findAll(Ville.class);
        List<Avion> avions = GenericRepo.findAll(Avion.class);
        mv.addObject("vols", vols);
        mv.addObject("villes", villes);
        mv.addObject("avions", avions);

        Utilisateur u = (Utilisateur) sess.get("connectedUser");
        if(u.getRole().equals("ADMIN")) mv.setUrl("/admin/vol/list.jsp");
        else mv.setUrl("/user/vol/list.jsp");

        return mv;
    }


    @Get
    @Auth
    @Url(chemin = "/vol/filter")
    public ModelView filter(
        @Param(paramName = "id_ville_depart") String idVilleDepart,
        @Param(paramName = "id_ville_arrivee") String idVilleArrivee,
        @Param(paramName = "date_depart") String dateDepart,
        @Param(paramName = "date_arrivee") String dateArrivee,
        @Param(paramName = "prix_min") String prixMin,
        @Param(paramName = "prix_max") String prixMax,
        @Param(paramName = "id_avion") String idAvion) 
    {
        ModelView mv = new ModelView();
        List<Vol> vols = new ArrayList<>();
        List<Ville> villes;
        List<Avion> avions;
        
        try {
            // Construction dynamique de la clause WHERE
            StringBuilder whereClause = new StringBuilder();

            if (idVilleDepart != null && !idVilleDepart.isEmpty()) {
                whereClause.append(" AND Id_ville_depart = '").append(idVilleDepart).append("'");
            }
            if (idVilleArrivee != null && !idVilleArrivee.isEmpty()) {
                whereClause.append(" AND Id_ville_arrivee = '").append(idVilleArrivee).append("'");
            }
            if (dateDepart != null && !dateDepart.isEmpty()) {
                whereClause.append(" AND DATE(date_depart) = '").append(dateDepart).append("'");
            }
            if (dateArrivee != null && !dateArrivee.isEmpty()) {
                whereClause.append(" AND DATE(date_arrivee) = '").append(dateArrivee).append("'");
            }
            if (prixMin != null && !prixMin.isEmpty()) {
                whereClause.append(" AND prix_business >= ").append(prixMin);
            }
            if (prixMax != null && !prixMax.isEmpty()) {
                whereClause.append(" AND prix_business <= ").append(prixMax);
            }
            if (idAvion != null && !idAvion.isEmpty()) {
                whereClause.append(" AND Id_avion = '").append(idAvion).append("'");
            }

            // Requête avec la clause WHERE construite
            vols = GenericRepo.findCondition(Vol.class, whereClause.toString());
            villes = GenericRepo.findAll(Ville.class);
            avions = GenericRepo.findAll(Avion.class);

            // Ajouter les données filtrées à la vue
            mv.addObject("vols", vols);
            mv.addObject("villes", villes);
            mv.addObject("avions", avions);

        } catch (SQLException | MismatchException e) {
            e.printStackTrace();
        }

        Utilisateur u = (Utilisateur) sess.get("connectedUser");
        if(u.getRole().equals("ADMIN")) mv.setUrl("/admin/vol/list.jsp");
        else mv.setUrl("/user/vol/list.jsp");
        return mv;
    }



    @Get
    @Auth(profile = "ADMIN")
    @Url(chemin = "/vol/new")
    public ModelView savePage() throws SQLException, MismatchException {
        ModelView mv = new ModelView();
        List<Vol> vols = GenericRepo.findAll(Vol.class);
        List<Ville> villes = GenericRepo.findAll(Ville.class);
        List<Avion> avions = GenericRepo.findAll(Avion.class);
        mv.addObject("vols", vols);
        mv.addObject("villes", villes);
        mv.addObject("avions", avions);

        mv.setUrl("/admin/vol/new.jsp");
        return mv;
    }


    @Post
    @Auth(profile = "ADMIN")
    @Url(chemin = "/vol/save")
    public ModelView save(@Param(paramName = "vol") Vol vol) throws Exception {

        ModelView mv = new ModelView();

        if (Utility.isValid(vol)) {
            System.out.println("misave");
            GenericRepo.save(vol);
            mv.setUrl("redirect:/vol/list");
        }
        else {      
            mv.setErrorUrl("/vol/new");
        }
        return mv;
    }

    @Get
    @Auth(profile = "ADMIN")
    @Url(chemin = "/vol/edit")
    public ModelView editPage(@Param(paramName = "id") String id) throws SQLException, MismatchException {
        ModelView mv = new ModelView();
        Vol vol = GenericRepo.findById(id, Vol.class);
        List<Ville> villes = GenericRepo.findAll(Ville.class);
        List<Avion> avions = GenericRepo.findAll(Avion.class);
        
        mv.addObject("vol", vol);
        mv.addObject("villes", villes);
        mv.addObject("avions", avions);
        mv.setUrl("/admin/vol/new.jsp");

        return mv;
    }

    @Get
    @Auth(profile = "ADMIN")
    @Url(chemin = "/vol/delete")
    public ModelView delete(@Param(paramName = "id") String id) throws SQLException, MismatchException {
        Vol vol = GenericRepo.findById(id, Vol.class);
        GenericRepo.remove(vol);
        
        ModelView mv = new ModelView();
        mv.setUrl("redirect:/vol/list");
        return mv;
    }

}
