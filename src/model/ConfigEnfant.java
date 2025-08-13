package model;
import java.time.LocalDateTime;
import annotation.Table;

@Table(nom = "config_enfant", prefixe = "CONF")
public class ConfigEnfant {
    private String id;
    private LocalDateTime date_config;
    private Integer pourcentage_prix;
    private Integer age_limite;

    public ConfigEnfant() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public LocalDateTime getDate_config() {
        return date_config;
    }

    public void setDate_config(LocalDateTime date_config) {
        this.date_config = date_config;
    }

    public Integer getPourcentage_prix() {
        return pourcentage_prix;
    }

    public void setPourcentage_prix(Integer pourcentage_prix) {
        this.pourcentage_prix = pourcentage_prix;
    }

    public Integer getAge_limite() {
        return age_limite;
    }

    public void setAge_limite(Integer age_limite) {
        this.age_limite = age_limite;
    }
}
