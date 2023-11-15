package com.utl;

public class DatiForn implements java.io.Serializable
{
  private String codice;
  private String descrizione;

  public String get_descrizione()
  {
    return descrizione;
  }
  public void set_descrizione(String desc)
  {
      descrizione=desc;
  }
  public String get_codice()
  {
    return codice;
  }
  public void set_codice(String code)
  {
    codice=code;
  }
}