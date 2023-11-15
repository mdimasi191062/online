package com.utl;
import com.utl.AbstractDataBean;

public class DB_PreTipoCaratteristiche extends AbstractDataBean
{

	private String CODE_TIPO_CARATT              ;
	private String DESC_TIPO_CARATT              ;
	private String TIPO_SISTEMA_MITTENTE         ;

  public DB_PreTipoCaratteristiche()
  {
  	CODE_TIPO_CARATT     = "";  
    DESC_TIPO_CARATT     = "";  
    TIPO_SISTEMA_MITTENTE= "";  
  }

  public String getCODE_TIPO_CARATT             () {return CODE_TIPO_CARATT     ;}
	public String getDESC_TIPO_CARATT             () {return DESC_TIPO_CARATT     ;}
	public String getTIPO_SISTEMA_MITTENTE        () {return TIPO_SISTEMA_MITTENTE;}

  public void setCODE_TIPO_CARATT      ( String value ) {CODE_TIPO_CARATT     = value;}
  public void setDESC_TIPO_CARATT      ( String value ) {DESC_TIPO_CARATT     = value;}
  public void setTIPO_SISTEMA_MITTENTE ( String value ) {TIPO_SISTEMA_MITTENTE= value;}

}