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

        mv.setUrl("/admin/config/new.jsp"); // Redirection vers la liste des configurations après insertion
        return mv;
    }


    @Post
    @Auth(profile = "ADMIN")
    @Url(chemin = "/config/save")
    public ModelView save(@Param(paramName = "nb_heure_res") String nbHeureRes,
                          @Param(paramName = "nb_heure_annulation") String nbHeureAnnulation) {
        ModelView mv = new ModelView();
        ConfigReservation config = new ConfigReservation();

        try {
            config.setNb_heure_res(Integer.parseInt(nbHeureRes));
            config.setNb_heure_annulation(Integer.parseInt(nbHeureAnnulation));
            config.setDate_config(java.time.LocalDateTime.now());

            GenericRepo.save(config);

            List<ConfigReservation> configs = GenericRepo.findAll(ConfigReservation.class);
            mv.addObject("configs", configs);
        } catch (SQLException | MismatchException e) {
            e.printStackTrace();
        }

        mv.setUrl("/admin/config/new.jsp"); // Redirection vers la liste des configurations après insertion
        return mv;
    }
}
