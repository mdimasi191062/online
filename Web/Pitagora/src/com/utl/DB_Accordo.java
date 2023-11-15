package com.utl;

import com.utl.AbstractDataBean;

public class DB_Accordo extends AbstractDataBean
{
    private String CODE_OFFERTA = "";
    private String CODE_SERVIZIO = "";
    private String CODE_ACCORDO = "";
    private String DESC_ACCORDO = "";
    private String CODE_ACCOUNT        = "";
    private String CODE_PRODOTTO       = "";
    private String CODE_ISTANZA_PROD   = "";
    private String DATA_INIZIO_VALID   = "";
    private String DATA_FINE_VALID     = "";
    private String DATA_INIZIO_FATRZ   = "";
    private String DATA_FINE_FATRZ     = "";
    private String DATA_INIZIO_FATRB   = "";
    private String DATA_FINE_FATRB     = "";
    private String CODE_TARIFFA= "";
    private String CODE_PR_TARIFFA= "";
    private String IMPT_TARIFFA= "";
    private String DATA_INIZIO_TARIFFA= "";
    private String  DATA_FINE_TARIFFA= "";
  private String CODE_OGGETTO_FATRZ="";
  private String TIPO_FLAG_ANT_POST="";
  private String VALO_FREQ_APPL="";
  private String QNTA_SHIFT_CANONI="";
  private String CODE_MODAL_APPL_TARIFFA="";
  private String CODE_UTENTE = "";     
  public String ATTIVATO="";         
  public String VALORIZZATO="";    
  public String CODE_MATERIALE_SAP="";   
  public String TIPO_FLAG_CONG="";   

  public void setTIPO_FLAG_CONG(String value)
  {
    TIPO_FLAG_CONG = value;
  }


  public String getTIPO_FLAG_CONG()
  {
    return TIPO_FLAG_CONG;
  }
 
 
 
  public void setCODE_MATERIALE_SAP(String value)
  {
    CODE_MATERIALE_SAP = value;
  }


  public String getCODE_MATERIALE_SAP()
  {
    return CODE_MATERIALE_SAP;
  }
  
           
  public void setVALORIZZATO(String value)
  {
    VALORIZZATO = value;
  }


  public String getVALORIZZATO()
  {
    return VALORIZZATO;
  }
         

 
  public void setATTIVATO(String value)
  {
    ATTIVATO = value;
  }


  public String getATTIVATO()
  {
    return ATTIVATO;
  }



 
  public String getCODE_ACCORDO()
  {
    return CODE_ACCORDO;
  }

  public void setCODE_ACCORDO(String newCODE_ACCORDO)
  {
    CODE_ACCORDO = newCODE_ACCORDO;
  }

  public String getCODE_OFFERTA()
  {
    return CODE_OFFERTA;
  }

  public void setCODE_OFFERTA(String newCODE_OFFERTA)
  {
    CODE_OFFERTA = newCODE_OFFERTA;
  }

  public String getDESC_ACCORDO()
  {
    return DESC_ACCORDO;
  }

  public void setDESC_ACCORDO(String newDESC_ACCORDO)
  {
    DESC_ACCORDO = newDESC_ACCORDO;
  }

  public String getCODE_SERVIZIO()
  {
    return CODE_SERVIZIO;
  }

  public void setCODE_SERVIZIO(String newCODE_SERVIZIO)
  {
    CODE_SERVIZIO = newCODE_SERVIZIO;
  }



  public String getCODE_ACCOUNT()
  {
    return CODE_ACCOUNT;
  }

  public void setCODE_ACCOUNT(String newCODE_ACCOUNT)
  {
    CODE_ACCOUNT = newCODE_ACCOUNT;
  }
    public String getCODE_PRODOTTO()
  {
    return CODE_PRODOTTO;
  }

  public void setCODE_PRODOTTO(String newCODE_PRODOTTO)
  {
    CODE_PRODOTTO = newCODE_PRODOTTO;
  }
    public String getCODE_ISTANZA_PROD()
  {
    return CODE_ISTANZA_PROD;
  }

  public void setCODE_ISTANZA_PROD(String newCODE_ISTANZA_PROD)
  {
    CODE_ISTANZA_PROD = newCODE_ISTANZA_PROD;
  }
    public String getDATA_INIZIO_VALID()
  {
    return DATA_INIZIO_VALID;
  }

  public void setDATA_INIZIO_VALID(String newDATA_INIZIO_VALID)
  {
    DATA_INIZIO_VALID = newDATA_INIZIO_VALID;
  }
    public String getDATA_FINE_VALID()
  {
    return DATA_FINE_VALID;
  }

  public void setDATA_FINE_VALID(String newDATA_FINE_VALID)
  {
    DATA_FINE_VALID = newDATA_FINE_VALID;
  }
    public String getDATA_INIZIO_FATRZ()
  {
    return DATA_INIZIO_FATRZ;
  }

  public void setDATA_INIZIO_FATRZ(String newDATA_INIZIO_FATRZ)
  {
    DATA_INIZIO_FATRZ = newDATA_INIZIO_FATRZ;
  }
  
   public String getDATA_FINE_FATRZ()
  {
    return DATA_FINE_FATRZ;
  }

  public void setDATA_FINE_FATRZ(String newDATA_FINE_FATRZ)
  {
    DATA_FINE_FATRZ = newDATA_FINE_FATRZ;
  }
  
    public String getDATA_INIZIO_FATRB()
  {
    return DATA_INIZIO_FATRB;
  }

  public void setDATA_INIZIO_FATRB(String newDATA_INIZIO_FATRB)
  {
    DATA_INIZIO_FATRB = newDATA_INIZIO_FATRB;
  }
    public String getDATA_FINE_FATRB()
  {
    return DATA_FINE_FATRB;
  }

  public void setDATA_FINE_FATRB(String newDATA_FINE_FATRB)
  {
    DATA_FINE_FATRB = newDATA_FINE_FATRB;
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
    public String getIMPT_TARIFFA()
  {
    return IMPT_TARIFFA;
  }

  public void setIMPT_TARIFFA(String newIMPT_TARIFFA)
  {
    IMPT_TARIFFA = newIMPT_TARIFFA;
  }
    public String getDATA_INIZIO_TARIFFA()
  {
    return DATA_INIZIO_TARIFFA;
  }

  public void setDATA_INIZIO_TARIFFA(String newDATA_INIZIO_TARIFFA)
  {
    DATA_INIZIO_TARIFFA = newDATA_INIZIO_TARIFFA;
  }
  
    public String getDATA_FINE_TARIFFA()
  {
    return DATA_FINE_TARIFFA;
  }

  public void setDATA_FINE_TARIFFA(String newDATA_FINE_TARIFFA)
  {
    DATA_FINE_TARIFFA = newDATA_FINE_TARIFFA;
  }

  public void setCODE_OGGETTO_FATRZ(String value)
  {
    CODE_OGGETTO_FATRZ = value;
  }


  public String getCODE_OGGETTO_FATRZ()
  {
    return CODE_OGGETTO_FATRZ;
  }
  public void setTIPO_FLAG_ANT_POST(String value)
  {
    TIPO_FLAG_ANT_POST = value;
  }


  public String getTIPO_FLAG_ANT_POST()
  {
    return TIPO_FLAG_ANT_POST;
  }
  
    public void setVALO_FREQ_APPL(String value)
  {
    VALO_FREQ_APPL = value;
  }


  public String getVALO_FREQ_APPL()
  {
    return VALO_FREQ_APPL;
  }
  public void setQNTA_SHIFT_CANONI(String value)
  {
    QNTA_SHIFT_CANONI = value;
  }


  public String getQNTA_SHIFT_CANONI()
  {
    return QNTA_SHIFT_CANONI;
  }

  public void setCODE_MODAL_APPL_TARIFFA(String value)
  {
    CODE_MODAL_APPL_TARIFFA = value;
  }


  public String getCODE_MODAL_APPL_TARIFFA()
  {
    return CODE_MODAL_APPL_TARIFFA;
  }

  public void setCODE_UTENTE(String value)
  {
    CODE_UTENTE = value;
  }


  public String getCODE_UTENTE()
  {
    return CODE_UTENTE;
  }



}