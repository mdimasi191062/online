package com.utl;
import com.utl.AbstractDataBean;

public class DB_Prodotto extends AbstractDataBean 
{
  private String CODE_OFFERTA = "";
  private String CODE_SERVIZIO = "";
  private String CODE_PRODOTTO = "";
  private String DESC_PRODOTTO = "";
  private String TIPO_SISTEMA_MITTENTE = "";
  //AP Aggiunta modifica descrizione
  private String FLAG_MODIF = "";
  

  public String getCODE_PRODOTTO()
  {
    return CODE_PRODOTTO;
  }

  public void setCODE_PRODOTTO(String newCODE_PRODOTTO)
  {
    CODE_PRODOTTO = newCODE_PRODOTTO;
  }

  public String getCODE_OFFERTA()
  {
    return CODE_OFFERTA;
  }

  public void setCODE_OFFERTA(String newCODE_OFFERTA)
  {
    CODE_OFFERTA = newCODE_OFFERTA;
  }

  public String getDESC_PRODOTTO()
  {
    return DESC_PRODOTTO;
  }

  public void setDESC_PRODOTTO(String newDESC_PRODOTTO)
  {
    DESC_PRODOTTO = newDESC_PRODOTTO;
  }

  public String getCODE_SERVIZIO()
  {
    return CODE_SERVIZIO;
  }

  public void setCODE_SERVIZIO(String newCODE_SERVIZIO)
  {
    CODE_SERVIZIO = newCODE_SERVIZIO;
  }

  public String getTIPO_SISTEMA_MITTENTE()
  {
    return TIPO_SISTEMA_MITTENTE;
  }
  
  public void setTIPO_SISTEMA_MITTENTE(String newTIPO_SISTEMA_MITTENTE)
  {
    TIPO_SISTEMA_MITTENTE = newTIPO_SISTEMA_MITTENTE;
  }


  //AP Aggiunta modifica descizione 
  public String getFLAG_MODIF()
  {
    return FLAG_MODIF;
  }
  
  public void setFLAG_MODIF(String value)
  {
    FLAG_MODIF = value;
  }
}


