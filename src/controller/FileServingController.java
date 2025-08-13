package controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mg.itu.prom16.annotation.Get;
import mg.itu.prom16.annotation.MyControllerAnnotation;
import mg.itu.prom16.annotation.Url;

@MyControllerAnnotation("file")
public class FileServingController {

    @Get
    @Url(chemin = "/file/view")
    public void serveFile(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String filePath = request.getParameter("path");
        System.out.println(filePath);
        
        if (filePath == null || filePath.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Chemin de fichier non spécifié");
            return;
        }
        
        File file = new File(filePath);
        
        if (!file.exists() || !file.isFile()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Fichier non trouvé");
            return;
        }
        
        // Déterminer le type MIME
        String contentType = "application/octet-stream";
        if (filePath.toLowerCase().endsWith(".pdf")) {
            contentType = "application/pdf";
        } else if (filePath.toLowerCase().endsWith(".jpg") || filePath.toLowerCase().endsWith(".jpeg")) {
            contentType = "image/jpeg";
        } else if (filePath.toLowerCase().endsWith(".png")) {
            contentType = "image/png";
        } else if (filePath.toLowerCase().endsWith(".gif")) {
            contentType = "image/gif";
        }
        
        response.setContentType(contentType);
        response.setContentLength((int) file.length());
        
        // Copier le fichier dans le flux de sortie
        try (FileInputStream in = new FileInputStream(file);
             OutputStream out = response.getOutputStream()) {
            
            byte[] buffer = new byte[4096];
            int bytesRead;
            
            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
        }
    }
}
