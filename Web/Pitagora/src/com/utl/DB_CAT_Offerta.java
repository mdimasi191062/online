package com.utl;
import com.utl.AbstractDataBean;
public class DB_CAT_Offerta extends DB_Offerta
{

  private String TIPO_OFF;
  private String CODE_GRUPPI_CLASS_OFF;  
  private String VAL_REC;
  private String TIPO_SISTEMA_MITTENTE;
  //QS 4.9 Aggiunta gestione flag_modifica_descrizione
  private String FLAG_MODIF;
  
  public DB_CAT_Offerta()
  {
    TIPO_OFF              = "";
    CODE_GRUPPI_CLASS_OFF = "";
    VAL_REC               = "";
    TIPO_SISTEMA_MITTENTE = "";
  }

  public String getTIPO_OFF()
  {
    return TIPO_OFF;
  }
  public void setTIPO_OFF(String new_TIPO_OFF)
  {
    TIPO_OFF = new_TIPO_OFF;
  }
  
  public String getVAL_REC()
  {
    return VAL_REC;
  }
  public void setVAL_REC(String new_VAL_REC)
  {
    VAL_REC = new_VAL_REC;
  }

  public String getCODE_GRUPPI_CLASS_OFF()
  {
    return CODE_GRUPPI_CLASS_OFF;
  }
  public void setCODE_GRUPPI_CLASS_OFF(String new_CODE_GRUPPI_CLASS_OFF)
  {
    CODE_GRUPPI_CLASS_OFF = new_CODE_GRUPPI_CLASS_OFF;
  }

  public String getTIPO_SISTEMA_MITTENTE()
  {
    return TIPO_SISTEMA_MITTENTE;
  }
  public void setTIPO_SISTEMA_MITTENTE(String new_TIPO_SISTEMA_MITTENTE)
  {
    TIPO_SISTEMA_MITTENTE = new_TIPO_SISTEMA_MITTENTE;
  }


  //QS 4.9 Aggiunta gestione flag_modifica_descrizione
  public String getFLAG_MODIF()
  {
    return FLAG_MODIF;
  }
  public void setFLAG_MODIF(String new_FLAG_MODIF)
  {
    FLAG_MODIF = new_FLAG_MODIF;
  }
}