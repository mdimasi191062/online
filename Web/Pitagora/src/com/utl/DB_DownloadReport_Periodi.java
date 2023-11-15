package com.utl;
import com.utl.AbstractDataBean;

public class DB_DownloadReport_Periodi extends AbstractDataBean 
{
    private String CODE_CICLO = "";
    private String DATA_INIZIO_CICLO = "";
    private String DATA_FINE_CICLO = "";
    private String DESCRIZIONE_CICLO = "";

  public void setCODE_CICLO(String cODE_CICLO)
  {
    this.CODE_CICLO = cODE_CICLO;
  }

  public String getCODE_CICLO()
  {
    return CODE_CICLO;
  }

  public void setDATA_INIZIO_CICLO(String dATA_INIZIO_CICLO)
  {
    this.DATA_INIZIO_CICLO = dATA_INIZIO_CICLO;
  }

  public String getDATA_INIZIO_CICLO()
  {
    return DATA_INIZIO_CICLO;
  }

  public void setDATA_FINE_CICLO(String dATA_FINE_CICLO)
  {
    this.DATA_FINE_CICLO = dATA_FINE_CICLO;
  }

  public String getDATA_FINE_CICLO()
  {
    return DATA_FINE_CICLO;
  }

  public void setDESCRIZIONE_CICLO(String dESCRIZIONE_CICLO)
  {
    this.DESCRIZIONE_CICLO = dESCRIZIONE_CICLO;
  }

  public String getDESCRIZIONE_CICLO()
  {
    return DESCRIZIONE_CICLO;
  }
}
