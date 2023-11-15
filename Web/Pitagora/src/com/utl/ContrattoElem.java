package com.utl;

public class ContrattoElem  implements java.io.Serializable
{
  private String codeContratto;
  private String descContratto;

  public String getCodeContratto()
  { return codeContratto; }
  public void setCodeContratto(String stringa)
  {  codeContratto=stringa; }

  public String getDescContratto()
  {  return descContratto; }
  public void setDescContratto(String stringa)
  {  descContratto=stringa; }
}