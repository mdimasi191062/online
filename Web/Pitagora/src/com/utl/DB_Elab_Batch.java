package com.utl;
import com.utl.AbstractDataBean;

public class DB_Elab_Batch extends AbstractDataBean
{
               
  private String CODE_FUNZ;
  private String CODE_STATO_BATCH;
  private String DATA_INIZIO;
  private String DATA_FINE;

  public String getCODE_FUNZ()
   {
     return CODE_FUNZ;
   }

  public void setCODE_FUNZ(String pValue)
   {
     CODE_FUNZ = pValue;
   }

  public String getCODE_STATO_BATCH()
   {
     return CODE_STATO_BATCH;
   }

  public void setCODE_STATO_BATCH(String pValue)
   {
     CODE_STATO_BATCH = pValue;
   }
  
  public String getDATA_INIZIO()
   {
     return DATA_INIZIO;
   }

  public void setDATA_INIZIO(String pValue)
   {
     DATA_INIZIO = pValue;
   }

  public String getDATA_FINE()
   {
     return DATA_FINE;
   }

  public void setDATA_FINE(String pValue)
   {
     DATA_FINE = pValue;
   }

}
