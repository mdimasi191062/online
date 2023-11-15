package com.utl;

public class ClassStatiBatchElem implements java.io.Serializable
{
  private String codeStatoBatch;
  private String descStatoBatch;

  public String getCodeStatoBatch()
  {
    return codeStatoBatch;
  }
  public void setCodeStatoBatch(String stringa)
  {
      codeStatoBatch=stringa;
  }
  public String getDescStatoBatch()
  {
    return descStatoBatch;
  }
  public void setDescStatoBatch(String stringa)
  {
      descStatoBatch=stringa;
  }
}