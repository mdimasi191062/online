package com.utl;
import com.utl.AbstractDataBean;

public class DB_ServizioLogico extends AbstractDataBean 
{
  private String CODE_SERVIZIO_LOGICO = "";
  private String DESC_SERVIZIO_LOGICO = "";
  private String DESC_BREVE = "";
  private String CODE_SERVIZIO = "";
  
  public String getCODE_SERVIZIO_LOGICO()
  {
    return CODE_SERVIZIO_LOGICO;
  }

  public void setCODE_SERVIZIO_LOGICO(String value)
  {
    CODE_SERVIZIO_LOGICO = value;
  }

  public String getDESC_SERVIZIO_LOGICO()
  {
    return DESC_SERVIZIO_LOGICO;
  }

  public void setDESC_SERVIZIO_LOGICO(String value)
  {
    DESC_SERVIZIO_LOGICO = value;
  }

  public String getDESC_BREVE()
  {
    return DESC_BREVE;
  }

  public void setDESC_BREVE(String value)
  {
    DESC_BREVE = value;
  }
  
  public String getCODE_SERVIZIO()
  {
    return CODE_SERVIZIO;
  }

  public void setCODE_SERVIZIO(String value)
  {
    CODE_SERVIZIO = value;
  }  
}