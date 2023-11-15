package com.utl;
import java.io.Serializable;

public class DB_TipiServizio implements Serializable
{
  private String CODE_TIPO_SERVIZIO;
  private String DESC_TIPO_SERVIZIO;

  public DB_TipiServizio()
  {
  }

  public String getCODE_TIPO_SERVIZIO()
  {
    return CODE_TIPO_SERVIZIO;
  }

  public void setCODE_TIPO_SERVIZIO(String newCODE_TIPO_SERVIZIO)
  {
    CODE_TIPO_SERVIZIO = newCODE_TIPO_SERVIZIO;
  }

  public String getDESC_TIPO_SERVIZIO()
  {
    return DESC_TIPO_SERVIZIO;
  }

  public void setDESC_TIPO_SERVIZIO(String newDESC_TIPO_SERVIZIO)
  {
    DESC_TIPO_SERVIZIO = newDESC_TIPO_SERVIZIO;
  }

}