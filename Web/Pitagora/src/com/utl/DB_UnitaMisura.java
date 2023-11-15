package com.utl;
import com.utl.AbstractDataBean;
public class DB_UnitaMisura extends AbstractDataBean
{

  private String CODE_UNITA_MISURA = "";
  private String DESC_UNITA_MISURA = "";

  public DB_UnitaMisura()
  {
  }

  public String getCODE_UNITA_MISURA()
  {
    return CODE_UNITA_MISURA;
  }

  public void setCODE_UNITA_MISURA(String newCODE_UNITA_MISURA)
  {
    CODE_UNITA_MISURA = newCODE_UNITA_MISURA;
  }

  public String getDESC_UNITA_MISURA()
  {
    return DESC_UNITA_MISURA;
  }

  public void setDESC_UNITA_MISURA(String newDESC_UNITA_MISURA)
  {
    DESC_UNITA_MISURA = newDESC_UNITA_MISURA;
  }

}