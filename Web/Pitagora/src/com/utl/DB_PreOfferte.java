package com.utl;
import com.utl.AbstractDataBean;

public class DB_PreOfferte extends DB_Offerta
{

  /* Attributi */
  private String TIPO_SISTEMA_MITTENTE            ;

  public DB_PreOfferte()
  {
  	 TIPO_SISTEMA_MITTENTE            = "";
  }

	 public void setTIPO_SISTEMA_MITTENTE            (String value ) {TIPO_SISTEMA_MITTENTE            = value;}

	 public String getTIPO_SISTEMA_MITTENTE            () { return TIPO_SISTEMA_MITTENTE            ;}
  
}