package com.utl;
import com.utl.AbstractDataBean;
public class DB_CAT_Servizio extends DB_Servizio
{

  private String DATA_INIZIO_VALID = "";
  private String DATA_FINE_VALID = "";
  private String APP_VAL_EUR;

  public String getDATA_INIZIO_VALID()
  {
    return DATA_INIZIO_VALID;
  }
  public void setDATA_INIZIO_VALID(String newDATA_INIZIO_VALID)
  {
    DATA_INIZIO_VALID = newDATA_INIZIO_VALID;
  }

  public String getDATA_FINE_VALID()
  {
    return DATA_FINE_VALID;
  }
  public void setDATA_FINE_VALID(String newDATA_FINE_VALID)
  {
    DATA_FINE_VALID = newDATA_FINE_VALID;
  }

  public String getAPP_VAL_EUR()
  {
    return APP_VAL_EUR;
  }
  public void setAPP_VAL_EUR(String new_APP_VAL_EUR)
  {
    APP_VAL_EUR = new_APP_VAL_EUR;
  }
}