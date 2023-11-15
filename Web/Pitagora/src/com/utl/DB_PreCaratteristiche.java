package com.utl;
import com.utl.AbstractDataBean;

public class DB_PreCaratteristiche extends AbstractDataBean
{

  private String CODE_CARATT           ;
  private String CODE_TIPO_CARATT      ;
  private String DESC_TIPO_CARATT      ;  
  private String DESC_CARATT           ;
  private String TIPO_SISTEMA_MITTENTE ;
  private String FLAG_MODIF = "";     

  public DB_PreCaratteristiche()
  {
    CODE_CARATT           ="";
    CODE_TIPO_CARATT      ="";
    DESC_TIPO_CARATT      ="";    
    DESC_CARATT           ="";
    TIPO_SISTEMA_MITTENTE ="";
  }
        
  public String getCODE_CARATT() 
  {
    return CODE_CARATT;
  }
  public void setCODE_CARATT(String value) 
  {
    CODE_CARATT=value;
  }
    
  public String getCODE_TIPO_CARATT() 
  {
    return CODE_TIPO_CARATT;
  }
  public void setCODE_TIPO_CARATT(String value) 
  {
    CODE_TIPO_CARATT=value;
  }
    
  public String getDESC_TIPO_CARATT() 
  {
    return DESC_TIPO_CARATT;
  }    
  public void setDESC_TIPO_CARATT(String value) 
  {
    DESC_TIPO_CARATT=value;
  }    
    
  public String getDESC_CARATT() 
  {
    return DESC_CARATT;
  }
  public void setDESC_CARATT(String value) 
  {
    DESC_CARATT=value;
  }
    
  public String getTIPO_SISTEMA_MITTENTE() 
  {
    return TIPO_SISTEMA_MITTENTE;
  } 
  public void setTIPO_SISTEMA_MITTENTE(String value)
  {
    TIPO_SISTEMA_MITTENTE=value;
  }
    
  public String getFLAG_MODIF()
  {
    return FLAG_MODIF;
  }
  public void setFLAG_MODIF(String value)
  {
    FLAG_MODIF = value;
  }    
}