package com.utl;

public class UnitaMisuraElem implements java.io.Serializable
{
  private String codeUnitaMisura;
  private String descUnitaMisura;

  public String getCodeUnitaMisura()
  { return codeUnitaMisura; }
  public void setCodeUnitaMisura(String stringa)
  {  codeUnitaMisura=stringa; }

  public String getDescUnitaMisura()
  { return descUnitaMisura; }
  public void setDescUnitaMisura(String stringa)
  {  descUnitaMisura=stringa; }
}