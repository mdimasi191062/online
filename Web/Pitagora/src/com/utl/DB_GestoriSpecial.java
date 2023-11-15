package com.utl;
import com.utl.AbstractDataBean;

public class DB_GestoriSpecial extends AbstractDataBean 
{
  /*
  tag attribute: CODE_GES
  */
  private String CODE_GEST = "";
  /*
  tag attribute: DESC_ACCOUNT
  */
  private String DESC_ACCOUNT = "";
  /*
  tag attribute: DESC_TIPO_FLAG_PROVVISORIA
  */
  private String DESC_TIPO_FLAG_PROVVISORIA = "";

  public DB_GestoriSpecial()
  {
  }


  public void setCODE_GEST(String value)
  {
    CODE_GEST = value;
  }
  public String getCCODE_GEST()
  {
    return CODE_GEST;
  }


  public void setDESC_ACCOUNT(String value)
  {
    DESC_ACCOUNT = value;
  }
  public String getDESC_ACCOUNT()
  {
    return DESC_ACCOUNT;
  }

  public void setDESC_TIPO_FLAG_PROVVISORIA(String value)
  {
    DESC_TIPO_FLAG_PROVVISORIA = value;
  }

  public String getDESC_TIPO_FLAG_PROVVISORIA()
  {
    return DESC_TIPO_FLAG_PROVVISORIA;
  }
}
