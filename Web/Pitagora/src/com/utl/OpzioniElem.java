package com.utl;

public class OpzioniElem implements java.io.Serializable
{
    private String codeOpzione;
    private String descOpzione;
    private int opzioniFlag;
    

  public void setOpzioniFlag(int flag)
  {
      opzioniFlag=flag;
  }
  public int getOpzioniFlag()
  {
    return opzioniFlag;
  }
  public String getDescOpzione()
  {
    return descOpzione;
  }
  public void setDescOpzione(String stringa)
  {
      descOpzione=stringa;
  }

   public String getCodeOpzione()
  {
    return codeOpzione;
  }
  public void setCodeOpzione(String stringa)
  {
      codeOpzione=stringa;
  }
}