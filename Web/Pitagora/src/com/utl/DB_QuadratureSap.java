package com.utl;
import com.utl.AbstractDataBean;

public class DB_QuadratureSap extends AbstractDataBean 
{
  /*
  tag attribute: DATA_DI_VALORIZZAZIONE
  */
  private String DATA_DI_VALORIZZAZIONE = "";
  /*
  tag attribute: CODE_ACCOUNT
  */
  private String CODE_ACCOUNT = "";
  /*
  tag attribute: DESC_ACCOUNT
  */
  private String DESC_ACCOUNT = "";
  /*
  tag attribute: ID_RICHIESTA
  */
  private String ID_RICHIESTA = "";
  /*
  tag attribute: FLAG_RISCONTRO_SAP
  */
  private String FLAG_RISCONTRO_SAP = "";
  /*
  tag attribute: FLAG_REPRICING
  */
  private String FLAG_REPRICING = "";
  /*
  tag attribute: DATA_EMISSIONE
  */
  private String DATA_EMISSIONE = "";
  /*
  tag attribute: DATA_ELABORAZIONE
  */
  private String DATA_ELABORAZIONE = "";
  /*
  tag attribute: NR_FATTURA_SD
  */
  private String NR_FATTURA_SD = "";
  /*
  tag attribute: NR_DOC_FI
  */
  private String NR_DOC_FI = "";
  /*
  tag attribute: IMPORTO_FATTURA
  */
  private String IMPORTO_FATTURA = "";
  /*
  tag attribute: IMPORTO_IVA
  */
  private String IMPORTO_IVA = "";
  /*
  tag attribute: ESERCIZIO
  */
  private String ESERCIZIO = "";
  
  private String TIPO_DOCUMENTO = "";
  
  private String   NR_FATT_RIF = "";
  
  private String FLUSSO_SAP_ORIGINE = "";
    
  private String DATA_SCADENZA = "";    
  public DB_QuadratureSap()
  {
  }

  public void setDATA_DI_VALORIZZAZIONE(String value)
  {
    DATA_DI_VALORIZZAZIONE = value;
  }
  public String getDATA_DI_VALORIZZAZIONE()
  {
    return DATA_DI_VALORIZZAZIONE;
  }

  public void setCODE_ACCOUNT(String value)
  {
    CODE_ACCOUNT = value;
  }
  public String getCODE_ACCOUNT()
  {
    return CODE_ACCOUNT;
  }


  public void setDESC_ACCOUNT(String value)
  {
    DESC_ACCOUNT = value;
  }
  public String getDESC_ACCOUNT()
  {
    return DESC_ACCOUNT;
  }

  public void setID_RICHIESTA(String value)
  {
    ID_RICHIESTA = value;
  }

  public String getID_RICHIESTA()
  {
    return ID_RICHIESTA;
  }
  
  public void setFLAG_RISCONTRO_SAP(String value)
  {
    FLAG_RISCONTRO_SAP = value;
  }

  public String getFLAG_RISCONTRO_SAP()
  {
    return FLAG_RISCONTRO_SAP;
  }
  
  public void setFLAG_REPRICING(String value)
  {
    FLAG_REPRICING = value;
  }

  public String getFLAG_REPRICING()
  {
    return FLAG_REPRICING;
  }
 
  public void setDATA_EMISSIONE(String value)
  {
    DATA_EMISSIONE = value;
  }

  public String getDATA_EMISSIONE()
  {
    return DATA_EMISSIONE;
  }
  
  public void setDATA_ELABORAZIONE(String value)
  {
    DATA_ELABORAZIONE = value;
  }

  public String getDATA_ELABORAZIONE()
  {
    return DATA_ELABORAZIONE;
  }
  
  public void setNR_FATTURA_SD(String value)
  {
    NR_FATTURA_SD = value;
  }

  public String getNR_FATTURA_SD()
  {
    return NR_FATTURA_SD;
  }  


  public void setNR_DOC_FI(String value)
  {
    NR_DOC_FI = value;
  }

  public String getNR_DOC_FI()
  {
    return NR_DOC_FI;
  }   
  
  public void setIMPORTO_FATTURA(String value)
  {
    IMPORTO_FATTURA = value;
  }

  public String getIMPORTO_FATTURA()
  {
    return IMPORTO_FATTURA;
  }        
 
  public void setIMPORTO_IVA(String value)
  {
    IMPORTO_IVA = value;
  }

  public String getIMPORTO_IVA()
  {
    return IMPORTO_IVA;
  }        

  public void setESERCIZIO(String value)
  {
    ESERCIZIO = value;
  }

  public String getESERCIZIO()
  {
    return ESERCIZIO;
  }          
  public void setTIPO_DOCUMENTO(String value)
    {
      TIPO_DOCUMENTO = value;
    }

  public String getTIPO_DOCUMENTO()
    {
      return TIPO_DOCUMENTO;
    }
  public void setDATA_SCADENZA(String value)
      {
        DATA_SCADENZA = value;
      }

  public String getDATA_SCADENZA()
      {
        return DATA_SCADENZA;
      }    
  public void setFLUSSO_SAP_ORIGINE(String value)
        {
          FLUSSO_SAP_ORIGINE = value;
        }

  public String getFLUSSO_SAP_ORIGINE()
        {
          return FLUSSO_SAP_ORIGINE;
        }          
  public void setNR_FATT_RIF(String value)
        {
          NR_FATT_RIF = value;
        }

  public String getNR_FATT_RIF()
        {
          return NR_FATT_RIF;
        }            

    
}
