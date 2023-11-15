package com.utl;

public class DB_Gestore  extends AbstractDataBean 
{

  private String CODE_GEST;
  private String CODE_ACCOUNT;
  private String DESC_ACCOUNT;
  
  public String getCODE_GEST()
  {
    return CODE_GEST;
  }
  
  public void setCODE_GEST(String newCODE_GEST)
  {
    this.CODE_GEST = newCODE_GEST;
  }

  public String getCODE_ACCOUNT()
  {
    return CODE_ACCOUNT;
  }
  
  public void setCODE_ACCOUNT(String newCODE_ACCOUNT)
  {
    this.CODE_ACCOUNT = newCODE_ACCOUNT;
  }
  
  public String getDESC_ACCOUNT()
  {
    return DESC_ACCOUNT;
  }
  
  public void setDESC_ACCOUNT(String newDESC_ACCOUNT)
  {
    this.DESC_ACCOUNT = newDESC_ACCOUNT;
  }
  
 
  
  
}
