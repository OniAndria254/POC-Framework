package controller;



import java.sql.SQLException;
import java.util.List;

import database.GenericRepo;
import exception.MismatchException;
import mg.itu.prom16.annotation.Auth;
import mg.itu.prom16.annotation.MyControllerAnnotation;
import mg.itu.prom16.annotation.Param;
import mg.itu.prom16.annotation.Post;
import mg.itu.prom16.annotation.Url;
import mg.itu.prom16.model.ModelView;
import model.ConfigReservation;
import model.Promotion;

@MyControllerAnnotation("config")
public class ConfigReservationController {

    @Post
    @Auth(profile = "ADMIN")
    @Url(chemin = "/config/new")
    public ModelView savePage() {
        ModelView mv = new ModelView();
        // ConfigReservation config = new ConfigReservation();

        // try {
        //     // List<ConfigReservation> configs = GenericRepo.findAll(ConfigReservation.class);
        //     // mv.addObject("configs", configs);
        // } catch (SQLException | MismatchException e) {
        //     e.printStackTrace();
        // }

        mv.setUrl("/admin/config/new.jsp");
        return mv;
    }


    @Post
    @Auth(profile = "ADMIN")
    @Url(chemin = "/config/save")
    public ModelView save(@Param(paramName = "config") ConfigReservation configReservation) {
        ModelView mv = new ModelView();

        try {
            GenericRepo.save(configReservation);
            // System.out.println(configReservation.toString());

            // List<ConfigReservation> configs = GenericRepo.findAll(ConfigReservation.class);
            // mv.addObject("configs", configs);
        } catch (SQLException | MismatchException e) {
            e.printStackTrace();
        }
        mv.setUrl("redirect:/admin/config/new");

        return mv;
    }
}
