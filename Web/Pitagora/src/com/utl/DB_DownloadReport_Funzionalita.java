package com.utl;
import com.utl.AbstractDataBean;

public class DB_DownloadReport_Funzionalita extends AbstractDataBean 
{
    private String CODE_FUNZ = "";
    private String DESC_FUNZ = "";
    private String TIPO_FUNZ = "";
    private String QUERY_SERVIZI = "";
    private String QUERY_PERIODI = "";
    private String QUERY_ACCOUNT = "";
    private String ESTENSIONE_FILE = "";
    private String ESTENSIONE_FILE_STORICO = "";
    private String PATH_REPORT = "";
    private String PATH_REPORT_STORICI = "";
    private String PATH_FILE_ZIP = "";
    private String FLAG_SYS = "";

  public void setCODE_FUNZ(String cODE_FUNZ)
  {
    this.CODE_FUNZ = cODE_FUNZ;
  }

  public String getCODE_FUNZ()
  {
    return CODE_FUNZ;
  }

  public void setDESC_FUNZ(String dESC_FUNZ)
  {
    this.DESC_FUNZ = dESC_FUNZ;
  }

  public String getDESC_FUNZ()
  {
    return DESC_FUNZ;
  }

  public void setTIPO_FUNZ(String tIPO_FUNZ)
  {
    this.TIPO_FUNZ = tIPO_FUNZ;
  }

  public String getTIPO_FUNZ()
  {
    return TIPO_FUNZ;
  }

  public void setQUERY_SERVIZI(String qUERY_SERVIZI)
  {
    this.QUERY_SERVIZI = qUERY_SERVIZI;
  }

  public String getQUERY_SERVIZI()
  {
    return QUERY_SERVIZI;
  }

  public void setQUERY_ACCOUNT(String qUERY_ACCOUNT)
  {
    this.QUERY_ACCOUNT = qUERY_ACCOUNT;
  }

  public String getQUERY_ACCOUNT()
  {
    return QUERY_ACCOUNT;
  }

  public void setPATH_REPORT(String pATH_REPORT)
  {
    this.PATH_REPORT = pATH_REPORT;
  }

  public String getPATH_REPORT()
  {
    return PATH_REPORT;
  }

  public void setPATH_FILE_ZIP(String pATH_FILE_ZIP)
  {
    this.PATH_FILE_ZIP = pATH_FILE_ZIP;
  }

  public String getPATH_FILE_ZIP()
  {
    return PATH_FILE_ZIP;
  }

  public void setFLAG_SYS(String fLAG_SYS)
  {
    this.FLAG_SYS = fLAG_SYS;
  }

  public String getFLAG_SYS()
  {
    return FLAG_SYS;
  }

  public void setQUERY_PERIODI(String qUERY_PERIODI)
  {
    this.QUERY_PERIODI = qUERY_PERIODI;
  }

  public String getQUERY_PERIODI()
  {
    return QUERY_PERIODI;
  }

  public void setESTENSIONE_FILE(String eSTENSIONE_FILE)
  {
    this.ESTENSIONE_FILE = eSTENSIONE_FILE;
  }

  public String getESTENSIONE_FILE()
  {
    return ESTENSIONE_FILE;
  }

  public void setESTENSIONE_FILE_STORICO(String eSTENSIONE_FILE_STORICO)
  {
    this.ESTENSIONE_FILE_STORICO = eSTENSIONE_FILE_STORICO;
  }

  public String getESTENSIONE_FILE_STORICO()
  {
    return ESTENSIONE_FILE_STORICO;
  }

  public void setPATH_REPORT_STORICI(String pATH_REPORT_STORICI)
  {
    this.PATH_REPORT_STORICI = pATH_REPORT_STORICI;
  }

  public String getPATH_REPORT_STORICI()
  {
    return PATH_REPORT_STORICI;
  }
}
