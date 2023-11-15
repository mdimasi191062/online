package com.utl;
import java.io.Serializable;

public class I5_1COMUNI_CLUSTER_PRICING extends AbstractDataBean
{
  private String CODICE_ISTAT_COMUNE;
  private String CODICE_COMUNE;
  private String CODICE_CLUSTER;
  private String TIPOLOGIA_CLUSTER_COMUNE;
  private String DESCRIZIONE_COMUNE;
  private String CODE_TIPO_CONTR;
  private String DATA_INIZIO_VALIDITA_PRICING;
  private String DATA_FINE_VALIDITA_PRICING;    

  public String getCODICE_ISTAT_COMUNE()
  {
    return CODICE_ISTAT_COMUNE;
  }

  public void setCODICE_ISTAT_COMUNE(String pValue)
  {
    CODICE_ISTAT_COMUNE = pValue;
  }


  public String getCODICE_COMUNE()
  {
    return CODICE_COMUNE;
  }

  public void setCODICE_COMUNE(String pValue)
  {
    CODICE_COMUNE = pValue;
  }
  
  public String getCODICE_CLUSTER()
  {
    return CODICE_CLUSTER;
  }

  public void setCODICE_CLUSTER(String pValue)
  {
    CODICE_CLUSTER = pValue;
  }
  
  public String getTIPOLOGIA_CLUSTER_COMUNE()
  {
    return TIPOLOGIA_CLUSTER_COMUNE;
  }

  public void setTIPOLOGIA_CLUSTER_COMUNE(String pValue)
  {
    TIPOLOGIA_CLUSTER_COMUNE = pValue;
  }
  
  public String getDESCRIZIONE_COMUNE()
  {
    return DESCRIZIONE_COMUNE;
  }

  public void setDESCRIZIONE_COMUNE(String pValue)
  {
    DESCRIZIONE_COMUNE = pValue;
  }        
  
  public String getCODE_TIPO_CONTR()
  {
    return CODE_TIPO_CONTR;
  }

  public void setCODE_TIPO_CONTR(String pValue)
  {
    CODE_TIPO_CONTR = pValue;
  }    

  public String getDATA_INIZIO_VALIDITA_PRICING()
  {
    return DATA_INIZIO_VALIDITA_PRICING;
  }

  public void setDATA_INIZIO_VALIDITA_PRICING(String pValue)
  {
    DATA_INIZIO_VALIDITA_PRICING = pValue;
  }

  public String getDATA_FINE_VALIDITA_PRICING()
  {
    return DATA_FINE_VALIDITA_PRICING;
  }

  public void setDATA_FINE_VALIDITA_PRICING(String pValue)
  {
    DATA_FINE_VALIDITA_PRICING = pValue;
  }    
}