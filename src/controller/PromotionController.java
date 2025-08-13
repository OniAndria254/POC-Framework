package controller;

import java.sql.SQLException;
import java.util.List;

import database.GenericRepo;
import exception.MismatchException;
import mg.itu.prom16.annotation.Auth;
import mg.itu.prom16.annotation.ErrorPage;
import mg.itu.prom16.annotation.Get;
import mg.itu.prom16.annotation.MyControllerAnnotation;
import mg.itu.prom16.annotation.Param;
import mg.itu.prom16.annotation.Post;
import mg.itu.prom16.annotation.Url;
import mg.itu.prom16.model.ModelView;
import mg.itu.prom16.model.Utility;
import model.Avion;
import model.Promotion;
import model.TypeSiege;
import model.Ville;
import model.Vol;

@MyControllerAnnotation("promotion")
public class PromotionController {

    @Get
    @Auth(profile = "ADMIN")
    @Url(chemin = "/promotion/new")
    public ModelView savePage() throws SQLException, MismatchException {
        ModelView mv = new ModelView();

        try {
            List<Promotion> promotions = GenericRepo.findAll(Promotion.class);
            List<Vol> vols = GenericRepo.findAll(Vol.class);
            List<TypeSiege> typesSiege = GenericRepo.findAll(TypeSiege.class);

            mv.addObject("promotions", promotions);
            mv.addObject("vols", vols);
            mv.addObject("typesSiege", typesSiege);
            
        } catch (SQLException | MismatchException e) {
            e.printStackTrace();
        }

        mv.setUrl("/admin/promotion/new.jsp");
        return mv;
    }

    @Post
    @Auth(profile = "ADMIN")
    @Url(chemin = "/promotion/save")
    public ModelView savePromotion(@Param(paramName = "promotion") Promotion promotion) throws Exception{
        ModelView mv = new ModelView();
        promotion.setNb_sieges_restants(promotion.getNb_sieges_promotion());
        List<Promotion> promotions = GenericRepo.findAll(Promotion.class);
        List<Vol> vols = GenericRepo.findAll(Vol.class);
        List<TypeSiege> typesSiege = GenericRepo.findAll(TypeSiege.class);

        mv.addObject("promotions", promotions);
        mv.addObject("vols", vols);
        mv.addObject("typesSiege", typesSiege);
        if (Utility.isValid(promotion)) {
            GenericRepo.save(promotion);
            mv.setUrl("/admin/promotion/new.jsp");
        }
        else {
            mv.setErrorUrl("/promotion/new");
        }

        return mv;
    }

    
}
