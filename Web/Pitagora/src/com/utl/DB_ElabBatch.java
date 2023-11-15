package com.utl;
import com.utl.AbstractDataBean;

public class DB_ElabBatch extends AbstractDataBean
{
  private String CODE_ELAB = "";
  private String CODE_FUNZ = "";
  private String CODE_UTENTE = "";
  private String CODE_STATO_BATCH = "";
  private String NUM_ELEM_ELABORATI = "";
  private String NUM_ELEM_SCARTATI = "";
  private String NUM_SCARTI = "";
  private String DATA_INIZIO = "";
  private String DATA_FINE = "";
  private String PROCESS_ID = "";
  private String RETURN_CODE = "";
  private String FLAG_LANCIO_BATCH = "";

  public void setCODE_ELAB(String value)
  {
    CODE_ELAB = value;
  }


  public String getCODE_ELAB()
  {
    return CODE_ELAB;
  }


  public void setCODE_FUNZ(String value)
  {
    CODE_FUNZ = value;
  }


  public String getCODE_FUNZ()
  {
    return CODE_FUNZ;
  }


  public void setCODE_UTENTE(String value)
  {
    CODE_UTENTE = value;
  }


  public String getCODE_UTENTE()
  {
    return CODE_UTENTE;
  }


  public void setCODE_STATO_BATCH(String value)
  {
    CODE_STATO_BATCH = value;
  }


  public String getCODE_STATO_BATCH()
  {
    return CODE_STATO_BATCH;
  }


  public void setNUM_ELEM_ELABORATI(String value)
  {
    NUM_ELEM_ELABORATI = value;
  }


  public String getNUM_ELEM_ELABORATI()
  {
    return NUM_ELEM_ELABORATI;
  }


  public void setNUM_ELEM_SCARTATI(String value)
  {
    NUM_ELEM_SCARTATI = value;
  }


  public String getNUM_ELEM_SCARTATI()
  {
    return NUM_ELEM_SCARTATI;
  }


  public void setNUM_SCARTI(String value)
  {
    NUM_SCARTI = value;
  }


  public String getNUM_SCARTI()
  {
    return NUM_SCARTI;
  }


  public void setDATA_INIZIO(String value)
  {
    DATA_INIZIO = value;
  }


  public String getDATA_INIZIO()
  {
    return DATA_INIZIO;
  }


  public void setDATA_FINE(String value)
  {
    DATA_FINE = value;
  }


  public String getDATA_FINE()
  {
    return DATA_FINE;
  }


  public void setPROCESS_ID(String value)
  {
    PROCESS_ID = value;
  }


  public String getPROCESS_ID()
  {
    return PROCESS_ID;
  }


  public void setRETURN_CODE(String value)
  {
    RETURN_CODE = value;
  }


  public String getRETURN_CODE()
  {
    return RETURN_CODE;
  }


  public void setFLAG_LANCIO_BATCH(String value)
  {
    FLAG_LANCIO_BATCH = value;
  }


  public String getFLAG_LANCIO_BATCH()
  {
    return FLAG_LANCIO_BATCH;
  }
}