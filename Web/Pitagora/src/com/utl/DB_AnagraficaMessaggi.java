package com.utl;
import com.utl.AbstractDataBean;

public class DB_AnagraficaMessaggi extends AbstractDataBean 
{
  private String CODE_ERR = "";
  private String CODE_TIPO_ERR = "";
  private String DESC_ERR = "";

  public DB_AnagraficaMessaggi()
  {
  }

  public String getCODE_ERR()
  {
    return CODE_ERR;
  }

  public void setCODE_ERR(String newCODE_ERR)
  {
    CODE_ERR = newCODE_ERR;
  }

  public String getCODE_TIPO_ERR()
  {
    return CODE_TIPO_ERR;
  }

  public void setCODE_TIPO_ERR(String newCODE_TIPO_ERR)
  {
    CODE_TIPO_ERR = newCODE_TIPO_ERR;
  }

  public String getDESC_ERR()
  {
    return DESC_ERR;
  }

  public void setDESC_ERR(String newDESC_ERR)
  {
    DESC_ERR = newDESC_ERR;
  }
}