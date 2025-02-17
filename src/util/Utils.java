package util;

import java.lang.reflect.Method;
import java.util.List;

import database.GenericRepo;
import model.Avion;
import model.Utilisateur;
import model.Ville;

public class Utils {

    public static String capitalizeFirstLetter(String input) {
        if (input == null || input.isEmpty()) {
            return input;
        }
        return input.substring(0, 1).toUpperCase() + input.substring(1);
    }

    public static void generateAttributesFromAnnotation(Object annotation, StringBuilder s, int nb, String className)throws Exception{
        Method[] methods = annotation.getClass().getDeclaredMethods();
        /*for(int i=0; i<methods.length; i++){
            if (methods[i].getName().contains(className)){
                System.out.println(methods[i].getName()+" "+methods[i].getParameterCount());
            }
        }*/
        for (int i=0; i<(int)(methods.length/nb); i++) {
            if(methods[i].getName().contains(className)){
                String value = (String) methods[i].invoke(annotation, null);

                String attribut = methods[i].getName().replace(className, "");

                if (!value.isEmpty()) {
                    s.append(" ").append(attribut).append("=\"").append(value).append("\"");
                }
            }
        }
    }

    public static String generateSubmitButton(){
        return "<button type=\"submit\" class=\"btn\">Valider</button>";
    }
    
    public static void validationGeneration (String annotation, String field, String s)throws Exception{
        if(s.equals("")){
            throw new Exception(annotation+" "+ field + " must not be empty");
        }
    }

    public static Utilisateur checkLogin(String username, String password) throws Exception {
        List<Utilisateur> all = GenericRepo.findAll(Utilisateur.class);
        for (Utilisateur utilisateur : all) {
            if (utilisateur.getUsername().equals(username) && utilisateur.getPassword().equals(password)) {
                return utilisateur;
            }
        }
        return null;
    }

    // Méthode pour récupérer le nom d'une ville à partir de son ID
    public static String getNomVille(String idVille, List<Ville> villes) {
        for (Ville ville : villes) {
            if (ville.getId().equals(idVille)) {
                return ville.getNom();
            }
        }
        return "Inconnu"; // Si l'ID de la ville ne correspond à aucune ville
    }

    public static String getModeleAvion(String idAvion, List<Avion> avions) {
        for (Avion avion : avions) {
            if (avion.getId().equals(idAvion)) {
                return avion.getModele();
            }
        }
        return "Inconnu"; // Si l'ID de la ville ne correspond à aucune ville
    }
}
