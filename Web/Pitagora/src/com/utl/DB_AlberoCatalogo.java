package com.utl;

public class DB_AlberoCatalogo   extends AbstractDataBean 
{
  String LIVELLO;
  String ID_ELEMENTO;
  String ELEMENTO_RIF;
  String CODE_ELEMENTO;
  String DESC_ELEMENTO;
  String STATO;
  
  public DB_AlberoCatalogo()
  {
     LIVELLO = "";
     ID_ELEMENTO= "";
     ELEMENTO_RIF= "";
     CODE_ELEMENTO= "";
     DESC_ELEMENTO= "";
     STATO = "";
  }

  public void setLIVELLO  ( String value ) { LIVELLO = value;}
  public void setID_ELEMENTO  ( String value ) { ID_ELEMENTO = value;}
  public void setELEMENTO_RIF  ( String value ) { ELEMENTO_RIF = value;}
  public void setCODE_ELEMENTO  ( String value ) { CODE_ELEMENTO = value;}
  public void setDESC_ELEMENTO  ( String value ) { DESC_ELEMENTO = value;}
  public void setSTATO  ( String value ) { STATO = value;}  

  public String getLIVELLO () { return LIVELLO ;}
  public String getID_ELEMENTO () { return ID_ELEMENTO ;}
  public String getELEMENTO_RIF () { return ELEMENTO_RIF ;}
  public String getCODE_ELEMENTO () { return CODE_ELEMENTO ;}
  public String getDESC_ELEMENTO () { return DESC_ELEMENTO ;}
  public String getSTATO () { return STATO ;}  
  
}