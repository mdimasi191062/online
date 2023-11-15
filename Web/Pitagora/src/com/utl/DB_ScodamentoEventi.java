package com.utl;

public class DB_ScodamentoEventi extends AbstractDataBean
{
  /*
  tag attribute: COD_LOTTO
  */
  private String COD_LOTTO = "";

  /*
  tag attribute: DATA_FINE
  */
  private String DATA_FINE = "";
  

  public DB_ScodamentoEventi()
  {
  }


  public void setCOD_LOTTO(String value)
  {
    COD_LOTTO = value;
  }

  public String getCOD_LOTTO()
  {
    return COD_LOTTO;
  }

  public void setDATA_FINE(String value)
  {
    DATA_FINE = value;
  }

  public String getDATA_FINE()
  {
    return DATA_FINE;
  }

  
}
