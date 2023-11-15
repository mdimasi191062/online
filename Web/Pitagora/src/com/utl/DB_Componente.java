package com.utl;
import com.utl.AbstractDataBean;

public class DB_Componente extends AbstractDataBean 
{
  /*
  tag attribute: CODE_COMPONENTE
  */
  private String CODE_COMPONENTE = "";
  /*
  tag attribute: DESC_COMPONENTE
  */
  private String DESC_COMPONENTE = "";
  /*
  tag attribute: TIPO_SISTEMA_MITTENTE
  */
  private String TIPO_SISTEMA_MITTENTE = "";

  //AP Aggiunta modifica descrizione
  private String FLAG_MODIF = "";


  public DB_Componente()
  {
  }


  public void setCODE_COMPONENTE(String value)
  {
    CODE_COMPONENTE = value;
  }


  public String getCODE_COMPONENTE()
  {
    return CODE_COMPONENTE;
  }


  public void setDESC_COMPONENTE(String value)
  {
    DESC_COMPONENTE = value;
  }


  public String getDESC_COMPONENTE()
  {
    return DESC_COMPONENTE;
  }

  public void setTIPO_SISTEMA_MITTENTE(String value)
  {
    TIPO_SISTEMA_MITTENTE = value;
  }


  public String getTIPO_SISTEMA_MITTENTE()
  {
    return TIPO_SISTEMA_MITTENTE;
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