package com.utl;
import com.utl.AbstractDataBean;

public class DB_Catalogo  extends AbstractDataBean
{
  private String CODE_SERVIZIO;
  private String DESC_SERVIZIO;
  private String CODE_OFFERTA;
  private String DESC_OFFERTA;
  private String CODE_PRODOTTO;
  private String DESC_PRODOTTO;
  private String CODE_COMPONENTE;
  private String DESC_COMPONENTE;
  private String CODE_PRESTAZIONE ;
  private String DESC_PRESTAZIONE;

  
  public DB_Catalogo()
  {
    CODE_SERVIZIO   = "";
    DESC_SERVIZIO   = "";
    CODE_OFFERTA    = "";
    DESC_OFFERTA    = "";
    CODE_PRODOTTO   = "";
    DESC_PRODOTTO   = "";
    CODE_COMPONENTE = "";
    DESC_COMPONENTE = "";
    CODE_PRESTAZIONE= "";
    DESC_PRESTAZIONE= "";
  }
  
  public String getCODE_SERVIZIO    () { return CODE_SERVIZIO   ;}
  public String getDESC_SERVIZIO    () { return DESC_SERVIZIO   ;}
  public String getCODE_OFFERTA     () { return CODE_OFFERTA    ;}
  public String getDESC_OFFERTA     () { return DESC_OFFERTA    ;}
  public String getCODE_PRODOTTO    () { return CODE_PRODOTTO   ;}
  public String getDESC_PRODOTTO    () { return DESC_PRODOTTO   ;}
  public String getCODE_COMPONENTE  () { return CODE_COMPONENTE ;}
  public String getDESC_COMPONENTE  () { return DESC_COMPONENTE ;}
  public String getCODE_PRESTAZIONE () { return CODE_PRESTAZIONE;}
  public String getDESC_PRESTAZIONE () { return DESC_PRESTAZIONE;}
  
  public void setCODE_SERVIZIO    ( String value ) { CODE_SERVIZIO    = value;}
  public void setDESC_SERVIZIO    ( String value ) { DESC_SERVIZIO    = value;}
  public void setCODE_OFFERTA     ( String value ) { CODE_OFFERTA     = value;}
  public void setDESC_OFFERTA     ( String value ) { DESC_OFFERTA     = value;}
  public void setCODE_PRODOTTO    ( String value ) { CODE_PRODOTTO    = value;}
  public void setDESC_PRODOTTO    ( String value ) { DESC_PRODOTTO    = value;}
  public void setCODE_COMPONENTE  ( String value ) { CODE_COMPONENTE  = value;}
  public void setDESC_COMPONENTE  ( String value ) { DESC_COMPONENTE  = value;}
  public void setCODE_PRESTAZIONE ( String value ) { CODE_PRESTAZIONE = value;}
  public void setDESC_PRESTAZIONE ( String value ) { DESC_PRESTAZIONE = value;}


  
}