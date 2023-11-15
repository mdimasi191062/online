package com.utl;
import com.utl.AbstractDataBean;

public class DB_ScartiPopolamento extends AbstractDataBean
{
  private String CODE_TIPO_CONTR;
  private String DESC_TIPO_CONTR;
  private String CODE_DETT_SCARTO;
  private String DESCRIZIONE_SCARTO;
  private String TOTALE;

  public String getCODE_TIPO_CONTR()
   {
     return CODE_TIPO_CONTR;
   }

  public void setCODE_TIPO_CONTR(String pValue)
   {
     CODE_TIPO_CONTR = pValue;
   }
  
  public String getDESC_TIPO_CONTR()
   {
     return DESC_TIPO_CONTR;
   }

  public void setDESC_TIPO_CONTR(String pValue)
   {
     DESC_TIPO_CONTR = pValue;
   }
  
  public String getCODE_DETT_SCARTO()
   {
     return CODE_DETT_SCARTO;
   }

  public void setCODE_DETT_SCARTO(String pValue)
   {
     CODE_DETT_SCARTO = pValue;
   }
  
  public String getDESCRIZIONE_SCARTO()
   {
     return DESCRIZIONE_SCARTO;
   }

  public void setDESCRIZIONE_SCARTO(String pValue)
   {
     DESCRIZIONE_SCARTO = pValue;
   }

  public void setTOTALE(String pValue)
   {
     TOTALE = pValue;
   }

  public String getTOTALE()
   {
     return TOTALE;
   }
}
