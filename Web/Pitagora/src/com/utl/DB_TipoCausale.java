package com.utl;
import com.utl.AbstractDataBean;

public class DB_TipoCausale extends AbstractDataBean 
{
  private String CODE_TIPO_CAUS = "";
  private String DESC_TIPO_CAUS = "";
  private String CODE_PR_PS_PA_CONTR = "";
  private String DATA_INIZIO_VALID_OF_PS = "";
  private String DATA_INIZIO_VALID_OF = "";

  public String getCODE_TIPO_CAUS()
  {
    return CODE_TIPO_CAUS;
  }

  public void setCODE_TIPO_CAUS(String newCODE_TIPO_CAUS)
  {
    CODE_TIPO_CAUS = newCODE_TIPO_CAUS;
  }

  public String getDESC_TIPO_CAUS()
  {
    return DESC_TIPO_CAUS;
  }

  public void setDESC_TIPO_CAUS(String newDESC_TIPO_CAUS)
  {
    DESC_TIPO_CAUS = newDESC_TIPO_CAUS;
  }

  public String getCODE_PR_PS_PA_CONTR()
  {
    return CODE_PR_PS_PA_CONTR;
  }

  public void setCODE_PR_PS_PA_CONTR(String newCODE_PR_PS_PA_CONTR)
  {
    CODE_PR_PS_PA_CONTR = newCODE_PR_PS_PA_CONTR;
  }

  public String getDATA_INIZIO_VALID_OF_PS()
  {
    return DATA_INIZIO_VALID_OF_PS;
  }

  public void setDATA_INIZIO_VALID_OF_PS(String newDATA_INIZIO_VALID_OF_PS)
  {
    DATA_INIZIO_VALID_OF_PS = newDATA_INIZIO_VALID_OF_PS;
  }

  public String getDATA_INIZIO_VALID_OF()
  {
    return DATA_INIZIO_VALID_OF;
  }

  public void setDATA_INIZIO_VALID_OF(String newDATA_INIZIO_VALID_OF)
  {
    DATA_INIZIO_VALID_OF = newDATA_INIZIO_VALID_OF;
  }
}