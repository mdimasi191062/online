package com.ejbSTL;
import java.io.Serializable;

public class LISTA_VERIFICA_ACCOUNT_CPM_CL_ROW implements Serializable 
{

    //Campi per la gestione per la verifica batch calcolo penali mensili
  private String Nome_rag_soc_gest;  
  private String Code_account;  
  private String Flag_sys; 
  private String Desc_account;   
  private String Mese;     
  private String Anno;
  private int ScartiNB;
  private String ErroriBloccanti;

  public LISTA_VERIFICA_ACCOUNT_CPM_CL_ROW()
  {
    Nome_rag_soc_gest=null;
    Code_account=null;
    Flag_sys=null;
    Desc_account=null;
    Mese=null;
    Anno=null;
    ErroriBloccanti=null;
  }

  public String getNome_rag_soc_gest()
  {
    return Nome_rag_soc_gest;
  }

  public void setNome_rag_soc_gest(String newNome_rag_soc_gest)
  {
    Nome_rag_soc_gest = newNome_rag_soc_gest;
  }

  public String getCode_account()
  {
    return Code_account;
  }

  public void setCode_account(String newCode_account)
  {
    Code_account = newCode_account;
  }
  
  public String getFlag_sys()
  {
    return Flag_sys;
  }

  public void setFlag_sys(String newFlag_sys)
  {
    Flag_sys = newFlag_sys;
  }

  public String getDesc_account()
  {
    return Desc_account;
  }

  public void setDesc_account(String newDesc_account)
  {
    Desc_account = newDesc_account;
  }

  public String getMese()
  {
    return Mese;
  }

  public void setMese(String newMese)
  {
    Mese = newMese;
  }

  public String getAnno()
  {
    return Anno;
  }

  public void setAnno(String newAnno)
  {
    Anno = newAnno;
  }
  
  public int getScartiNB()
  {
    return ScartiNB;
  }

  public void setScartiNB(int newScartiNB)
  {
    ScartiNB = newScartiNB;
  }

  public String getErroriBloccanti()
  {
    return ErroriBloccanti;
  }

  public void setErroriBloccanti(String newErroriBloccanti)
  {
    ErroriBloccanti = newErroriBloccanti;
  }
}
