package com.utl;
import com.utl.AbstractDataBean;

public class DB_TipoRelazioni extends AbstractDataBean 
{

  private String CODE_TIPO_RELAZIONE;
  private String DESC_TIPO_RELAZIONE;

  public DB_TipoRelazioni()
  {
    CODE_TIPO_RELAZIONE = "";
    DESC_TIPO_RELAZIONE = "";
  }
  
  public String getCODE_TIPO_RELAZIONE()
  {
    return CODE_TIPO_RELAZIONE;
  }

  public void setCODE_TIPO_RELAZIONE(String value)
  {
    CODE_TIPO_RELAZIONE = value;
  }

  public String getDESC_TIPO_RELAZIONE()
  {
    return DESC_TIPO_RELAZIONE;
  }

  public void setDESC_TIPO_RELAZIONE(String value )
  {
    DESC_TIPO_RELAZIONE = value;
  }
  
}
