package com.utl;

public class DB_ElabBatchResocontoSAP extends DB_ElabBatch
{
  private String REWRITE = "";

  public void setREWRITE(String value)
  {
    REWRITE = value;
  }

  public String getREWRITE()
  {
    return REWRITE;
  }

}