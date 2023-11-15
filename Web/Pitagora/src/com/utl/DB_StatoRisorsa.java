package com.utl;
import com.utl.AbstractDataBean;

public class DB_StatoRisorsa extends AbstractDataBean
{
  private String DESC_ID_RISORSA;
  private String NOTE;
  private String CODE_DOC;
  private String CODE_ACCOUNT;
  private String CODE_TIPO_CONTR;
  private String DATA_INIZIO;
  private String DATA_FINE;
  private String DATA_EMISSIONE;
  private String IMPT_TOT;

    public String getIMPT_TOT()
     {
       return IMPT_TOT;
     }

    public void setIMPT_TOT(String pValue)
     {
       IMPT_TOT = pValue;
     }
     
    public String getDATA_EMISSIONE()
     {
       return DATA_EMISSIONE;
     }

    public void setDATA_EMISSIONE(String pValue)
     {
       DATA_EMISSIONE = pValue;
     }     
     
    public String getDATA_FINE()
     {
       return DATA_FINE;
     }

    public void setDATA_FINE(String pValue)
     {
       DATA_FINE = pValue;
     }
     
    public String getDATA_INIZIO()
     {
       return DATA_INIZIO;
     }

    public void setDATA_INIZIO(String pValue)
     {
       DATA_INIZIO = pValue;
     }
     
    public String getCODE_TIPO_CONTR()
     {
       return CODE_TIPO_CONTR;
     }

    public void setCODE_TIPO_CONTR(String pValue)
     {
       CODE_TIPO_CONTR = pValue;
     }
     
    public String getCODE_ACCOUNT()
     {
       return CODE_ACCOUNT;
     }

    public void setCODE_ACCOUNT(String pValue)
     {
       CODE_ACCOUNT = pValue;
     }
     
    public String getCODE_DOC()
     {
       return CODE_DOC;
     }

    public void setCODE_DOC(String pValue)
     {
       CODE_DOC = pValue;
     }
     
  public String getDESC_ID_RISORSA()
   {
     return DESC_ID_RISORSA;
   }

  public void setDESC_ID_RISORSA(String pValue)
   {
     DESC_ID_RISORSA = pValue;
   }
  
  public String getNOTE()
   {
     return NOTE;
   }

  public void setNOTE(String pValue)
   {
     NOTE = pValue;
   }
  
}
