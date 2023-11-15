package com.utl;

public class BatchElem  implements java.io.Serializable
{
  private String codeFunz;
  private int flagTipoContr;

  public String getCodeFunz()
  { 
    return codeFunz; 
  }

  public void setCodeFunz(String stringa)
  {
    codeFunz=stringa; 
  }

  public int getFlagTipoContr()
  {  
     return flagTipoContr; 
  }

  public void setFlagTipoContr(int i)
  {  
    flagTipoContr=i; 
  }
}