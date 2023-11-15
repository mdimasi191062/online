package com.utl;

public class DB_PreAccorpamenti extends AbstractDataBean 
{
  private String CODE_ACCOUNT_ACCORPAMENTE = "";
  private String DESC_ACCOUNT_ACCORPAMENTE = "";
  private String CODE_ACCOUNT_ACCORPATO = "";  
  private String DESC_ACCOUNT_ACCORPATO = "";

  public DB_PreAccorpamenti()
  {
  }

  public void setCODE_ACCOUNT_ACCORPAMENTE(String value)
  {
    CODE_ACCOUNT_ACCORPAMENTE = value;
  }

  public String getCODE_ACCOUNT_ACCORPAMENTE()
  {
    return CODE_ACCOUNT_ACCORPAMENTE;
  }

  public void setDESC_ACCOUNT_ACCORPAMENTE(String value)
  {
    DESC_ACCOUNT_ACCORPAMENTE = value;
  }

  public String getDESC_ACCOUNT_ACCORPAMENTE()
  {
    return DESC_ACCOUNT_ACCORPAMENTE;
  }

  public void setCODE_ACCOUNT_ACCORPATO (String value)
  {
    CODE_ACCOUNT_ACCORPATO  = value;
  }

  public String getCODE_ACCOUNT_ACCORPATO()
  {
    return CODE_ACCOUNT_ACCORPATO;
  }

  public void setDESC_ACCOUNT_ACCORPATO(String value)
  {
    DESC_ACCOUNT_ACCORPATO = value;
  }

  public String getDESC_ACCOUNT_ACCORPATO()
  {
    return DESC_ACCOUNT_ACCORPATO;
  }
}