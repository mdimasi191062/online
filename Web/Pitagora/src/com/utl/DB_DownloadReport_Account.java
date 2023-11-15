package com.utl;
import com.utl.AbstractDataBean;

public class DB_DownloadReport_Account extends AbstractDataBean 
{
    private String CODE_ACCOUNT = "";
    private String DESC_ACCOUNT = "";
    private String FLAG_SYS     = "";

  public void setCODE_ACCOUNT(String cODE_ACCOUNT)
  {
    this.CODE_ACCOUNT = cODE_ACCOUNT;
  }

  public String getCODE_ACCOUNT()
  {
    return CODE_ACCOUNT;
  }

  public void setDESC_ACCOUNT(String dESC_ACCOUNT)
  {
    this.DESC_ACCOUNT = dESC_ACCOUNT;
  }

  public String getDESC_ACCOUNT()
  {
    return DESC_ACCOUNT;
  }

  public void setFLAG_SYS(String fLAG_SYS)
  {
    this.FLAG_SYS = fLAG_SYS;
  }

  public String getFLAG_SYS()
  {
    return FLAG_SYS;
  }
}
