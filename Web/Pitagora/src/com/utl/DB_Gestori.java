package com.utl;
import com.utl.AbstractDataBean;

public class DB_Gestori extends AbstractDataBean 
{
  /*
  tag attribute: CODE_GESTORE
  */
  private String CODE_GESTORE = "";
  /*
  tag attribute: DESC_GESTORE
  */
  private String DESC_GESTORE = "";
  /*
  tag attribute: CODE_PARTITA_IVA
  */
  private String CODE_PARTITA_IVA = "";
  /*
  tag attribute: DATA_INIZIO_VALID
  */
  private String DATA_INIZIO_VALID = "";
  /*
  tag attribute: DATA_FINE_VALID
  */
  private String DATA_FINE_VALID = "";
  /*
  tag attribute: TIPO_SISTEMA_MITTENTE
  */
  private String TIPO_SISTEMA_MITTENTE = "";
  /*
  tag attribute: CODE_GESTORE_SAP
  */
  private String CODE_GESTORE_SAP = "";
  /*
  tag attribute: FLAG_MODIF
  */
  private String FLAG_MODIF = "";

  public DB_Gestori()
  {
  }


  public void setCODE_GESTORE(String value)
  {
    CODE_GESTORE = value;
  }
  public String getCODE_GESTORE()
  {
    return CODE_GESTORE;
  }


  public void setDESC_GESTORE(String value)
  {
    DESC_GESTORE = value;
  }
  public String getDESC_GESTORE()
  {
    return DESC_GESTORE;
  }


  public void setCODE_PARTITA_IVA(String value)
  {
    CODE_PARTITA_IVA = value;
  }
  public String getCODE_PARTITA_IVA()
  {
    return CODE_PARTITA_IVA;
  }


  public void setDATA_INIZIO_VALID(String value)
  {
    DATA_INIZIO_VALID = value;
  }
  public String getDATA_INIZIO_VALID()
  {
    return DATA_INIZIO_VALID;
  }


  public void setDATA_FINE_VALID(String value)
  {
    DATA_FINE_VALID = value;
  }
  public String getDATA_FINE_VALID()
  {
    return DATA_FINE_VALID;
  }

  public String getTIPO_SISTEMA_MITTENTE()
  {
    return TIPO_SISTEMA_MITTENTE;
  }
  public void setTIPO_SISTEMA_MITTENTE(String value)
  {
    TIPO_SISTEMA_MITTENTE = value;
  }

  public String getCODE_GESTORE_SAP()
  {
    return CODE_GESTORE_SAP;
  }
  public void setCODE_GESTORE_SAP(String value)
  {
    CODE_GESTORE_SAP = value;
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