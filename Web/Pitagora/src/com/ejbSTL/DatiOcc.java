package com.ejbSTL;
import java.util.Date;

public class DatiOcc implements java.io.Serializable
{
  private String codice;
  private String desc_account;
  private String desc_forn;
  private String desc_mov;
  private java.util.Date data_fatrb;
  private java.util.Date data_transaz;
  private String importo;
  private String flag_fatt;
  private String flag_d_a;
  private String mese;
  private String anno;
  private String desc_oggetto;
  private String desc_classe;
  private String code_istanza;

  public String get_codice()
  {
    return codice;
  }
  public String get_desc_account()
  {
    return desc_account;
  }
  public String get_desc_forn()
  {
    return desc_forn;
  }
  public String get_desc_mov()
  {
    return desc_mov;
  }
  public java.util.Date get_data_fatrb()
  {
    return data_fatrb;
  }
  public java.util.Date get_data_transaz()
  {
    return data_transaz;
  }
  public String get_importo()
  {
    return importo;
  }
  public String get_flag_fatt()
  {
    return flag_fatt;
  }
  public String get_flag_d_a()
  {
    return flag_d_a;
  }
  public String get_mese()
  {
    return mese;
  }
  public String get_anno()
  {
    return anno;
  }
  public String get_desc_oggetto()
  {
    return desc_oggetto;
  }
  public String get_desc_classe()
  {
    return desc_classe;
  }
  public String get_code_istanza()
  {
    return code_istanza;
  }
  public void set_codice(String cod)
  {
      codice=cod;
  }
  public void set_desc_account(String acc)
  {
      desc_account=acc;
  }
  public void set_desc_forn(String forn)
  {
      desc_forn=forn;
  }
  public void set_data_fatrb(java.util.Date dat1)
  {
      data_fatrb=dat1;
  }
  public void set_desc_mov(String mov)
  {
      desc_mov=mov;
  }
  public void set_data_transaz(java.util.Date dat2)
  {
      data_transaz=dat2;
  }
  public void set_importo(String imp)
  {
      importo=imp;
  }
  public void set_flag_fatt(String flft)
  {
      flag_fatt=flft;
  }
  public void set_flag_d_a(String flda)
  {
      flag_d_a=flda;
  }
  public void set_mese(String mes)
  {
     mese=mes;
  }
  public void set_anno(String ann)
  {
     anno=ann;
  }
  public void set_desc_oggetto(String ogg)
  {
     desc_oggetto=ogg;
  }
  public void set_desc_classe(String cls)
  {
     desc_classe=cls;
  }
  public void set_code_istanza(String codist)
  {
     code_istanza=codist;
  }

}