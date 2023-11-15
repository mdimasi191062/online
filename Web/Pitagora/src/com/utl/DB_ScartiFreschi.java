package com.utl;
import com.utl.AbstractDataBean;

public class DB_ScartiFreschi extends AbstractDataBean
{
  private String DATA_SCARTO;
  private String CODE_TIPO_CONTR;
  private String CODE_CONTR;
  private String DESCRIZIONE;
  private String TIPO_SCARTO;
  private String TOTANTE;
  private String TOTPOST;

  public String getDATA_SCARTO()
   {
     return DATA_SCARTO;
   }

  public void setDATA_SCARTO(String pValue)
   {
     DATA_SCARTO = pValue;
   }

  public String getCODE_TIPO_CONTR()
   {
     return CODE_TIPO_CONTR;
   }

  public void setCODE_TIPO_CONTR(String pValue)
   {
     CODE_TIPO_CONTR = pValue;
   }
  
  public String getCODE_CONTR()
   {
     return CODE_CONTR;
   }

  public void setCODE_CONTR(String pValue)
   {
     CODE_CONTR = pValue;
   }
  
  public String getDESCRIZIONE()
   {
     return DESCRIZIONE;
   }

  public void setDESCRIZIONE(String pValue)
   {
     DESCRIZIONE = pValue;
   }

  public String getTIPO_SCARTO()
   {
     return TIPO_SCARTO;
   }

  public void setTIPO_SCARTO(String pValue)
   {
     TIPO_SCARTO = pValue;
   }

  public void setTOTANTE(String pValue)
   {
     TOTANTE = pValue;
   }

  public String getTOTANTE()
   {
     return TOTANTE;
   }

  public void setTOTPOST(String pValue)
   {
     TOTPOST = pValue;
   }

  public String getTOTPOST()
   {
     return TOTPOST;
   }
}
