package com.utl;
import com.utl.AbstractDataBean;

public class DB_AnagraficaCicli extends AbstractDataBean 
{
    private String CODE_CICLO = "";
    private String DATA_INIZIO_CICLO = "";
    private String DATA_FINE_CICLO = "";
    private String DESCRIZIONE_CICLO = "";

  public void setCODE_CICLO(String CODE_CICLO)
  {
    this.CODE_CICLO = CODE_CICLO;
  }

  public String getCODE_CICLO()
  {
    return CODE_CICLO;
  }

  public void setDATA_INIZIO_CICLO(String DATA_INIZIO_CICLO)
  {
    this.DATA_INIZIO_CICLO = DATA_INIZIO_CICLO;
  }

  public String getDATA_INIZIO_CICLO()
  {
    return DATA_INIZIO_CICLO;
  }

  public void setDATA_FINE_CICLO(String DATA_FINE_CICLO)
  {
    this.DATA_FINE_CICLO = DATA_FINE_CICLO;
  }

  public String getDATA_FINE_CICLO()
  {
    return DATA_FINE_CICLO;
  }

  public void setDESCRIZIONE_CICLO(String DESCRIZIONE_CICLO)
  {
    this.DESCRIZIONE_CICLO = DESCRIZIONE_CICLO;
  }

  public String getDESCRIZIONE_CICLO()
  {
    return DESCRIZIONE_CICLO;
  }
}
