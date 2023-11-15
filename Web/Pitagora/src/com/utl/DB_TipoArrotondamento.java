package com.utl;
import com.utl.AbstractDataBean;
public class DB_TipoArrotondamento extends AbstractDataBean
{

  private String CODE_TIPO_ARROTONDAMENTO = "";
  private String DESC_TIPO_ARROTONDAMENTO = "";

  public String getCODE_TIPO_ARROTONDAMENTO()
  {
    return CODE_TIPO_ARROTONDAMENTO;
  }

  public void setCODE_TIPO_ARROTONDAMENTO(String newCODE_TIPO_ARROTONDAMENTO)
  {
    CODE_TIPO_ARROTONDAMENTO = newCODE_TIPO_ARROTONDAMENTO;
  }

  public String getDESC_TIPO_ARROTONDAMENTO()
  {
    return DESC_TIPO_ARROTONDAMENTO;
  }

  public void setDESC_TIPO_ARROTONDAMENTO(String newDESC_TIPO_ARROTONDAMENTO)
  {
    DESC_TIPO_ARROTONDAMENTO = newDESC_TIPO_ARROTONDAMENTO;
  }

}