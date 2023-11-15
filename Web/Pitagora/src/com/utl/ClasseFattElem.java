package com.utl;

public class ClasseFattElem implements java.io.Serializable
{
  private String codeClasseOf;
  private String descClasseOf;

  public String getCodeClasseOf()
  {
    return codeClasseOf;
  }
  public void setCodeClasseOf(String stringa)
  {
      codeClasseOf=stringa;
  }
  public String getDescClasseOf()
  {
    return descClasseOf;
  }
  public void setDescClasseOf(String stringa)
  {
      descClasseOf=stringa;
  }

}