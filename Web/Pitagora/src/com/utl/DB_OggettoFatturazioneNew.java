package com.utl;
import com.utl.AbstractDataBean;

public class DB_OggettoFatturazioneNew extends AbstractDataBean 
{
  /*
  tag attribute: CODE_OGGETTO_FATRZ
  */
  private String CODE_OGGETTO_FATRZ = "";
  /*
  tag attribute: CODE_CLASSE_OGG_FATRZ
  */
  private String CODE_CLASSE_OGG_FATRZ = "";
  /*
  tag attribute: DESC_OGGETTO_FATRZ
  */
  private String DESC_OGGETTO_FATRZ = "";
  /*
  tag attribute: DATA_INIZIO_VALID
  */
  private String DATA_INIZIO_VALID = "";
  /*
  tag attribute: DATA_FINE_VALID
  */
  private String DATA_FINE_VALID = "";



  public void setCODE_OGGETTO_FATRZ(String value)
  {
    CODE_OGGETTO_FATRZ = value;
  }


  public String getCODE_OGGETTO_FATRZ()
  {
    return CODE_OGGETTO_FATRZ;
  }


  public void setCODE_CLASSE_OGG_FATRZ(String value)
  {
    CODE_CLASSE_OGG_FATRZ = value;
  }


  public String getCODE_CLASSE_OGG_FATRZ()
  {
    return CODE_CLASSE_OGG_FATRZ;
  }


  public void setDESC_OGGETTO_FATRZ(String value)
  {
    DESC_OGGETTO_FATRZ = value;
  }


  public String getDESC_OGGETTO_FATRZ()
  {
    return DESC_OGGETTO_FATRZ;
  }


  public void setDATA_INIZIO_VALID(String value)
  {
    DATA_INIZIO_VALID = value;
  }


  public String getDATA_INIZIO_VALID()
  {
    return DATA_INIZIO_VALID;
  }


  public void setDATA_FINE_VALID(String value)
  {
    DATA_FINE_VALID = value;
  }


  public String getDATA_FINE_VALID()
  {
    return DATA_FINE_VALID;
  }
}