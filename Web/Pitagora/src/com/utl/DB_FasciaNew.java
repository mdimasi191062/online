package com.utl;

public class DB_FasciaNew extends AbstractDataBean 
{
  private String CODE_FASCIA = "";
  private String CODE_PR_FASCIA = "";
  private String DESC_FASCIA = "";
  private String DATA_INIZIO_VALID = "";
  private String VALO_LIM_MIN = "";
  private String VALO_LIM_MAX = "";
  private String DATA_FINE_VALID = "";
  private String CODE_UNITA_DI_MISURA = "";
  private String DESC_UNITA_MISURA = "";

  public String getCODE_UNITA_DI_MISURA()
  {
    return CODE_UNITA_DI_MISURA;
  }

  public void setCODE_UNITA_DI_MISURA(String newCODE_UNITA_DI_MISURA)
  {
    CODE_UNITA_DI_MISURA = newCODE_UNITA_DI_MISURA;
  }

  public String getDESC_UNITA_MISURA()
  {
    return DESC_UNITA_MISURA;
  }

  public void setDESC_UNITA_MISURA(String newDESC_UNITA_MISURA)
  {
    DESC_UNITA_MISURA = newDESC_UNITA_MISURA;
  }

  public String getCODE_FASCIA()
  {
    return CODE_FASCIA;
  }

  public void setCODE_FASCIA(String newCODE_FASCIA)
  {
    CODE_FASCIA = newCODE_FASCIA;
  }

  public String getCODE_PR_FASCIA()
  {
    return CODE_PR_FASCIA;
  }

  public void setCODE_PR_FASCIA(String newCODE_PR_FASCIA)
  {
    CODE_PR_FASCIA = newCODE_PR_FASCIA;
  }

  public String getDESC_FASCIA()
  {
    return DESC_FASCIA;
  }

  public void setDESC_FASCIA(String newDESC_FASCIA)
  {
    DESC_FASCIA = newDESC_FASCIA;
  }

  public String getDATA_INIZIO_VALID()
  {
    return DATA_INIZIO_VALID;
  }

  public void setDATA_INIZIO_VALID(String newDATA_INIZIO_VALID)
  {
    DATA_INIZIO_VALID = newDATA_INIZIO_VALID;
  }

  public String getVALO_LIM_MIN()
  {
    return VALO_LIM_MIN;
  }

  public void setVALO_LIM_MIN(String newVALO_LIM_MIN)
  {
    VALO_LIM_MIN = newVALO_LIM_MIN;
  }

  public String getVALO_LIM_MAX()
  {
    return VALO_LIM_MAX;
  }

  public void setVALO_LIM_MAX(String newVALO_LIM_MAX)
  {
    VALO_LIM_MAX = newVALO_LIM_MAX;
  }

  public String getDATA_FINE_VALID()
  {
    return DATA_FINE_VALID;
  }

  public void setDATA_FINE_VALID(String newDATA_FINE_VALID)
  {
    DATA_FINE_VALID = newDATA_FINE_VALID;
  }
}
