package com.utl;
import com.utl.AbstractDataBean;

public class DB_Offerta extends AbstractDataBean 
{
  private String CODE_OFFERTA;
  private String DESC_OFFERTA;
  private String DATA_INIZIO_VALID;
  private String DATA_FINE_VALID;
  private String CODE_SERVIZIO;

  public DB_Offerta()
  {
    CODE_OFFERTA = "";
    DESC_OFFERTA = "";
    DATA_INIZIO_VALID = "";
    DATA_FINE_VALID = "";
    CODE_SERVIZIO = "";    
  }

  public String getCODE_OFFERTA()
  {
    return CODE_OFFERTA;
  }
  public void setCODE_OFFERTA(String newCODE_OFFERTA)
  {
    CODE_OFFERTA = newCODE_OFFERTA;
  }

  public String getDESC_OFFERTA()
  {
    return DESC_OFFERTA;
  }
  public void setDESC_OFFERTA(String newDESC_OFFERTA)
  {
    DESC_OFFERTA = newDESC_OFFERTA;
  }

  public String getDATA_INIZIO_VALID()
  {
    return DATA_INIZIO_VALID;
  }
  public void setDATA_INIZIO_VALID(String newDATA_INIZIO_VALID)
  {
    DATA_INIZIO_VALID = newDATA_INIZIO_VALID;
  }

  public String getDATA_FINE_VALID()
  {
    return DATA_FINE_VALID;
  }
  public void setDATA_FINE_VALID(String newDATA_FINE_VALID)
  {
    DATA_FINE_VALID = newDATA_FINE_VALID;
  }

  public String getCODE_SERVIZIO()
  {
    return CODE_SERVIZIO;
  }
  public void setCODE_SERVIZIO(String newCODE_SERVIZIO)
  {
    CODE_SERVIZIO = newCODE_SERVIZIO;
  }
}