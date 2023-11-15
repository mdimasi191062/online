package com.utl;
import com.utl.AbstractDataBean;

public class DB_TipoCausaleNew extends AbstractDataBean 
{
  /*
  tag attribute: CODE_TIPO_CAUSALE
  */
  private String CODE_TIPO_CAUSALE = "";
  /*
  tag attribute: DESC_TIPO_CAUSALE
  */
  private String DESC_TIPO_CAUSALE = "";




  public void setCODE_TIPO_CAUSALE(String value)
  {
    CODE_TIPO_CAUSALE = value;
  }


  public String getCODE_TIPO_CAUSALE()
  {
    return CODE_TIPO_CAUSALE;
  }


  public void setDESC_TIPO_CAUSALE(String value)
  {
    DESC_TIPO_CAUSALE = value;
  }


  public String getDESC_TIPO_CAUSALE()
  {
    return DESC_TIPO_CAUSALE;
  }
  
}