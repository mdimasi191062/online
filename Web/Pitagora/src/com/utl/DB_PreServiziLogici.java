package com.utl;
import com.utl.AbstractDataBean;

public class DB_PreServiziLogici extends DB_ServizioLogico
{
	private String TIPO_SISTEMA_MITTENTE;
  private String FLAG_MODIF;
  
  public DB_PreServiziLogici()
  {
    TIPO_SISTEMA_MITTENTE = "";
    FLAG_MODIF = "";
  }

  public String getTIPO_SISTEMA_MITTENTE() 
  {
    return TIPO_SISTEMA_MITTENTE;
  }
  
  public void setTIPO_SISTEMA_MITTENTE (String value) 
  { 
    TIPO_SISTEMA_MITTENTE = value;
  }

  public String getFLAG_MODIF() 
  {
    return FLAG_MODIF;
  }
  
  public void setFLAG_MODIF (String value) 
  { 
    FLAG_MODIF = value;
  }  
}