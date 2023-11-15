package com.ejbSTL;
import java.io.Serializable;

public class I5_6PROF_UTENTE_ROW implements Serializable 
{
  private String CODE_PROF_UTENTE;
  private String DESC_PROF_UTENTE;  

  public I5_6PROF_UTENTE_ROW()
  {
    CODE_PROF_UTENTE = null;    
    DESC_PROF_UTENTE = null;    
  }

  public String getCODE_PROF_UTENTE()
  {
    return CODE_PROF_UTENTE;
  }

  public void setCODE_PROF_UTENTE(String new_CODE_PROF_UTENTE)
  {
    CODE_PROF_UTENTE = new_CODE_PROF_UTENTE;
  }
  public String getDESC_PROF_UTENTE()
  {
    return DESC_PROF_UTENTE;
  }

  public void setDESC_PROF_UTENTE(String new_DESC_PROF_UTENTE)
  {
    DESC_PROF_UTENTE = new_DESC_PROF_UTENTE;
  }
}