package com.utl;
import com.utl.AbstractDataBean;

public class I52Estrazioni_cvidya_lanci extends AbstractDataBean
{
  private String nome_file_estr = null;
  private String code_tipo_contr = null;
  private String descrizione_ciclo = null;
  private String data_inizio_ciclo = null; 
  private String data_inizio_periodo = null; 
  private String data_fine_periodo = null; 
  private String data_creaz = null;

  public I52Estrazioni_cvidya_lanci()
  {
  }
  
  public void setNome_file_estr(String nome_file_estr)
  {
    this.nome_file_estr = nome_file_estr;
  }

  public String getNome_file_estr()
  {
    return nome_file_estr;
  }

  public void setCode_tipo_contr(String code_tipo_contr)
  {
    this.code_tipo_contr = code_tipo_contr;
  }

  public String getCode_tipo_contr()
  {
    return code_tipo_contr;
  }

  public void setDescrizione_ciclo(String descrizione_ciclo)
  {
    this.descrizione_ciclo = descrizione_ciclo;
  }

  public String getDescrizione_ciclo()
  {
    return descrizione_ciclo;
  }

  public void setData_inizio_ciclo(String data_inizio_ciclo)
  {
    this.data_inizio_ciclo = data_inizio_ciclo;
  }

  public String getData_inizio_ciclo()
  {
    return data_inizio_ciclo;
  }

  public void setData_inizio_periodo(String data_inizio_periodo)
  {
    this.data_inizio_periodo = data_inizio_periodo;
  }

  public String getData_inizio_periodo()
  {
    return data_inizio_periodo;
  }

  public void setData_fine_periodo(String data_fine_periodo)
  {
    this.data_fine_periodo = data_fine_periodo;
  }

  public String getData_fine_periodo()
  {
    return data_fine_periodo;
  }

  public void setData_creaz(String data_creaz)
  {
    this.data_creaz = data_creaz;
  }

  public String getData_creaz()
  {
    return data_creaz;
  }
}
