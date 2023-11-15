package com.utl;

public class DB_AliquotaIva extends AbstractDataBean
{
  /*
  tag attribute: CODE_ALIQUOTA
  */
  private String CODE_ALIQUOTA = "";

  /*
  tag attribute: ALIQUOTA
  */
  private String ALIQUOTA = "";

  /*
  tag attribute: DESC_ALIQUOTA
  */
  private String DESC_ALIQUOTA = "";

  private String DATA_INIZIO_VALID = "";
  /*
  tag attribute: DATA_FINE_VALID
  */
  private String DATA_FINE_VALID = "";
  
  private String FLAG_MODIF = "";

  public DB_AliquotaIva()
  {
  }


  public void setCODE_ALIQUOTA(String value)
  {
    CODE_ALIQUOTA = value;
  }

  public String getCODE_ALIQUOTA()
  {
    return CODE_ALIQUOTA;
  }

  public void setALIQUOTA(String value)
  {
    ALIQUOTA = value;
  }

  public String getALIQUOTA()
  {
    return ALIQUOTA;
  }

  public void setDESC_ALIQUOTA(String value)
  {
    DESC_ALIQUOTA = value;
  }

  public String getDESC_ALIQUOTA()
  {
    return DESC_ALIQUOTA;
  }

  public void setDATA_INIZIO_VALID(String value)
  {
    DATA_INIZIO_VALID = value;
  }

  public String getDATA_INIZIO_VALID()
  {
    return DATA_INIZIO_VALID;
  }


  public void setDATA_FINE_VALID(String value)
  {
    DATA_FINE_VALID = value;
  }

  public String getDATA_FINE_VALID()
  {
    return DATA_FINE_VALID;
  }

  public String getFLAG_MODIF()
  {
    return FLAG_MODIF;
  }
  public void setFLAG_MODIF(String value)
  {
    FLAG_MODIF = value;
  }
  
}
