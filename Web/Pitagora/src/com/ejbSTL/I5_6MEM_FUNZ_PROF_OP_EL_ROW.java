package com.ejbSTL;
import java.io.Serializable;

public class I5_6MEM_FUNZ_PROF_OP_EL_ROW implements Serializable 
{
  private String CODE_PROF_UTENTE;
  private String CODE_FUNZ;
  private String CODE_OP_ELEM;
  private String DESC_OP_ELEM;
  
  public I5_6MEM_FUNZ_PROF_OP_EL_ROW()
  {
    CODE_PROF_UTENTE = null;
    CODE_FUNZ        = null;
    CODE_OP_ELEM     = null;
    DESC_OP_ELEM     = null;    
  }

  public String getCODE_PROF_UTENTE()
  {
    return CODE_PROF_UTENTE;
  }

  public void setCODE_PROF_UTENTE(String new_CODE_PROF_UTENTE)
  {
    CODE_PROF_UTENTE = new_CODE_PROF_UTENTE;
  }

  public String getCODE_FUNZ()
  {
    return CODE_FUNZ;
  }

  public void setCODE_FUNZ(String new_CODE_FUNZ)
  {
    CODE_FUNZ = new_CODE_FUNZ;
  }

  public String getCODE_OP_ELEM()
  {
    return CODE_OP_ELEM;
  }

  public void setCODE_OP_ELEM(String new_CODE_OP_ELEM)
  {
    CODE_OP_ELEM = new_CODE_OP_ELEM;
  }  
  public String getDESC_OP_ELEM()
  {
    return DESC_OP_ELEM;
  }

  public void setDESC_OP_ELEM(String new_DESC_OP_ELEM)
  {
    DESC_OP_ELEM = new_DESC_OP_ELEM;
  }    
}