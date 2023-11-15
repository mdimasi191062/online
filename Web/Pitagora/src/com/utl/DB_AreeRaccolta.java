package com.utl;

public class DB_AreeRaccolta extends AbstractDataBean 
{
  private String CODE_AREERACCOLTA = "";
  private String DESC_AREERACCOLTA = "";

  public String getCODE_AREERACCOLTA()
  {
    return CODE_AREERACCOLTA;
  }

  public void setCODE_AREERACCOLTA(String newCODE_AREERACCOLTA)
  {
    CODE_AREERACCOLTA = newCODE_AREERACCOLTA;
  }

  public String getDESC_AREERACCOLTA()
  {
    return DESC_AREERACCOLTA;
  }

  public void setDESC_AREERACCOLTA(String newDESC_AREERACCOLTA)
  {
    DESC_AREERACCOLTA = newDESC_AREERACCOLTA;
  }
}