package com.utl;

import java.rmi.RemoteException;

public class DB_CruscottoNdc extends AbstractDataBean 
{
  private String CODE_GEST_SAP;
  private String TIPO_FLAG_FUNZIONE_CREAZ_IMPT;
  private String RIFERITO_FATTURA;
  private String NR_FATTURA_SD;
  private String NR_DOC_FI;
  private String ESERCIZIO;
  private String CODE_GEST;
  private String CODE_ACCOUNT;
  private String DESC_ACCOUNT;
  private String DATA_INIZIO_CICLO_FATRZ;
  private String DATA_FINE_CICLO_FATRZ;
  private String DATA_EMISSIONE;
  
  public String getCODE_GEST_SAP()
  {
    return CODE_GEST_SAP;  
  }
  
  public void setCODE_GEST_SAP(String newCODE_GEST_SAP )
  {
    CODE_GEST_SAP = newCODE_GEST_SAP;
  }
  
  public String getTIPO_FLAG_FUNZIONE_CREAZ_IMPT()
  {
    return TIPO_FLAG_FUNZIONE_CREAZ_IMPT;  
  }
  
  public void setTIPO_FLAG_FUNZIONE_CREAZ_IMPT(String newTIPO_FLAG_FUNZIONE_CREAZ_IMPT )
  {
    TIPO_FLAG_FUNZIONE_CREAZ_IMPT = newTIPO_FLAG_FUNZIONE_CREAZ_IMPT;
  }

  public String getRIFERITO_FATTURA()
  {
    return RIFERITO_FATTURA;  
  }
  
  public void setRIFERITO_FATTURA(String newRIFERITO_FATTURA )
  {
    RIFERITO_FATTURA = newRIFERITO_FATTURA;
  }

  public String getNR_FATTURA_SD()
  {
    return NR_FATTURA_SD;  
  }
  
  public void setNR_FATTURA_SD(String newNR_FATTURA_SD )
  {
    NR_FATTURA_SD = newNR_FATTURA_SD;
  }

  public String getNR_DOC_FI()
  {
    return NR_DOC_FI;  
  }
  
  public void setNR_DOC_FI(String newNR_DOC_FI )
  {
    NR_DOC_FI = newNR_DOC_FI;
  }
  
  public String getESERCIZIO()
  {
    return ESERCIZIO;  
  }
  
  public void setESERCIZIO(String newESERCIZIO )
  {
    ESERCIZIO = newESERCIZIO;
  }

  public String getCODE_GEST()
  {
    return CODE_GEST;  
  }
  
  public void setCODE_GEST(String newCODE_GEST )
  {
    CODE_GEST = newCODE_GEST;
  }

  public String getCODE_ACCOUNT()
  {
    return CODE_ACCOUNT;  
  }
  
  public void setCODE_ACCOUNT(String newCODE_ACCOUNT )
  {
    CODE_ACCOUNT = newCODE_ACCOUNT;
  }

  public String getDESC_ACCOUNT()
  {
    return DESC_ACCOUNT;  
  }
  
  public void setDESC_ACCOUNT(String newDESC_ACCOUNT )
  {
    DESC_ACCOUNT = newDESC_ACCOUNT;
  }

  public String getDATA_INIZIO_CICLO_FATRZ()
  {
    return DATA_INIZIO_CICLO_FATRZ;  
  }
  
  public void setDATA_INIZIO_CICLO_FATRZ(String newDATA_INIZIO_CICLO_FATRZ )
  {
    DATA_INIZIO_CICLO_FATRZ = newDATA_INIZIO_CICLO_FATRZ;
  }

  public String getDATA_FINE_CICLO_FATRZ()
  {
    return DATA_FINE_CICLO_FATRZ;  
  }
  
  public void setDATA_FINE_CICLO_FATRZ(String newDATA_FINE_CICLO_FATRZ )
  {
    DATA_FINE_CICLO_FATRZ = newDATA_FINE_CICLO_FATRZ;
  }

  public String getDATA_EMISSIONE()
  {
    return DATA_EMISSIONE;  
  }
  
  public void setDATA_EMISSIONE(String newDATA_EMISSIONE )
  {
    DATA_EMISSIONE = newDATA_EMISSIONE;
  }

}
