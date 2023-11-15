package com.utl;

public class DB_CAT_off_x_serv extends AbstractDataBean
{
  private String CODE_OFFERTA;
  private String DESC_OFFERTA;
  private String CODE_SERVIZIO;
  private String DESC_SERVIZIO;  
  private String TIPO_SISTEMA_MITTENTE;
  private String DATA_INIZIO_VALID;
  private String DATA_FINE_VALID;
  
  public String getCODE_OFFERTA()
  {
    return CODE_OFFERTA;
  }
  public void setCODE_OFFERTA(String new_CODE_OFFERTA)
  {
    CODE_OFFERTA = new_CODE_OFFERTA;
  }

  public String getDESC_OFFERTA()
  {
    return DESC_OFFERTA;
  }
  public void setDESC_OFFERTA(String new_DESC_OFFERTA)
  {
    DESC_OFFERTA = new_DESC_OFFERTA;
  }

  public String getCODE_SERVIZIO()
  {
    return CODE_SERVIZIO;
  }
  public void setCODE_SERVIZIO(String new_CODE_SERVIZIO)
  {
    CODE_SERVIZIO = new_CODE_SERVIZIO;
  }

  public String getDESC_SERVIZIO()
  {
    return DESC_SERVIZIO;
  }
  public void setDESC_SERVIZIO(String new_DESC_SERVIZIO)
  {
    DESC_SERVIZIO = new_DESC_SERVIZIO;
  }

  public String getTIPO_SISTEMA_MITTENTE()
  {
    return TIPO_SISTEMA_MITTENTE;
  }
  public void setTIPO_SISTEMA_MITTENTE(String new_TIPO_SISTEMA_MITTENTE)
  {
    TIPO_SISTEMA_MITTENTE = new_TIPO_SISTEMA_MITTENTE;
  }

  public String getDATA_INIZIO_VALID()
  {
    return DATA_INIZIO_VALID;
  }
  public void setDATA_INIZIO_VALID(String new_DATA_INIZIO_VALID)
  {
    DATA_INIZIO_VALID = new_DATA_INIZIO_VALID;
  }

  public String getDATA_FINE_VALID()
  {
    return DATA_FINE_VALID;
  }
  public void setDATA_FINE_VALID(String new_DATA_FINE_VALID)
  {
    DATA_FINE_VALID = new_DATA_FINE_VALID;
  }

}