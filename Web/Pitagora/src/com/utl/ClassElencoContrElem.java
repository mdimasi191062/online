package com.utl;

public class ClassElencoContrElem implements java.io.Serializable
{
  private String code_contr;
  private String desc_contr;

  public String getCodeContr()
  {
    return code_contr;
  }
  public void setCodeContr(String stringa)
  {
      code_contr=stringa;
  }
  public String getDescContr()
  {
    return desc_contr;
  }
  public void setDescContr(String stringa)
  {
      desc_contr=stringa;
  }

}