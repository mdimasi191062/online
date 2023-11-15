package com.ejbBMP;

import com.utl.*;

public class DoppioListinoBMPPK extends AbstractPK  
{

  private int lst;
  private String account;
  private String codeParam;
  public DoppioListinoBMPPK()
  {
  }

 public DoppioListinoBMPPK(int nrgLst, String acc, String code)
  {
   this.account=acc;
   this.lst=nrgLst;
   this.codeParam=code;
  }
  public int getLst()
  {
    return lst;
  }
  public void setLst(int nrgLst)
  {
      lst=nrgLst;
  }
    public String getAccount()
  {
    return account;
  }
  public void setAccount(String acc)
  {
      account=acc;
  }
     public String getCodeParam()
  {
    return codeParam;
  }
  public void setCodeParam(String code)
  {
      codeParam=code;
  }
}