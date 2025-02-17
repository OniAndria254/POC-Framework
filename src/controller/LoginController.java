package controller;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

import database.GenericRepo;
import exception.MismatchException;
import mg.itu.prom16.annotation.*;
import mg.itu.prom16.model.*; 
import model.*;
import util.Utils;

@MyControllerAnnotation("login")
public class LoginController {
    AttributeSession sess;

    @Get
    @Restapi
    @Url(chemin = "/emp/name")
    public ModelView getEmp2002() {
        ModelView mv = new ModelView();
        Employe employe = new Employe();
        LocalDate localDate = LocalDate.of(2002, 9, 27);
        employe.setDtn(localDate);
        mv.setUrl("/listeEmp.jsp");
        mv.addObject("emp", employe);
        return mv;
    }

    @Post
    @Restapi
    @Url(chemin = "/emp/name")
    public ModelView getEmp2004() {
        ModelView mv = new ModelView();
        Employe employe = new Employe();
        LocalDate localDate = LocalDate.of(2004, 9, 27);
        employe.setDtn(localDate);
        mv.setUrl("/listeEmp.jsp");
        mv.addObject("emp", employe);
        return mv;
    }

    @Get
    public ModelView redirectFormulaire() {
        ModelView mv = new ModelView();
        mv.setUrl("/form.jsp");
        return mv;
    }

    

    @Restapi
    @Get
    public ModelView redirectLogin() {
        ModelView mv = new ModelView();
        mv.setUrl("/login.jsp");
        return mv;
    }

    @Url(chemin = "/emp/name")
    @Post
    public ModelView redirect(@Param(paramName = "nom") String name, @Param(paramName = "age") String myage) {
        ModelView mv = new ModelView();
        // System.out.println("name");
        mv.addObject("anarana", name);
        mv.addObject("taona", myage);

        mv.setUrl("/affichage.jsp");
        
        return mv;
    }

    @Get
    public ModelView redirectAffichage2(@Param(paramName = "emp")Employe emp, String test) {
        ModelView mv = new ModelView();
        // System.out.println("name");
        mv.addObject("employe", emp);
        mv.addObject("test", test);


        mv.setUrl("/affichage.jsp");
        
        return mv;
    }

    @Get
    @Url(chemin = "/emp/form")
    public ModelView redirectFormulaire2() {
        ModelView mv = new ModelView();
        mv.setUrl("/form2.jsp");
        return mv;
    }

    @Post
    @Url(chemin = "/emp/androany")
    public ModelView redirectAffichage(@Param(paramName = "emp") Employe emp) {
        ModelView mv = new ModelView();
        mv.setErrorUrl("/form2.jsp");
        mv.addObject("employe", emp);
        // mv.addObject("test", test);


        mv.setUrl("/affichage.jsp");
        
        return mv;
    }

    @Get
    @Url(chemin = "/disconnect")
    public ModelView destroySession() {
        ModelView mv = new ModelView();
        sess.destroy();
        mv.setUrl("/login.jsp");
        return mv;
    }













    // Public login page access
    @Get
    @Url(chemin = "/login")
    public ModelView loginPage() {
        ModelView mv = new ModelView();
        mv.setUrl("/login.jsp");
        return mv;
    }

    // Login processing
    @Post
    @Url(chemin = "/login/process")
    public ModelView processLogin(@Param(paramName = "username") String username, 
                                @Param(paramName = "password") String password) {
        ModelView mv = new ModelView();
        Utilisateur u = null;
        try {
            u = Utils.checkLogin(username, password);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        if (u == null) {
            mv.setUrl("/login.jsp");
            mv.addObject("errorMessage", "Vérifiez vos informations");
        }

        else if(u.getRole().equals("ADMIN")) {
            sess.update("connectedUser", u);
            sess.update("userProfile", u.getRole());
            mv.setUrl("/admin/dashboard");
        }
        else {
            sess.update("connectedUser", u);
            sess.update("userProfile", u.getRole());
            mv.setUrl("/user/dashboard");
        }
        
        return mv;
    }

    // Protected admin route
    @Get
    @Auth(profile = "ADMIN")
    @Url(chemin = "/admin/dashboard")
    public ModelView adminDashboard() {
        ModelView mv = new ModelView();
        mv.setUrl("/admin/dashboard.jsp");
        mv.addObject("message", "Welcome Admin!");
        return mv;
    }

    // Protected user route
    @Get
    @Auth(profile = "USER")
    @Url(chemin = "/user/dashboard")
    public ModelView userDashboard() {
        ModelView mv = new ModelView();
        mv.setUrl("/user/dashboard.jsp");
        mv.addObject("message", "Welcome User!");
        return mv;
    }

    // Protected route for any authenticated user
    @Get
    @Auth
    @Url(chemin = "/profile")
    public ModelView userProfile() {
        ModelView mv = new ModelView();
        mv.setUrl("/profile.jsp");
        mv.addObject("username", sess.get("connectedUser"));
        return mv;
    }

    // Logout function
    @Get
    @Url(chemin = "/logout")
    public ModelView logout() {
        sess.destroy();
        ModelView mv = new ModelView();
        mv.setUrl("/login.jsp");
        mv.addObject("message", "Successfully logged out");
        return mv;
    }

}