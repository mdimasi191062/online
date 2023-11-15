package com.utl;
import com.utl.AbstractDataBean;

public class DB_Sconti extends AbstractDataBean
{
  private String VALO_PERC="";
  private String VALO_LIM_MIN="";
  private String VALO_LIM_MAX="";
  private String CODE_SCONTO="";
  private String DESC_SCONTO="";
  private String VALO_DECR="";

  public DB_Sconti()
  {
  }

  public String getVALO_PERC()
  {
    return VALO_PERC;
  }

  public void setVALO_PERC(String newVALO_PERC)
  {
    VALO_PERC = newVALO_PERC;
  }

  public String getVALO_LIM_MIN()
  {
    return VALO_LIM_MIN;
  }

  public void setVALO_LIM_MIN(String newVALO_LIM_MIN)
  {
    VALO_LIM_MIN = newVALO_LIM_MIN;
  }

  public String getVALO_LIM_MAX()
  {
    return VALO_LIM_MAX;
  }

  public void setVALO_LIM_MAX(String newVALO_LIM_MAX)
  {
    VALO_LIM_MAX = newVALO_LIM_MAX;
  }

  public String getCODE_SCONTO()
  {
    return CODE_SCONTO;
  }

  public void setCODE_SCONTO(String newCODE_SCONTO)
  {
    CODE_SCONTO = newCODE_SCONTO;
  }

  public String getDESC_SCONTO()
  {
    return DESC_SCONTO;
  }

  public void setDESC_SCONTO(String newDESC_SCONTO)
  {
    DESC_SCONTO = newDESC_SCONTO;
  }

  public String getVALO_DECR()
  {
    return VALO_DECR;
  }

  public void setVALO_DECR(String newVALO_DECR)
  {
    VALO_DECR = newVALO_DECR;
  }
}