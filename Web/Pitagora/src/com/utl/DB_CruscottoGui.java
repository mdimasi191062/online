package com.utl;

public class DB_CruscottoGui  extends AbstractDataBean 
{

  private String CODE_ID;
  private String STATO;
  
  public String getCODE_ID()
  {
    return CODE_ID;
  }
  
  public void setCODE_ID(String newCODE_ID)
  {
    this.CODE_ID = newCODE_ID;
  }

  public String getSTATO()
  {
    return STATO;
  }
  
  public void setSTATO(String newSTATO)
  {
    this.STATO = newSTATO;
  }
}
