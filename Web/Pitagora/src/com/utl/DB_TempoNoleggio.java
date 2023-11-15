package com.utl;
import com.utl.AbstractDataBean;

public class DB_TempoNoleggio extends AbstractDataBean 
{
  /*
  tag attribute: CODE_MODAL_APPLICAB_NOLEG
  */
  private String CODE_MODAL_APPLICAB_NOLEG = "";
  /*
  tag attribute: VALORE_PRIMO_NOLEGGIO
  */
  private String VALORE_PRIMO_NOLEGGIO = "";
  /*
  tag attribute: VALORE_RINNOVO_NOLEGGIO
  */
  private String VALORE_RINNOVO_NOLEGGIO = "";
  /*
  tag attribute: VALORE_TEMPO_PREAVVISO
  */
  private String VALORE_TEMPO_PREAVVISO = "";
  /*
  tag attribute: DATA_FINE_NOL
  */
  private String DATA_FINE_NOL = "";
	/*
  tag attribute: TIPO_SISTEMA_MITTENTE
  */
  private String TIPO_SISTEMA_MITTENTE = "";

  public void setCODE_MODAL_APPLICAB_NOLEG(String value)
  {
    CODE_MODAL_APPLICAB_NOLEG = value;
  }
  public String getCODE_MODAL_APPLICAB_NOLEG()
  {
    return CODE_MODAL_APPLICAB_NOLEG;
  }


  public void setVALORE_PRIMO_NOLEGGIO(String value)
  {
    VALORE_PRIMO_NOLEGGIO = value;
  }
  public String getVALORE_PRIMO_NOLEGGIO()
  {
    return VALORE_PRIMO_NOLEGGIO;
  }


  public void setVALORE_RINNOVO_NOLEGGIO(String value)
  {
    VALORE_RINNOVO_NOLEGGIO = value;
  }
  public String getVALORE_RINNOVO_NOLEGGIO()
  {
    return VALORE_RINNOVO_NOLEGGIO;
  }


  public void setVALORE_TEMPO_PREAVVISO(String value)
  {
    VALORE_TEMPO_PREAVVISO = value;
  }
  public String getVALORE_TEMPO_PREAVVISO()
  {
    return VALORE_TEMPO_PREAVVISO;
  }


  public void setDATA_FINE_NOL(String value)
  {
    DATA_FINE_NOL = value;
  }
  public String getDATA_FINE_NOL()
  {
    return DATA_FINE_NOL;
  }
  
  public void setTIPO_SISTEMA_MITTENTE(String value)
  {
    TIPO_SISTEMA_MITTENTE = value;
  }
  public String getTIPO_SISTEMA_MITTENTE()
  {
    return TIPO_SISTEMA_MITTENTE;
  }
  
}