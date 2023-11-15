package com.utl;
import com.utl.AbstractDataBean;

public class DB_ExportPerSap extends AbstractDataBean
{
  private String DATA_INIZIO_CICLO_FATRZ;
  private String DATA_FINE_CICLO_FATRZ;
  private String DATA_FINE_PERIODO;

  public DB_ExportPerSap()
  {
  }

  public String getDATA_INIZIO_CICLO_FATRZ()
  {
    return DATA_INIZIO_CICLO_FATRZ;
  }

  public void setDATA_INIZIO_CICLO_FATRZ(String newDATA_INIZIO_CICLO_FATRZ)
  {
    DATA_INIZIO_CICLO_FATRZ = newDATA_INIZIO_CICLO_FATRZ;
  }

  public String getDATA_FINE_CICLO_FATRZ()
  {
    return DATA_FINE_CICLO_FATRZ;
  }

  public void setDATA_FINE_CICLO_FATRZ(String newDATA_FINE_CICLO_FATRZ)
  {
    DATA_FINE_CICLO_FATRZ = newDATA_FINE_CICLO_FATRZ;
  }

  public String getDATA_FINE_PERIODO()
  {
    return DATA_FINE_PERIODO;
  }

  public void setDATA_FINE_PERIODO(String newDATA_FINE_PERIODO)
  {
    DATA_FINE_PERIODO = newDATA_FINE_PERIODO;
  }

  
  
}