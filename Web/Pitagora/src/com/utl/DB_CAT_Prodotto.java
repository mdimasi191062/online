package com.utl;
import com.utl.AbstractDataBean;
public class DB_CAT_Prodotto extends DB_Prodotto
{

  private String CODE_CARATT;
  private String DESC_CARATT;

  public DB_CAT_Prodotto()
  {
  }

  public String getCODE_CARATT()
  {
    return CODE_CARATT;
  }
  public void setCODE_CARATT(String new_CODE_CARATT)
  {
    CODE_CARATT = new_CODE_CARATT;
  }
  
  public String getDESC_CARATT()
  {
    return DESC_CARATT;
  }
  public void setDESC_CARATT(String new_DESC_CARATT)
  {
    DESC_CARATT = new_DESC_CARATT;
  }

}