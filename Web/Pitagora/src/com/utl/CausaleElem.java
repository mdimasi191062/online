package com.utl;

public class CausaleElem  implements java.io.Serializable
{
  private String codeTipoCausFat;
  private String descTipoCausFat;

  public String getCodeTipoCausFat()
  { return codeTipoCausFat; }
  public void setCodeOggettoCf(String stringa)
  {  codeTipoCausFat=stringa; }

  public String getDescTipoCausFat()
  {  return descTipoCausFat; }
  public void setDescOggettoCf(String stringa)
  {  descTipoCausFat=stringa; }
}