package com.utl;

public class PromozioniDett extends PromozioniElem
{
  private String DIV;
  private String DFV;
  private String DIVC;
  private String DFVC;
  private String NUMC;
  private String CODE_PROG_BILL;

  public String getDIV()
  {
    return DIV;
  }
  public void setDIV(String new_DIV)
  {
    DIV = new_DIV;
  }

  public String getDFV()
  {
    return DFV;
  }
  public void setDFV(String new_DFV)
  {
    DFV = new_DFV;
  }

  public String getDIVC()
  {
    return DIVC;
  }
  public void setDIVC(String new_DIVC)
  {
    DIVC = new_DIVC;
  }

  public String getDFVC()
  {
    return DFVC;
  }
  public void setDFVC(String new_DFVC)
  {
    DFVC = new_DFVC;
  }

  public String getNUMC()
  {
    return NUMC;
  }
  public void setNUMC(String new_NUMC)
  {
    NUMC = new_NUMC;
  }

  public String getCODE_PROG_BILL()
  {
    return CODE_PROG_BILL;
  }
  public void setCODE_PROG_BILL(String new_CODE_PROG_BILL)
  {
    CODE_PROG_BILL = new_CODE_PROG_BILL;
  }
  
  public String toString()
  {
    //String ritorno = this.getCodePromozione()+','+DIV+','+DFV+','+DIVC+','+DFVC+','+CODE_PROG_BILL+','+NUMC;
    String ritorno = this.getCodePromozione();
    return ritorno;
  }
}