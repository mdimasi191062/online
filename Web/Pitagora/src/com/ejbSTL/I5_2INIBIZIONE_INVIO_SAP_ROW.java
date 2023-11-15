package com.ejbSTL;
import java.io.Serializable;

public class I5_2INIBIZIONE_INVIO_SAP_ROW implements Serializable 
{
  private Integer ID_REGOLA;
  private String CODE_ACCOUNT;
  private String DESC_ACCOUNT;
  private String CODE_GEST;
  private String CODE_TIPO_CONTR;
  private String DATA_INIZIO_VALID;
  private String DATA_FINE_VALID;
  private String FLAG_SAP;
  private String FLAG_SYS;
  private String FLAG_RESOCONTO_SAP;
  private String NOTE_RESOCONTO_SAP;
  private String NOTE;
  private String FLAG_ATTIVA;
  private String TIPO_DOC;

  public I5_2INIBIZIONE_INVIO_SAP_ROW()
  {
	CODE_ACCOUNT = null;
	CODE_GEST = null;
        DESC_ACCOUNT = null;
	CODE_TIPO_CONTR = null;
        DATA_INIZIO_VALID = null;        
	DATA_FINE_VALID = null;
        FLAG_SAP = null;
        FLAG_RESOCONTO_SAP = null;
        NOTE_RESOCONTO_SAP = null;
        NOTE = null;
        TIPO_DOC = null;
  }


    public void setCODE_ACCOUNT(String cODE_ACCOUNT) {
        this.CODE_ACCOUNT = cODE_ACCOUNT;
    }

    public String getCODE_ACCOUNT() {
        return CODE_ACCOUNT;
    }

    public void setDESC_ACCOUNT(String dESC_ACCOUNT) {
        this.DESC_ACCOUNT = dESC_ACCOUNT;
    }

    public String getDESC_ACCOUNT() {
        return DESC_ACCOUNT;
    }

    public void setCODE_GEST(String cODE_GEST) {
        this.CODE_GEST = cODE_GEST;
    }

    public String getCODE_GEST() {
        return CODE_GEST;
    }

    public void setCODE_TIPO_CONTR(String cODE_TIPO_CONTR) {
        this.CODE_TIPO_CONTR = cODE_TIPO_CONTR;
    }

    public String getCODE_TIPO_CONTR() {
        return CODE_TIPO_CONTR;
    }

    public void setDATA_INIZIO_VALID(String dATA_INIZIO_VALID) {
        this.DATA_INIZIO_VALID = dATA_INIZIO_VALID;
    }

    public String getDATA_INIZIO_VALID() {
        return DATA_INIZIO_VALID;
    }

    public void setDATA_FINE_VALID(String dATA_FINE_VALID) {
        this.DATA_FINE_VALID = dATA_FINE_VALID;
    }

    public String getDATA_FINE_VALID() {
        return DATA_FINE_VALID;
    }

    public void setFLAG_SAP(String fLAG_SAP) {
        this.FLAG_SAP = fLAG_SAP;
    }

    public String getFLAG_SAP() {
        return FLAG_SAP;
    }

    public void setFLAG_RESOCONTO_SAP(String fLAG_RESOCONTO_SAP) {
        this.FLAG_RESOCONTO_SAP = fLAG_RESOCONTO_SAP;
    }

    public String getFLAG_RESOCONTO_SAP() {
        return FLAG_RESOCONTO_SAP;
    }

    public void setNOTE_RESOCONTO_SAP(String nOTE_RESOCONTO_SAP) {
        this.NOTE_RESOCONTO_SAP = nOTE_RESOCONTO_SAP;
    }

    public String getNOTE_RESOCONTO_SAP() {
        return NOTE_RESOCONTO_SAP;
    }

    public void setNOTE(String nOTE) {
        this.NOTE = nOTE;
    }

    public String getNOTE() {
        return NOTE;
    }

    public void setFLAG_SYS(String fLAG_SYS) {
        this.FLAG_SYS = fLAG_SYS;
    }

    public String getFLAG_SYS() {
        return FLAG_SYS;
    }

    public void setID_REGOLA(Integer iD_REGOLA) {
        this.ID_REGOLA = iD_REGOLA;
    }

    public Integer getID_REGOLA() {
        return ID_REGOLA;
    }

    public void setFLAG_ATTIVA(String fLAG_ATTIVA) {
        this.FLAG_ATTIVA = fLAG_ATTIVA;
    }

    public String getFLAG_ATTIVA() {
        return FLAG_ATTIVA;
    }

    public void setTIPO_DOC(String tIPO_DOC) {
        this.TIPO_DOC = tIPO_DOC;
    }

    public String getTIPO_DOC() {
        return TIPO_DOC;
    }
}
