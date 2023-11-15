package com.utl;
import java.io.Serializable;

public class I5_6DETT_ALL_DB_ROW implements Serializable 
{
  private String CODE_DETT_ALL;
  private String CODE_TEST_ALL;
  private String NOME_TABELLA_BILL;
  private String TIPO_FLAG_REFRESH;
  private String TEXT_MSG_ERR;
  
  public I5_6DETT_ALL_DB_ROW()
  {
    CODE_DETT_ALL = null;
    CODE_TEST_ALL = null;
    NOME_TABELLA_BILL = null;
    TIPO_FLAG_REFRESH = null;
    TEXT_MSG_ERR = null;
  }

  public String getCODE_DETT_ALL()
  {
    return CODE_DETT_ALL;
  }

  public void setCODE_DETT_ALL(String new_CODE_DETT_ALL)
  {
    CODE_DETT_ALL = new_CODE_DETT_ALL;
  }

  public String getCODE_TEST_ALL()
  {
    return CODE_TEST_ALL;
  }

  public void setCODE_TEST_ALL(String new_CODE_TEST_ALL)
  {
    CODE_TEST_ALL = new_CODE_TEST_ALL;
  }

  public String getNOME_TABELLA_BILL()
  {
    return NOME_TABELLA_BILL;
  }

  public void setNOME_TABELLA_BILL(String new_NOME_TABELLA_BILL)
  {
    NOME_TABELLA_BILL = new_NOME_TABELLA_BILL;
  }

  public String getTIPO_FLAG_REFRESH()
  {
    return TIPO_FLAG_REFRESH;
  }

  public void setTIPO_FLAG_REFRESH(String new_TIPO_FLAG_REFRESH)
  {
    TIPO_FLAG_REFRESH = new_TIPO_FLAG_REFRESH;
  }

  public String getTEXT_MSG_ERR()
  {
    return TEXT_MSG_ERR;
  }

  public void setTEXT_MSG_ERR(String new_TEXT_MSG_ERR)
  {
    TEXT_MSG_ERR = new_TEXT_MSG_ERR;
  }
  
}