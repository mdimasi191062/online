package com.utl;
import com.utl.AbstractDataBean;

public class DB_Frequenze extends AbstractDataBean 
{
  private String CODE_FREQ_APPL;
  private String DESC_FREQ_APPL;
  private String VALO_FREQ_APPL;

  public DB_Frequenze()
  {
  }

  public String getCODE_FREQ_APPL()
  {
    return CODE_FREQ_APPL;
  }

  public void setCODE_FREQ_APPL(String newCODE_FREQ_APPL)
  {
    CODE_FREQ_APPL = newCODE_FREQ_APPL;
  }

  public String getDESC_FREQ_APPL()
  {
    return DESC_FREQ_APPL;
  }

  public void setDESC_FREQ_APPL(String newDESC_FREQ_APPL)
  {
    DESC_FREQ_APPL = newDESC_FREQ_APPL;
  }

  public String getVALO_FREQ_APPL()
  {
    return VALO_FREQ_APPL;
  }

  public void setVALO_FREQ_APPL(String newVALO_FREQ_APPL)
  {
    VALO_FREQ_APPL = newVALO_FREQ_APPL;
  }
}