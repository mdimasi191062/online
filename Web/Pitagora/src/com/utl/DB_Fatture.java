package com.utl;
import com.utl.AbstractDataBean;

public class DB_Fatture extends AbstractDataBean
{
  private String DESC_CICLO_FATRZ = "";
  private String CODE_CICLO_FATRZ = "";
  private String CODE_DOC_FATTURA = "";
  private String CODE_ACCOUNT = "";
  private String FLAG_SYS = "";
  private String CODE_PARAM;
  private String IMPT_TOT_FATTURA = "";
  private String DATA_CREAZ_FATTURA = "";
  private String TIPO_FLAG_STATO_IMPT = "";
  private String TIPO_FLAG_FUNZIONE_CREAZ_IMPT = "";

  public DB_Fatture()
  {
  }

  public String getDESC_CICLO_FATRZ()
  {
    return DESC_CICLO_FATRZ;
  }

  public void setDESC_CICLO_FATRZ(String newDESC_CICLO_FATRZ)
  {
    DESC_CICLO_FATRZ = newDESC_CICLO_FATRZ;
  }

  public String getCODE_CICLO_FATRZ()
  {
    return CODE_CICLO_FATRZ;
  }

  public void setCODE_CICLO_FATRZ(String newCODE_CICLO_FATRZ)
  {
    CODE_CICLO_FATRZ = newCODE_CICLO_FATRZ;
  }

  public String getCODE_DOC_FATTURA()
  {
    return CODE_DOC_FATTURA;
  }

  public void setCODE_DOC_FATTURA(String newCODE_DOC_FATTURA)
  {
    CODE_DOC_FATTURA = newCODE_DOC_FATTURA;
  }

  public String getCODE_ACCOUNT()
  {
    return CODE_ACCOUNT;
  }

  public void setCODE_ACCOUNT(String newCODE_ACCOUNT)
  {
    CODE_ACCOUNT = newCODE_ACCOUNT;
  }

  public String getFLAG_SYS()
  {
    return FLAG_SYS;
  }

  public void setFLAG_SYS(String newFLAG_SYS)
  {
    FLAG_SYS = newFLAG_SYS;
  }

  public String getCODE_PARAM()
  {
    return CODE_PARAM;
  }

  public void setCODE_PARAM(String newCODE_PARAM)
  {
    CODE_PARAM = newCODE_PARAM;
  }

  public String getIMPT_TOT_FATTURA()
  {
    return IMPT_TOT_FATTURA;
  }

  public void setIMPT_TOT_FATTURA(String newIMPT_TOT_FATTURA)
  {
    IMPT_TOT_FATTURA = newIMPT_TOT_FATTURA;
  }

  public String getDATA_CREAZ_FATTURA()
  {
    return DATA_CREAZ_FATTURA;
  }

  public void setDATA_CREAZ_FATTURA(String newDATA_CREAZ_FATTURA)
  {
    DATA_CREAZ_FATTURA = newDATA_CREAZ_FATTURA;
  }

  public String getTIPO_FLAG_STATO_IMPT()
  {
    return TIPO_FLAG_STATO_IMPT;
  }

  public void setTIPO_FLAG_STATO_IMPT(String newTIPO_FLAG_STATO_IMPT)
  {
    TIPO_FLAG_STATO_IMPT = newTIPO_FLAG_STATO_IMPT;
  }

  public String getTIPO_FLAG_FUNZIONE_CREAZ_IMPT()
  {
    return TIPO_FLAG_FUNZIONE_CREAZ_IMPT;
  }

  public void setTIPO_FLAG_FUNZIONE_CREAZ_IMPT(String newTIPO_FLAG_FUNZIONE_CREAZ_IMPT)
  {
    TIPO_FLAG_FUNZIONE_CREAZ_IMPT = newTIPO_FLAG_FUNZIONE_CREAZ_IMPT;
  }
}