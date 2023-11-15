package com.utl;
import com.utl.AbstractDataBean;

public class DB_TipiOfferte extends AbstractDataBean
{
  private String CODE_TIPO_OFF = "";
  private String DESC_TIPO_OFF = "";

  public DB_TipiOfferte()
  {
  }

  public String getCODE_TIPO_OFF()
  {
    return CODE_TIPO_OFF;
  }

  public void setCODE_TIPO_OFF(String newCODE_TIPO_OFF)
  {
    CODE_TIPO_OFF = newCODE_TIPO_OFF;
  }

  public String getDESC_TIPO_OFF()
  {
    return DESC_TIPO_OFF;
  }

  public void setDESC_TIPO_OFF(String newDESC_TIPO_OFF)
  {
    DESC_TIPO_OFF = newDESC_TIPO_OFF;
  }
}