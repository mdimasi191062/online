package com.utl;
import com.utl.AbstractDataBean;

public class DB_TipoCaratteristiche extends AbstractDataBean 
{
  private String CODE_TIPO_CARATT = "";
  private String DESC_TIPO_CARATT = "";

  public String getCODE_TIPO_CARATT()
  {
    return CODE_TIPO_CARATT;
  }

  public void setCODE_TIPO_CARATT(String newCODE_TIPO_CARATT)
  {
    CODE_TIPO_CARATT = newCODE_TIPO_CARATT;
  }

  public String getDESC_TIPO_CARATT()
  {
    return DESC_TIPO_CARATT;
  }

  public void setDESC_TIPO_CARATT(String newDESC_TIPO_CARATT)
  {
    DESC_TIPO_CARATT = newDESC_TIPO_CARATT;
  }
}