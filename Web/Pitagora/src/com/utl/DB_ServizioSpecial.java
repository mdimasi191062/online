package com.utl;
import com.utl.AbstractDataBean;

public class DB_ServizioSpecial extends AbstractDataBean 
{
  private String CODE_TIPO_CONTR = "";
  private String DESC_TIPO_CONTR = "";

  public String getCODE_TIPO_CONTR()
  {
    return CODE_TIPO_CONTR;
  }

  public void setCODE_TIPO_CONTR(String newCODE_TIPO_CONTR)
  {
    CODE_TIPO_CONTR = newCODE_TIPO_CONTR;
  }

  public String getDESC_TIPO_CONTR()
  {
    return DESC_TIPO_CONTR;
  }

  public void setDESC_TIPO_CONTR(String newDESC_TIPO_CONTR)
  {
    DESC_TIPO_CONTR = newDESC_TIPO_CONTR;
  }
}
