package com.utl;
import com.utl.AbstractDataBean;

public class DB_TariffeSconti extends AbstractDataBean 
{
  private String CODE_TARIFFA = "";
  private String CODE_PR_TARIFFA = "";
  private String DATA_INIZIO_VALID = "";
  private String CODE_SCONTO = "";
  private String DATA_FINE_VALID = "";
  private String DATA_CREAZ = "";
  private String DATA_DUAS = "";
  
  private String DESC_SCONTO = "";
  private String VALO_PERC_SCONTO = "";
  private String VALO_DECR_TARIFFA = "";
  private String DESC_ES_PS = "";

  private String CODE_PREST_AGG = "";
  private String DESC_PREST_AGG = "";
  private String CODE_CLAS_OGG_FATRZ= "";
  private String DESC_CLAS_OGG_FATRZ= "";
  private String CODE_OGG_FATRZ = "";
  private String DESC_OGG_FATRZ = "";                                  
  private String CODE_TIPO_CAUS = "";                                  
  private String DESC_TIPO_CAUS = "";                                  
  private String CODE_TIPO_OFF = "";                                   
  private String DESC_TIPO_OFF = "";                                  
  private String CODE_CLAS_SCONTO = "";                               
  private String CODE_PR_CLAS_SCONTO= "";                             
  private String DESC_CLAS_SCONTO= "";                                
  private String IMPT_MIN_SPESA= "";                                  
  private String IMPT_MAX_SPESA= "";
  private String CODE_FASCIA  = "";
  private String VALO_LIM_MIN   = "";
  private String VALO_LIM_MAX= "";
  private String TIPO_FLAG_MODAL_APPL_TARIFFA= ""; 
                           


  public DB_TariffeSconti()
  {
  }

  public String getCODE_TARIFFA()
  {
    return CODE_TARIFFA;
  }

  public void setCODE_TARIFFA(String newCODE_TARIFFA)
  {
    CODE_TARIFFA = newCODE_TARIFFA;
  }

  public String getCODE_PR_TARIFFA()
  {
    return CODE_PR_TARIFFA;
  }

  public void setCODE_PR_TARIFFA(String newCODE_PR_TARIFFA)
  {
    CODE_PR_TARIFFA = newCODE_PR_TARIFFA;
  }

  public String getDATA_INIZIO_VALID()
  {
    return DATA_INIZIO_VALID;
  }

  public void setDATA_INIZIO_VALID(String newDATA_INIZIO_VALID)
  {
    DATA_INIZIO_VALID = newDATA_INIZIO_VALID;
  }

  public String getCODE_SCONTO()
  {
    return CODE_SCONTO;
  }

  public void setCODE_SCONTO(String newCODE_SCONTO)
  {
    CODE_SCONTO = newCODE_SCONTO;
  }

  public String getDATA_FINE_VALID()
  {
    return DATA_FINE_VALID;
  }

  public void setDATA_FINE_VALID(String newDATA_FINE_VALID)
  {
    DATA_FINE_VALID = newDATA_FINE_VALID;
  }

  public String getDATA_CREAZ()
  {
    return DATA_CREAZ;
  }

  public void setDATA_CREAZ(String newDATA_CREAZ)
  {
    DATA_CREAZ = newDATA_CREAZ;
  }

  public String getDATA_DUAS()
  {
    return DATA_DUAS;
  }

  public void setDATA_DUAS(String newDATA_DUAS)
  {
    DATA_DUAS = newDATA_DUAS;
  }

  
  public String getDESC_SCONTO()
  {
    return DESC_SCONTO;
  }
  
  public void setDESC_SCONTO(String newDESC_SCONTO)
  {
    DESC_SCONTO = newDESC_SCONTO;
  }

  public String getVALO_PERC_SCONTO()
  {
    return VALO_PERC_SCONTO;
  }
  
  public void setVALO_PERC_SCONTO(String newVALO_PERC_SCONTO)
  {
    VALO_PERC_SCONTO = newVALO_PERC_SCONTO;
  }

  public String getVALO_DECR_TARIFFA()
  {
    return VALO_DECR_TARIFFA;
  }
  
  public void setVALO_DECR_TARIFFA(String newVALO_DECR_TARIFFA)
  {
    VALO_DECR_TARIFFA = newVALO_DECR_TARIFFA;
  }

  public String getDESC_ES_PS()
  {
    return DESC_ES_PS;
  }

  public void setDESC_ES_PS(String newDESC_ES_PS)
  {
    DESC_ES_PS = newDESC_ES_PS;
  }

  public String getCODE_CLAS_OGG_FATRZ()
  {
    return CODE_CLAS_OGG_FATRZ;
  }

  public void setCODE_CLAS_OGG_FATRZ(String newCODE_CLAS_OGG_FATRZ)
  {
    CODE_CLAS_OGG_FATRZ = newCODE_CLAS_OGG_FATRZ;
  }

  public String getCODE_CLAS_SCONTO()
  {
    return CODE_CLAS_SCONTO;
  }

  public void setCODE_CLAS_SCONTO(String newCODE_CLAS_SCONTO)
  {
    CODE_CLAS_SCONTO = newCODE_CLAS_SCONTO;
  }

  public String getCODE_FASCIA()
  {
    return CODE_FASCIA;
  }

  public void setCODE_FASCIA(String newCODE_FASCIA)
  {
    CODE_FASCIA = newCODE_FASCIA;
  }

  public String getCODE_OGG_FATRZ()
  {
    return CODE_OGG_FATRZ;
  }

  public void setCODE_OGG_FATRZ(String newCODE_OGG_FATRZ)
  {
    CODE_OGG_FATRZ = newCODE_OGG_FATRZ;
  }

  public String getCODE_PREST_AGG()
  {
    return CODE_PREST_AGG;
  }

  public void setCODE_PREST_AGG(String newCODE_PREST_AGG)
  {
    CODE_PREST_AGG = newCODE_PREST_AGG;
  }

  public String getCODE_PR_CLAS_SCONTO()
  {
    return CODE_PR_CLAS_SCONTO;
  }

  public void setCODE_PR_CLAS_SCONTO(String newCODE_PR_CLAS_SCONTO)
  {
    CODE_PR_CLAS_SCONTO = newCODE_PR_CLAS_SCONTO;
  }

  public String getCODE_TIPO_CAUS()
  {
    return CODE_TIPO_CAUS;
  }

  public void setCODE_TIPO_CAUS(String newCODE_TIPO_CAUS)
  {
    CODE_TIPO_CAUS = newCODE_TIPO_CAUS;
  }

  public String getCODE_TIPO_OFF()
  {
    return CODE_TIPO_OFF;
  }

  public void setCODE_TIPO_OFF(String newCODE_TIPO_OFF)
  {
    CODE_TIPO_OFF = newCODE_TIPO_OFF;
  }

  public String getDESC_CLAS_OGG_FATRZ()
  {
    return DESC_CLAS_OGG_FATRZ;
  }

  public void setDESC_CLAS_OGG_FATRZ(String newDESC_CLAS_OGG_FATRZ)
  {
    DESC_CLAS_OGG_FATRZ = newDESC_CLAS_OGG_FATRZ;
  }

  public String getDESC_CLAS_SCONTO()
  {
    return DESC_CLAS_SCONTO;
  }

  public void setDESC_CLAS_SCONTO(String newDESC_CLAS_SCONTO)
  {
    DESC_CLAS_SCONTO = newDESC_CLAS_SCONTO;
  }

  public String getDESC_OGG_FATRZ()
  {
    return DESC_OGG_FATRZ;
  }

  public void setDESC_OGG_FATRZ(String newDESC_OGG_FATRZ)
  {
    DESC_OGG_FATRZ = newDESC_OGG_FATRZ;
  }

  public String getDESC_PREST_AGG()
  {
    return DESC_PREST_AGG;
  }

  public void setDESC_PREST_AGG(String newDESC_PREST_AGG)
  {
    DESC_PREST_AGG = newDESC_PREST_AGG;
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

  public String getIMPT_MIN_SPESA()
  {
    return IMPT_MIN_SPESA;
  }

  public void setIMPT_MIN_SPESA(String newIMPT_MIN_SPESA)
  {
    IMPT_MIN_SPESA = newIMPT_MIN_SPESA;
  }

  public String getIMPT_MAX_SPESA()
  {
    return IMPT_MAX_SPESA;
  }

  public void setIMPT_MAX_SPESA(String newIMPT_MAX_SPESA)
  {
    IMPT_MAX_SPESA = newIMPT_MAX_SPESA;
  }

  public String getDESC_TIPO_OFF()
  {
    return DESC_TIPO_OFF;
  }

  public void setDESC_TIPO_OFF(String newDESC_TIPO_OFF)
  {
    DESC_TIPO_OFF = newDESC_TIPO_OFF;
  }

  public String getDESC_TIPO_CAUS()
  {
    return DESC_TIPO_CAUS;
  }

  public void setDESC_TIPO_CAUS(String newDESC_TIPO_CAUS)
  {
    DESC_TIPO_CAUS = newDESC_TIPO_CAUS;
  }

  public String getTIPO_FLAG_MODAL_APPL_TARIFFA()
  {
    return TIPO_FLAG_MODAL_APPL_TARIFFA;
  }

  public void setTIPO_FLAG_MODAL_APPL_TARIFFA(String newTIPO_FLAG_MODAL_APPL_TARIFFA)
  {
    TIPO_FLAG_MODAL_APPL_TARIFFA = newTIPO_FLAG_MODAL_APPL_TARIFFA;
  }

}