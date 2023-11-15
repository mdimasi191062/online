package com.ejbSTL;
import java.io.Serializable;

public class I5_3GEST_SAP_SP_ROW implements Serializable 
{
  private String CODE_GEST_SAP;
  private String CODE_GEST;
  private String NOME_RAG_SOC_GEST;
  private String DATA_INIZIO_VALID;
  private String DATA_FINE_VALID;



  public I5_3GEST_SAP_SP_ROW()
  {
	CODE_GEST_SAP = null;
	CODE_GEST = null;
        NOME_RAG_SOC_GEST = null;
	DATA_INIZIO_VALID = null;
	DATA_FINE_VALID = null;

  }

  public String getCODE_GEST_SAP()
  {
    return CODE_GEST_SAP;
  }

  public void setCODE_GEST_SAP(String new_CODE_GEST_SAP)
  {
    CODE_GEST_SAP = new_CODE_GEST_SAP;
  }
  
  public String getCODE_GEST()
  {
    return CODE_GEST;
  }

  public void setCODE_GEST(String new_CODE_GEST)
  {
      CODE_GEST = new_CODE_GEST;
  }
  
    public String getNOME_RAG_SOC_GEST()
    {
      return NOME_RAG_SOC_GEST;
    }

    public void setNOME_RAG_SOC_GEST(String new_NOME_RAG_SOC_GEST)
    {
        NOME_RAG_SOC_GEST = new_NOME_RAG_SOC_GEST;
    }
    
  public String getDATA_INIZIO_VALID()
  {
    return DATA_INIZIO_VALID;
  }

  public void setDATA_INIZIO_VALID(String new_DATA_INIZIO_VALID)
  {
    DATA_INIZIO_VALID = new_DATA_INIZIO_VALID;
  }  

  public String getDATA_FINE_VALID()
    {
      return DATA_FINE_VALID;
    }

    public void setDATA_FINE_VALID(String new_DATA_FINE_VALID)
    {
      DATA_FINE_VALID = new_DATA_FINE_VALID;
    }  
  
  
}