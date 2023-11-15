package com.utl;

public class PromozioniElem  implements java.io.Serializable
{
  private String codePromozione;
  private String descPromozione;

  public String getCodePromozione()
  { return codePromozione; }
  public void setCodePromozione(String stringa)
  {  codePromozione=stringa; }

  public String getDescPromozione()
  {  return descPromozione; }
  public void setDescPromozione(String stringa)
  {  descPromozione=stringa; }
}