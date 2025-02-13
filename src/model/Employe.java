package model;

import java.time.LocalDate;

import mg.itu.prom16.annotation.Numeric;
import mg.itu.prom16.annotation.Range;
import mg.itu.prom16.annotation.Required;

public class Employe {
    @Required
    private String name;
    private LocalDate dtn;
    @Numeric
    private String telephone;

    @Range(min=21, max=60)
    private int age;

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public LocalDate getDtn() {
        return dtn;
    }

    public void setDtn(LocalDate dtn) {
        this.dtn = dtn;
    }
    
    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public Employe() {
    }


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
    
}
