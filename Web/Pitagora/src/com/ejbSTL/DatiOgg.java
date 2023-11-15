package com.ejbSTL;
import java.util.Date;

public class DatiOgg implements java.io.Serializable
{
  private String codice;
  private String descrizione;
  private java.util.Date data_inizio;

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
  public java.util.Date get_data_inizio()
  {
    return data_inizio;
  }
  public void set_data_inizio(java.util.Date datainizio)
  {
      data_inizio=datainizio;
  }
}