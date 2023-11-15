package com.ejbSTL;

import java.io.Serializable;

public class TypeBatch implements Serializable{

    private String inizio;
    private String fine;
    private String stato;
    private String codice;
    private String valore;

    public TypeBatch() {
    inizio = null;
    fine = null;
    stato = null;
    codice = null;
    valore = null;
    }

    public void setCodice(String codice) {
        this.codice = codice;
    }

    public String getCodice() {
        return codice;
    }

    public void setInizio(String inizio) {
        this.inizio = inizio;
    }

    public String getInizio() {
        return inizio;
    }

    public void setFine(String fine) {
        this.fine = fine;
    }

    public String getFine() {
        return fine;
    }

    public void setStato(String stato) {
        this.stato = stato;
    }

    public String getStato() {
        return stato;
    }

    public void setValore(String valore) {
        this.valore = valore;
    }

    public String getValore() {
        return valore;
    }
	
}