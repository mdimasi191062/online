package com.utl;
import com.utl.AbstractDataBean;

public class DB_AccountDup extends AbstractDataBean
{
  private String CODE_ACCOUNT;
  private String DESC_ACCOUNT;
  private String TOTALE;

  public String getCODE_ACCOUNT()
   {
     return CODE_ACCOUNT;
   }

  public void setCODE_ACCOUNT(String pValue)
   {
     CODE_ACCOUNT = pValue;
   }
  
  public String getDESC_ACCOUNT()
   {
     return DESC_ACCOUNT;
   }

  public void setDESC_ACCOUNT(String pValue)
   {
     DESC_ACCOUNT = pValue;
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
