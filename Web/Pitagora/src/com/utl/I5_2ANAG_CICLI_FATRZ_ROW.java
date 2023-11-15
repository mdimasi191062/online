package com.utl;
import java.io.Serializable;

public class I5_2ANAG_CICLI_FATRZ_ROW implements Serializable 
{
  private String CODE_CICLO_FATRZ;
  private String DESC_CICLO_FATRZ;
  private int VALO_GG_INIZIO_CICLO;
  private java.util.Date DATA_CREAZ_CICLO;  

  public I5_2ANAG_CICLI_FATRZ_ROW()
  {
  }
  public I5_2ANAG_CICLI_FATRZ_ROW(String codice, String descrizione, int giorni)
  {
    CODE_CICLO_FATRZ=codice;
    DESC_CICLO_FATRZ=descrizione;
    VALO_GG_INIZIO_CICLO=giorni;
  }

  public String getCODE_CICLO_FATRZ()
  {
    return CODE_CICLO_FATRZ;
  }

  public void setCODE_CICLO_FATRZ(String new_CODE_CICLO_FATRZ)
  {
    CODE_CICLO_FATRZ = new_CODE_CICLO_FATRZ;
  }
  public String getDESC_CICLO_FATRZ()
  {
    return DESC_CICLO_FATRZ;
  }

  public void setDESC_CICLO_FATRZ(String new_DESC_CICLO_FATRZ)
  {
    DESC_CICLO_FATRZ = new_DESC_CICLO_FATRZ;
  }
  public int getVALO_GG_INIZIO_CICLO()
  {
    return VALO_GG_INIZIO_CICLO;
  }

  public void setVALO_GG_INIZIO_CICLO(int new_VALO_GG_INIZIO_CICLO)
  {
    VALO_GG_INIZIO_CICLO = new_VALO_GG_INIZIO_CICLO;
  }
  public java.util.Date getDATA_CREAZ_CICLO()
  {
    return DATA_CREAZ_CICLO;
  }

  public void setDATA_CREAZ_CICLO(java.util.Date new_DATA_CREAZ_CICLO)
  {
    DATA_CREAZ_CICLO = new_DATA_CREAZ_CICLO;
  }

}