package com.ejbSTL;
import java.io.Serializable;

public class I5_2TEST_AVANZ_COSTI_RICAVI_ROW implements Serializable 
{
           
  private String Anno;
  private String Mese;
  private String PeriodoCompetenza;  
  private String Nome_Rag_Soc_Gest;
  private String Code_Account;  
  private String Flag_Sys;  
  private String Desc_Account;
  private String Code_Stato_Avanz_Ricavi;  
  private String Code_Stato_Batch;    

  public I5_2TEST_AVANZ_COSTI_RICAVI_ROW()
  {
    Anno=null;
    Mese=null;
    PeriodoCompetenza=null;
    Nome_Rag_Soc_Gest=null;
    Code_Account=null;     
    Flag_Sys=null;         
    Desc_Account=null;        
    Code_Stato_Avanz_Ricavi=null;    
    Code_Stato_Batch=null;    

  }

  public String getAnno()
  {
    return Anno;
  }

  public void setAnno(String newAnno)
  {
    Anno = newAnno;
  }

  public String getMese()
  {
    return Mese;
  }

  public void setMese(String newMese)
  {
    Mese = newMese;
  }
  
  public String getPeriodoCompetenza()
  {
    return PeriodoCompetenza;
  }

  public void setPeriodoCompetenza(String newPeriodoCompetenza)
  {
    PeriodoCompetenza = newPeriodoCompetenza;
  }

  public String getNome_Rag_Soc_Gest()
  {
    return Nome_Rag_Soc_Gest;
  }

  public void setNome_Rag_Soc_Gest(String newNome_Rag_Soc_Gest)
  {
    Nome_Rag_Soc_Gest = newNome_Rag_Soc_Gest;
  }
  
  public String getDesc_Account()
  {
    return Desc_Account;
  }

  public void setDesc_Account(String newDesc_Account)
  {
    Desc_Account = newDesc_Account;
  }

  public String getCode_Stato_Avanz_Ricavi()
  {
    return Code_Stato_Avanz_Ricavi;
  }

  public void setCode_Stato_Avanz_Ricavi(String newCode_Stato_Avanz_Ricavi)
  {
    Code_Stato_Avanz_Ricavi = newCode_Stato_Avanz_Ricavi;
  }
  
  public String getCode_Stato_Batch()
  {
    return Code_Stato_Batch;
  }

  public void setCode_Stato_Batch(String newCode_Stato_Batch)
  {
    Code_Stato_Batch = newCode_Stato_Batch;
  }

  public String getCode_Account()
  {
    return Code_Account;
  }

  public void setCode_Account(String newCode_Account)
  {
    Code_Account = newCode_Account;
  }

  public String getFlag_Sys()
  {
    return Flag_Sys;
  }

  public void setFlag_Sys(String newFlag_Sys)
  {
    Flag_Sys = newFlag_Sys;
  }


}
