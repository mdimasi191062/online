package com.utl;
import com.utl.AbstractDataBean;

public class DB_Map extends AbstractDataBean 
{
  private String CODE_MODAL_APPL;
  private String DESC_MODAL_APPL;

  public DB_Map()
  {
  }

  public String getCODE_MODAL_APPL()
  {
    return CODE_MODAL_APPL;
  }

  public void setCODE_MODAL_APPL(String newCODE_MODAL_APPL)
  {
    CODE_MODAL_APPL = newCODE_MODAL_APPL;
  }

  public String getDESC_MODAL_APPL()
  {
    return DESC_MODAL_APPL;
  }

  public void setDESC_MODAL_APPL(String newDESC_MODAL_APPL)
  {
    DESC_MODAL_APPL = newDESC_MODAL_APPL;
  }
}