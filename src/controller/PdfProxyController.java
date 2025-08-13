package controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import jakarta.servlet.http.HttpServletResponse;
import mg.itu.prom16.annotation.ConfigData;
import mg.itu.prom16.annotation.Get;
import mg.itu.prom16.annotation.MyControllerAnnotation;
import mg.itu.prom16.annotation.MyResponse;
import mg.itu.prom16.annotation.Param;
import mg.itu.prom16.annotation.Url;

@MyControllerAnnotation(value = "pdf")
public class PdfProxyController {

    @Get
    @Url(chemin = "/reservation/pdf")
    public void downloadReservationPdf(
            @Param(paramName = "id") String bookingId,
            @MyResponse HttpServletResponse response,
            @ConfigData(key = "pdfApiBaseUrl") String pdfApiBaseUrl) throws IOException {

        if (pdfApiBaseUrl == null) {
            pdfApiBaseUrl = "http://localhost:8081";
        }

        String apiUrl = pdfApiBaseUrl + "/api/reservations/pdf/" + bookingId;
        System.out.println("Appel API PDF : " + apiUrl);

        HttpURLConnection connection = null;
        try {
            URL url = new URL(apiUrl);
            connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.setConnectTimeout(5000);
            connection.setReadTimeout(15000);

            int statusCode = connection.getResponseCode();
            System.out.println("Réponse API PDF : " + statusCode);

            if (statusCode == HttpURLConnection.HTTP_OK) {
                // On ne fixe les headers qu'ici, quand on est sûr que le PDF est dispo
                response.reset();
                response.setContentType("application/pdf");
                response.setHeader("Content-Disposition", 
                    "attachment; filename=reservation_" + bookingId + ".pdf");

                try (InputStream is = connection.getInputStream();
                     OutputStream os = response.getOutputStream()) {
                    byte[] buffer = new byte[8192];
                    int bytesRead;
                    while ((bytesRead = is.read(buffer)) != -1) {
                        os.write(buffer, 0, bytesRead);
                    }
                    os.flush();
                }
            } else {
                // Réponse propre en cas d'erreur API
                response.reset();
                response.setStatus(statusCode);
                response.setContentType("text/plain; charset=UTF-8");

                try (InputStream es = connection.getErrorStream()) {
                    if (es != null) {
                        es.transferTo(response.getOutputStream());
                    } else {
                        response.getWriter().write(
                            "Erreur lors de la récupération du PDF (code " + statusCode + ")");
                    }
                }
            }

        } catch (IOException e) {
            // Erreur côté connexion ou lecture → réponse claire
            response.reset();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.setContentType("text/plain; charset=UTF-8");
            response.getWriter().write("Impossible de récupérer le PDF : " + e.getMessage());
            e.printStackTrace();
        } finally {
            if (connection != null) {
                connection.disconnect();
            }
        }
    }
}
