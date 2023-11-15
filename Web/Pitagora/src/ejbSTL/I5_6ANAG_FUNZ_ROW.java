package com.ejbSTL;
import java.io.Serializable;

public class I5_6ANAG_FUNZ_ROW implements Serializable 
{
  private String CODE_FUNZ;
  private String DESC_FUNZ;  
  private String TIPO_FUNZ;
  private String FLAG_SYS;  


  public I5_6ANAG_FUNZ_ROW()
  {
    CODE_FUNZ = null; 
    DESC_FUNZ = null;     
    TIPO_FUNZ = null;     
    FLAG_SYS  = null;     
  }

  public String getCODE_FUNZ()
  {
    return CODE_FUNZ;
  }

  public void setCODE_FUNZ(String new_CODE_FUNZ)
  {
    CODE_FUNZ = new_CODE_FUNZ;
  }
  
  public String getDESC_FUNZ()
  {
    return DESC_FUNZ;
  }

  public void setDESC_FUNZ(String new_DESC_FUNZ)
  {
    DESC_FUNZ = new_DESC_FUNZ;
  }
  public String getTIPO_FUNZ()
  {
    return TIPO_FUNZ;
  }

  public void setTIPO_FUNZ(String new_TIPO_FUNZ)
  {
    TIPO_FUNZ = new_TIPO_FUNZ;
  }  
  public String getFLAG_SYS()
  {
    return FLAG_SYS;
  }

  public void setFLAG_SYS(String new_FLAG_SYS)
  {
    FLAG_SYS = new_FLAG_SYS;
  }
}