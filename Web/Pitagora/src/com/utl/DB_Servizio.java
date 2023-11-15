package com.utl;
import com.utl.AbstractDataBean;

public class DB_Servizio extends AbstractDataBean 
{
  private String CODE_SERVIZIO = "";
  private String DESC_SERVIZIO = "";

  public String getCODE_SERVIZIO()
  {
    return CODE_SERVIZIO;
  }

  public void setCODE_SERVIZIO(String newCODE_SERVIZIO)
  {
    CODE_SERVIZIO = newCODE_SERVIZIO;
  }

  public String getDESC_SERVIZIO()
  {
    return DESC_SERVIZIO;
  }

  public void setDESC_SERVIZIO(String newDESC_SERVIZIO)
  {
    DESC_SERVIZIO = newDESC_SERVIZIO;
  }
}