package com.utl;

public class ClassFreqElem implements java.io.Serializable
{
  private String codeFreq;
  private String descFreq;

  public String getCodeFreq()
  { return codeFreq; }
  public void setCodeFreq(String stringa)
  { codeFreq=stringa; }
 
  public String getDescFreq()
  {  return descFreq; }
  
  public void setDescFreq(String stringa)
  { descFreq=stringa; }
}