package com.utl;
import com.utl.AbstractDataBean;

public class DB_Batch extends AbstractDataBean 
{
  private String CODE_ELAB = "";
  private String CODE_UTENTE = "";
  private String CODE_STATO_BATCH = "";
  private String VALO_NR_PS_ELAB = "";
  private String DATA_ORA_INIZIO_ELAB_BATCH = "";
  private String DATA_ORA_FINE_ELAB_BATCH = "";
  private String VALO_PROCESS_ID = "";
  private String CODE_USCITA = "";
  private String DESC_STATO_BATCH = "";
  private String CODE_FUNZ;
  private String FLAG_SYS;
  private String DESC_ANAG_BATCH_PRE = "";

  public DB_Batch()
  {
  }

  public String getCODE_ELAB()
  {
    return CODE_ELAB;
  }

  public void setCODE_ELAB(String newCODE_ELAB)
  {
    CODE_ELAB = newCODE_ELAB;
  }

  public String getCODE_UTENTE()
  {
    return CODE_UTENTE;
  }

  public void setCODE_UTENTE(String newCODE_UTENTE)
  {
    CODE_UTENTE = newCODE_UTENTE;
  }

  public String getCODE_STATO_BATCH()
  {
    return CODE_STATO_BATCH;
  }

  public void setCODE_STATO_BATCH(String newCODE_STATO_BATCH)
  {
    CODE_STATO_BATCH = newCODE_STATO_BATCH;
  }

  public String getVALO_NR_PS_ELAB()
  {
    return VALO_NR_PS_ELAB;
  }

  public void setVALO_NR_PS_ELAB(String newVALO_NR_PS_ELAB)
  {
    VALO_NR_PS_ELAB = newVALO_NR_PS_ELAB;
  }

  public String getDATA_ORA_INIZIO_ELAB_BATCH()
  {
    return DATA_ORA_INIZIO_ELAB_BATCH;
  }

  public void setDATA_ORA_INIZIO_ELAB_BATCH(String newDATA_ORA_INIZIO_ELAB_BATCH)
  {
    DATA_ORA_INIZIO_ELAB_BATCH = newDATA_ORA_INIZIO_ELAB_BATCH;
  }

  public String getDATA_ORA_FINE_ELAB_BATCH()
  {
    return DATA_ORA_FINE_ELAB_BATCH;
  }

  public void setDATA_ORA_FINE_ELAB_BATCH(String newDATA_ORA_FINE_ELAB_BATCH)
  {
    DATA_ORA_FINE_ELAB_BATCH = newDATA_ORA_FINE_ELAB_BATCH;
  }

  public String getVALO_PROCESS_ID()
  {
    return VALO_PROCESS_ID;
  }

  public void setVALO_PROCESS_ID(String newVALO_PROCESS_ID)
  {
    VALO_PROCESS_ID = newVALO_PROCESS_ID;
  }

  public String getCODE_USCITA()
  {
    return CODE_USCITA;
  }

  public void setCODE_USCITA(String newCODE_USCITA)
  {
    CODE_USCITA = newCODE_USCITA;
  }



  public String getDESC_STATO_BATCH()
  {
    return DESC_STATO_BATCH;
  }

  public void setDESC_STATO_BATCH(String newDESC_STATO_BATCH)
  {
    DESC_STATO_BATCH = newDESC_STATO_BATCH;
  }

  public String getCODE_FUNZ()
  {
    return CODE_FUNZ;
  }

  public void setCODE_FUNZ(String newCODE_FUNZ)
  {
    CODE_FUNZ = newCODE_FUNZ;
  }

  public String getFLAG_SYS()
  {
    return FLAG_SYS;
  }

  public void setFLAG_SYS(String newFLAG_SYS)
  {
    FLAG_SYS = newFLAG_SYS;
  }

  public String getDESC_ANAG_BATCH_PRE()
  {
    return DESC_ANAG_BATCH_PRE;
  }

  public void setDESC_ANAG_BATCH_PRE(String newDESC_ANAG_BATCH_PRE)
  {
    DESC_ANAG_BATCH_PRE = newDESC_ANAG_BATCH_PRE;
  }



}