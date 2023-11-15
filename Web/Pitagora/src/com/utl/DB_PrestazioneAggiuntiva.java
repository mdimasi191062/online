package com.utl;
import com.utl.AbstractDataBean;

public class DB_PrestazioneAggiuntiva extends AbstractDataBean 
{
  /*
  tag attribute: CODE_PREST_AGG
  */
  private String CODE_PREST_AGG = "";
  /*
  tag attribute: DESC_PREST_AGG
  */
  private String DESC_PREST_AGG = "";

  //QS 16-01-2008
  private String TIPO_SISTEMA_MITTENTE = "";
  
  //AP Aggiunta modifica descrizione
  private String FLAG_MODIF = "";


  public DB_PrestazioneAggiuntiva()
  {
  }


  public void setCODE_PREST_AGG(String value)
  {
    CODE_PREST_AGG = value;
  }


  public String getCODE_PREST_AGG()
  {
    return CODE_PREST_AGG;
  }

  //QS 16-01-2008
   public String getTIPO_SISTEMA_MITTENTE()
  {
    return TIPO_SISTEMA_MITTENTE;
  }
  
  public void setDESC_PREST_AGG(String value)
  {
    DESC_PREST_AGG = value;
  }


  public String getDESC_PREST_AGG()
  {
    return DESC_PREST_AGG;
  }

  //QS 16-01-2008
  public void setTIPO_SISTEMA_MITTENTE(String value)
  {
    TIPO_SISTEMA_MITTENTE = value;
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