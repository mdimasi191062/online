package com.utl;

import java.io.Serializable;

public class StoredProcedureResult implements Serializable
{
  private int erroreSql = 0;
  private String erroreMsg = null;
  
  public StoredProcedureResult()
  {
  }


  public void setErroreSql(int erroreSql)
  {
    this.erroreSql = erroreSql;
  }

  public int getErroreSql()
  {
    return erroreSql;
  }

  public void setErroreMsg(String erroreMsg)
  {
    this.erroreMsg = erroreMsg;
  }

  public String getErroreMsg()
  {
    return erroreMsg;
  }
  
  public boolean isOK()
  {
    return erroreSql ==0;
  }
}
