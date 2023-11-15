package com.utl;

public class ClassFunzElem  implements java.io.Serializable
{
  private String codeFunz;
  private String descFunz;

  public String getCodeFunz()
  { return codeFunz; }
  public void setCodeFunz(String stringa)
  { codeFunz=stringa; }
 
  public String getDescFunz()
  {  return descFunz; }
  
  public void setDescFunz(String stringa)
  { descFunz=stringa; }
}