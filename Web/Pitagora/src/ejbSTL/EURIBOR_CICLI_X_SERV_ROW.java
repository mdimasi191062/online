package com.ejbSTL;
import java.io.Serializable;

public class EURIBOR_CICLI_X_SERV_ROW implements Serializable 
{
  private Float valo_euribor;
  private String periodo_rif;
  private Number code_ciclo;
  private Number code_servizio;
  private String descrizione_servizio;
  private java.util.Date data_inizio_ciclo;
  private java.util.Date data_fine_ciclo;

  public EURIBOR_CICLI_X_SERV_ROW()
  {
    code_ciclo = null;
    code_servizio = null;
    valo_euribor = null;
    periodo_rif = null;
    descrizione_servizio = null;
    data_inizio_ciclo = null;
    data_fine_ciclo = null;    
  }

  public void setServizio_rif (String new_servizio_rif) 
  {
    descrizione_servizio = new_servizio_rif;
  }

  public String getServizio_rif()
  {
    return descrizione_servizio;
  }
  
  public Number getCode_Ciclo()
  {
    return code_ciclo;
  }
  
  public Number getCode_Servizio()
  {
    return code_servizio;
  }

  public Float getValo_euribor()
  {
    return valo_euribor;
  }

  public void setValo_euribor(Float new_valo_euribor)
  {
    valo_euribor = new_valo_euribor;
  }

  public String getPeriodo_rif()
  {
    return periodo_rif;
  }

  public void setPeriodo_rif(String new_periodo_rif)
  {
    periodo_rif = new_periodo_rif;
  }

  public java.util.Date getData_inizio_ciclo()
  {
    return data_inizio_ciclo;
  }

  public void setData_inizio_ciclo(java.util.Date new_data_inizio_ciclo)
  {
    data_inizio_ciclo = new_data_inizio_ciclo;
  }

  public java.util.Date getData_fine_ciclo()
  {
    return data_fine_ciclo;
  }

  public void setData_fine_ciclo(java.util.Date new_data_fine_ciclo)
  {
    data_fine_ciclo = new_data_fine_ciclo;
  }
}
