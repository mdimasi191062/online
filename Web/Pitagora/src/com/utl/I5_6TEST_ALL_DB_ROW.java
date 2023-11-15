package com.utl;
import java.io.Serializable;

public class I5_6TEST_ALL_DB_ROW implements Serializable 
{
  private String CODE_TEST_ALL;
  private String DATA_ELAB;
  private String STATO_ELAB;
  private String DESC_STATO_ELAB;

  public I5_6TEST_ALL_DB_ROW()
  {
    CODE_TEST_ALL = null;
    DATA_ELAB     = null;
    STATO_ELAB    = null;
    DESC_STATO_ELAB = null;
  }


  public String getCODE_TEST_ALL()
  {
    return CODE_TEST_ALL;
  }

  public void setCODE_TEST_ALL(String new_CODE_TEST_ALL)
  {
    CODE_TEST_ALL = new_CODE_TEST_ALL;
  }

  public String getDATA_ELAB()
  {
    return DATA_ELAB;
  }

  public void setDATA_ELAB(String new_DATA_ELAB)
  {
    DATA_ELAB = new_DATA_ELAB;
  }
  
  public String getSTATO_ELAB()
  {
    return STATO_ELAB;
  }

  public void setSTATO_ELAB(String new_STATO_ELAB)
  {
    STATO_ELAB = new_STATO_ELAB;
  }

 public String getDESC_STATO_ELAB()
  {
    return DESC_STATO_ELAB;
  }

  public void setDESC_STATO_ELAB(String new_DESC_STATO_ELAB)
  {
    DESC_STATO_ELAB = new_DESC_STATO_ELAB;
  }

}