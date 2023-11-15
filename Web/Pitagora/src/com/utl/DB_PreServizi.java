package com.utl;
import com.utl.AbstractDataBean;

public class DB_PreServizi  extends DB_Servizio
{
	private String TIPO_SISTEMA_MITTENTE        ;
  public DB_PreServizi()
  {
    TIPO_SISTEMA_MITTENTE     = ""; 
  }

  public String getTIPO_SISTEMA_MITTENTE        () {return TIPO_SISTEMA_MITTENTE        ;}
  public void setTIPO_SISTEMA_MITTENTE    (String value) { TIPO_SISTEMA_MITTENTE     = value ;}       
  
}