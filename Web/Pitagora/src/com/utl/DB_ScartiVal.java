package com.utl;
import com.utl.AbstractDataBean;

public class DB_ScartiVal extends AbstractDataBean
{
  private String CODE_TIPO_CONTR;
  private String DESC_TIPO_CONTR;
  private String CODE_MOTIVO_SCARTO;
  private String DESC_MOTIVO_SCARTO;
  private String DATA_CREAZ_MODIF;	
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
  
  public String getCODE_MOTIVO_SCARTO()
   {
     return CODE_MOTIVO_SCARTO;
   }

  public void setCODE_MOTIVO_SCARTO(String pValue)
   {
     CODE_MOTIVO_SCARTO = pValue;
   }
  
  public String getDESC_MOTIVO_SCARTO()
   {
     return DESC_MOTIVO_SCARTO;
   }

  public void setDESC_MOTIVO_SCARTO(String pValue)
   {
     DESC_MOTIVO_SCARTO = pValue;
   }

  public String getDATA_CREAZ_MODIF()
   {
     return DATA_CREAZ_MODIF;
   }

  public void setDATA_CREAZ_MODIF(String pValue)
   {
     DATA_CREAZ_MODIF = pValue;
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
