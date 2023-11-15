package com.utl;
import com.utl.AbstractDataBean;

public class DB_Batch_Pre extends AbstractDataBean 
{
  private String CODE_ANAG_BATCH_PRE = "";
  private String DESC_ANAG_BATCH_PRE = "";

  public DB_Batch_Pre()
  {
  }

  public String getCODE_ANAG_BATCH_PRE()
  {
    return CODE_ANAG_BATCH_PRE;
  }

  public void setCODE_ANAG_BATCH_PRE(String newCODE_ANAG_BATCH_PRE)
  {
    CODE_ANAG_BATCH_PRE = newCODE_ANAG_BATCH_PRE;
  }

  public String getDESC_ANAG_BATCH_PRE()
  {
    return DESC_ANAG_BATCH_PRE;
  }

  public void setDESC_ANAG_BATCH_PRE(String newDESC_ANAG_BATCH_PRE)
  {
    DESC_ANAG_BATCH_PRE = newDESC_ANAG_BATCH_PRE;
  }

}