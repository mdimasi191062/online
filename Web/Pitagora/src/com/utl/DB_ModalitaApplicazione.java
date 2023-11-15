package com.utl;
import com.utl.AbstractDataBean;

public class DB_ModalitaApplicazione extends AbstractDataBean 
{
  /*
  tag attribute: CODE_MODAL_APPL_TARIFFA
  */
  private String CODE_MODAL_APPL_TARIFFA = "";
  /*
  tag attribute: DESC_MODAL_APPL_TARIFFA
  */
  private String DESC_MODAL_APPL_TARIFFA = "";
  /*
  tag attribute: FLAG_SCONTO
  */
  private String FLAG_SCONTO = "";
  /*
  tag attribute: FLAG_FASCIA
  */
  private String FLAG_FASCIA = "";
  /*
  tag attribute: TIPO_FLAG_MODAL_APPL_TARIFFA
  */
  private String TIPO_FLAG_MODAL_APPL_TARIFFA = "";







  public void setCODE_MODAL_APPL_TARIFFA(String value)
  {
    CODE_MODAL_APPL_TARIFFA = value;
  }


  public String getCODE_MODAL_APPL_TARIFFA()
  {
    return CODE_MODAL_APPL_TARIFFA;
  }


  public void setDESC_MODAL_APPL_TARIFFA(String value)
  {
    DESC_MODAL_APPL_TARIFFA = value;
  }


  public String getDESC_MODAL_APPL_TARIFFA()
  {
    return DESC_MODAL_APPL_TARIFFA;
  }


  public void setFLAG_SCONTO(String value)
  {
    FLAG_SCONTO = value;
  }


  public String getFLAG_SCONTO()
  {
    return FLAG_SCONTO;
  }


  public void setFLAG_FASCIA(String value)
  {
    FLAG_FASCIA = value;
  }


  public String getFLAG_FASCIA()
  {
    return FLAG_FASCIA;
  }


  public void setTIPO_FLAG_MODAL_APPL_TARIFFA(String value)
  {
    TIPO_FLAG_MODAL_APPL_TARIFFA = value;
  }


  public String getTIPO_FLAG_MODAL_APPL_TARIFFA()
  {
    return TIPO_FLAG_MODAL_APPL_TARIFFA;
  }
  
}