package com.utl;
import com.utl.AbstractDataBean;
public class DB_Anag_Class_Off extends AbstractDataBean 
{

  private String CODE_CLASSE_OFFERTA;
  private String DESC_CLASSE_OFFERTA;
  private String TIPO_SISTEMA_MITTENTE;
  
  public DB_Anag_Class_Off()
  {
  }

  public String getCODE_CLASSE_OFFERTA()
  {
    return CODE_CLASSE_OFFERTA;
  }
  public void setCODE_CLASSE_OFFERTA(String new_CODE_CLASSE_OFFERTA)
  {
    CODE_CLASSE_OFFERTA = new_CODE_CLASSE_OFFERTA;
  }

  public String getDESC_CLASSE_OFFERTA()
  {
    return DESC_CLASSE_OFFERTA;
  }
  public void setDESC_CLASSE_OFFERTA(String new_DESC_CLASSE_OFFERTA)
  {
    DESC_CLASSE_OFFERTA = new_DESC_CLASSE_OFFERTA;
  }

  public String getTIPO_SISTEMA_MITTENTE()
  {
    return TIPO_SISTEMA_MITTENTE;
  }
  public void setTIPO_SISTEMA_MITTENTE(String new_TIPO_SISTEMA_MITTENTE)
  {
    TIPO_SISTEMA_MITTENTE = new_TIPO_SISTEMA_MITTENTE;
  }

}