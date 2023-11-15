package com.utl;
import com.utl.AbstractDataBean;

public class DB_ElabBatchDettaglioResoconto extends AbstractDataBean
{

  private String DESC_SERVIZIO = "";
  private String CODE_STATO_PROC = "";
  private String DATA_INIZIO = "";
  private String DATA_FINE = "";
  private String CODE_PARAM_PROC = "";
  private String CODE_SERVIZIO = "";
  private String TIPO_SISTEMA = "";
  private String RETURN_CODE = "";

  public void setDESC_SERVIZIO(String value)
  {
    DESC_SERVIZIO = value;
  }
  public String getDESC_SERVIZIO()
  {
    return DESC_SERVIZIO;
  }

  public void setCODE_STATO_PROC(String value)
  {
    CODE_STATO_PROC = value;
  }
  public String getCODE_STATO_PROC()
  {
    return CODE_STATO_PROC;
  }


  public void setDATA_INIZIO(String value)
  {
    DATA_INIZIO = value;
  }
  public String getDATA_INIZIO()
  {
    return DATA_INIZIO;
  }

  public void setDATA_FINE(String value)
  {
    DATA_FINE = value;
  }
  public String getDATA_FINE()
  {
    return DATA_FINE;
  }
  
  public void setCODE_PARAM_PROC(String value)
  {
    CODE_PARAM_PROC = value;
  }
  public String getCODE_PARAM_PROC()
  {
    return CODE_PARAM_PROC;
  }
  
  public void setCODE_SERVIZIO(String value)
  {
    CODE_SERVIZIO = value;
  }
  public String getCODE_SERVIZIO()
  {
    return CODE_SERVIZIO;
  }
  
  public void setTIPO_SISTEMA(String value)
  {
    TIPO_SISTEMA = value;
  }
  public String getTIPO_SISTEMA()
  {
    return TIPO_SISTEMA;
  }

  public void setRETURN_CODE(String value)
  {
    RETURN_CODE = value;
  }
  public String getRETURN_CODE()
  {
    return RETURN_CODE;
  }

}