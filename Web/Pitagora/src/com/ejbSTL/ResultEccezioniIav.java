package com.ejbSTL;
import java.io.Serializable;

public class ResultEccezioniIav implements Serializable{

    private String dataRifda;
    private String dataRifa;
    private String dataInizioVal;
    private String dataFineVal;
    private String descUtente;
    private String codice;
    
    private String classTecnica;
    private String codiceFonte;
    private String ambito;
    private String servizioIav;
    private String tipologiaIav;
    
    private String nomeOlo;

    public ResultEccezioniIav() {
    dataRifda = null;
    dataRifa = null;
    dataInizioVal = null;
    dataFineVal = null;
    descUtente = null;
    codice=null;
    
     classTecnica= null;
     codiceFonte= null;
     ambito= null;
     servizioIav= null;
     tipologiaIav= null;
     
     nomeOlo= null;
    }
    
    public void setDataRifDa(String dataRifda) {
        this.dataRifda = dataRifda;
    }  
    
    public String getDataRifDa() {
        return dataRifda;
    }
    
    public void setDataRifA(String dataRifa) {
        this.dataRifa = dataRifa;
    }  
    
    public String getDataRifA() {
        return dataRifa;
    }

    public void setDataInizioVal(String dataInizioVal) {
        this.dataInizioVal = dataInizioVal;
    }  
    
    public String getDataInizioVal() {
        return dataInizioVal;
    }

    public void setDataFineVal(String dataFineVal) {
        this.dataFineVal = dataFineVal;
    }  
    
    public String getDataFineVal() {
        return dataFineVal;
    }

    public void setDescUtente(String descUtente) {
        this.descUtente = descUtente;
    }  
    
    public String getDescUtente() {
        return descUtente;
    }
    
    public void setCodice(String codice) {
        this.codice = codice;
    }  
    
    public String getCodice() {
        return codice;
    }

    public void setClassTecnica(String classTecnica) {
        this.classTecnica = classTecnica;
    }

    public String getClassTecnica() {
        return classTecnica;
    }

    public void setCodiceFonte(String codiceFonte) {
        this.codiceFonte = codiceFonte;
    }

    public String getCodiceFonte() {
        return codiceFonte;
    }

    public void setAmbito(String ambito) {
        this.ambito = ambito;
    }

    public String getAmbito() {
        return ambito;
    }

    public void setServizioIav(String servizioIav) {
        this.servizioIav = servizioIav;
    }

    public String getServizioIav() {
        return servizioIav;
    }

    public void setTipologiaIav(String tipologiaIav) {
        this.tipologiaIav = tipologiaIav;
    }

    public String getTipologiaIav() {
        return tipologiaIav;
    }

    public void setNomeOlo(String nomeOlo) {
        this.nomeOlo = nomeOlo;
    }

    public String getNomeOlo() {
        return nomeOlo;
    }
}
