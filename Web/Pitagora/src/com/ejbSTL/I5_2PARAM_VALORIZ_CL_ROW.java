package com.ejbSTL;
import java.io.Serializable;

public class I5_2PARAM_VALORIZ_CL_ROW implements Serializable 
{
  private Float valo_euribor;
  private String periodo_rif;
  private java.util.Date data_inizio_ciclo_fatrz;
  private java.util.Date data_fine_ciclo_fatrz;

  public I5_2PARAM_VALORIZ_CL_ROW()
  {
    valo_euribor = null;
    periodo_rif = null;
    data_inizio_ciclo_fatrz = null;
    data_fine_ciclo_fatrz = null;    
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

  public java.util.Date getData_inizio_ciclo_fatrz()
  {
    return data_inizio_ciclo_fatrz;
  }

  public void setData_inizio_ciclo_fatrz(java.util.Date new_data_inizio_ciclo_fatrz)
  {
    data_inizio_ciclo_fatrz = new_data_inizio_ciclo_fatrz;
  }

  public java.util.Date getData_fine_ciclo_fatrz()
  {
    return data_fine_ciclo_fatrz;
  }

  public void setData_fine_ciclo_fatrz(java.util.Date new_data_fine_ciclo_fatrz)
  {
    data_fine_ciclo_fatrz = new_data_fine_ciclo_fatrz;
  }
}