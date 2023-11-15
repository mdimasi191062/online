package com.ejbSTL;
import java.io.Serializable;

public class I5_2PROMOZIONI_ROW implements Serializable 
{
  private Integer CODE_PROMOZIONE;
  private String DESCRIZIONE;
  private Integer TIPO_PROMOZIONE;
  private Float VALORE;
  private String STORED_PROCEDURE;
  private String DESCR_ESTESA;
  private String CODE_CLASSE_OF;
  private String CLASSE_OF;
  private String CODE_SERVIZIO;

  public I5_2PROMOZIONI_ROW()
  {
	CODE_PROMOZIONE = null;
	DESCRIZIONE = null;
	TIPO_PROMOZIONE = null;
	VALORE = null;
	STORED_PROCEDURE = null;   
        DESCR_ESTESA = null;
        CODE_CLASSE_OF = null;
        CLASSE_OF = null;
        CODE_SERVIZIO = null;
  }

  public Integer getCODE_PROMOZIONE()
  {
    return CODE_PROMOZIONE;
  }

  public void setCODE_PROMOZIONE(Integer new_CODE_PROMOZIONE)
  {
    CODE_PROMOZIONE = new_CODE_PROMOZIONE;
  }
  
  public String getDESCRIZIONE()
  {
    return DESCRIZIONE;
  }

  public void setDESCRIZIONE(String new_DESCRIZIONE)
  {
    DESCRIZIONE = new_DESCRIZIONE;
  }
  
    public String getDESCR_ESTESA()
    {
      return DESCR_ESTESA;
    }

    public void setDESCR_ESTESA(String new_DESCR_ESTESA)
    {
      DESCR_ESTESA = new_DESCR_ESTESA;
    }
  public Integer getTIPO_PROMOZIONE()
  {
    return TIPO_PROMOZIONE;
  }

  public void setTIPO_PROMOZIONE(Integer new_TIPO_PROMOZIONE)
  {
    TIPO_PROMOZIONE = new_TIPO_PROMOZIONE;
  }  
  
  public Float getVALORE()
  {
    return VALORE;
  }

  public void setVALORE(Float new_VALORE)
  {
    VALORE = new_VALORE;
  }
  
  public String getSTORED_PROCEDURE()
  {
    return STORED_PROCEDURE;
  }

  public void setSTORED_PROCEDURE(String new_STORED_PROCEDURE)
  {
    STORED_PROCEDURE = new_STORED_PROCEDURE;
  }
    
    public String getCODE_CLASSE_OF()
    {
      return CODE_CLASSE_OF;
    }

    public void setCODE_CLASSE_OF(String new_CODE_CLASSE_OF)
    {
      CODE_CLASSE_OF = new_CODE_CLASSE_OF;
    }   
    
    public String getCLASSE_OF()
    {
      return CLASSE_OF;
    }

    public void setCLASSE_OF(String new_CLASSE_OF)
    {
      CLASSE_OF = new_CLASSE_OF;
    }    
    public String getCODE_SERVIZIO()
    {
      return CODE_SERVIZIO;
    }

    public void setCODE_SERVIZIO(String new_CODE_SERVIZIO)
    {
      CODE_SERVIZIO = new_CODE_SERVIZIO;
    }        
}