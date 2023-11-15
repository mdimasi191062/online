package com.utl;
import com.utl.AbstractDataBean;

public class DB_PrestazioniAggiuntive extends AbstractDataBean 
 {
  private String CODE_PREST_AGG = "";
  private String DESC_PREST_AGG = "";
  private String CODE_UTENTE_CREAZ = "";
  private String DATA_CREAZ = "";
  private String CODE_UTENTE_MODIF = "";
  private String DATA_MODIF = "";
    private String CODE_PR_PS_PA_CONTR;

  public DB_PrestazioniAggiuntive()
  {
  }

  public String getCODE_PREST_AGG()
  {
    return CODE_PREST_AGG;
  }

  public void setCODE_PREST_AGG(String newCODE_PREST_AGG)
  {
    CODE_PREST_AGG = newCODE_PREST_AGG;
  }

  public String getDESC_PREST_AGG()
  {
    return DESC_PREST_AGG;
  }

  public void setDESC_PREST_AGG(String newDESC_PREST_AGG)
  {
    DESC_PREST_AGG = newDESC_PREST_AGG;
  }

  public String getCODE_UTENTE_CREAZ()
  {
    return CODE_UTENTE_CREAZ;
  }

  public void setCODE_UTENTE_CREAZ(String newCODE_UTENTE_CREAZ)
  {
    CODE_UTENTE_CREAZ = newCODE_UTENTE_CREAZ;
  }

  public String getDATA_CREAZ()
  {
    return DATA_CREAZ;
  }

  public void setDATA_CREAZ(String newDATA_CREAZ)
  {
    DATA_CREAZ = newDATA_CREAZ;
  }

  public String getCODE_UTENTE_MODIF()
  {
    return CODE_UTENTE_MODIF;
  }

  public void setCODE_UTENTE_MODIF(String newCODE_UTENTE_MODIF)
  {
    CODE_UTENTE_MODIF = newCODE_UTENTE_MODIF;
  }

  public String getDATA_MODIF()
  {
    return DATA_MODIF;
  }

  public void setDATA_MODIF(String newDATA_MODIF)
  {
    DATA_MODIF = newDATA_MODIF;
  }

    public String getCODE_PR_PS_PA_CONTR()
    {
        return CODE_PR_PS_PA_CONTR;
    }

    public void setCODE_PR_PS_PA_CONTR(String newCODE_PR_PS_PA_CONTR)
    {
        CODE_PR_PS_PA_CONTR = newCODE_PR_PS_PA_CONTR;
    }
}