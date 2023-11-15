package com.ejbBMP;

import com.utl.*;

public class AbortLstBMPPK extends AbstractPK  
{

  private String account;
     
  public AbortLstBMPPK()
  {
  }

  public AbortLstBMPPK(String account)
  {
    this.account=account;
  }

  
  public String getAccount()
  {
    return account;
  }
  public void setAccount(String stringa)
  {
      account=stringa;
  }
  
}