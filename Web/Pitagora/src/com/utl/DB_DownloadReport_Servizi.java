package com.utl;
import com.utl.AbstractDataBean;

public class DB_DownloadReport_Servizi extends AbstractDataBean 
{
    private String CODE_TIPO_CONTR = "";
    private String DESC_TIPO_CONTR = "";
    private String FLAG_SYS     = "";


  public void setCODE_TIPO_CONTR(String cODE_TIPO_CONTR)
  {
    this.CODE_TIPO_CONTR = cODE_TIPO_CONTR;
  }

  public String getCODE_TIPO_CONTR()
  {
    return CODE_TIPO_CONTR;
  }

  public void setDESC_TIPO_CONTR(String dESC_TIPO_CONTR)
  {
    this.DESC_TIPO_CONTR = dESC_TIPO_CONTR;
  }

  public String getDESC_TIPO_CONTR()
  {
    return DESC_TIPO_CONTR;
  }

  public void setFLAG_SYS(String fLAG_SYS)
  {
    this.FLAG_SYS = fLAG_SYS;
  }

  public String getFLAG_SYS()
  {
    return FLAG_SYS;
  }
}
