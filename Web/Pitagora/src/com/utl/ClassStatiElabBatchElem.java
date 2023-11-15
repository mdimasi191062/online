package com.utl;

public class ClassStatiElabBatchElem implements java.io.Serializable
{
  private String code_elab;
  private String flag_sys;
  private String code_funz;
  private String desc_funz;
  private String code_stato;
  private String desc_stato;
  private String code_utente;
  private String data_ora_ini_batch;
  private String code_esito;

  public String getCodeElab()
  {
    return code_elab;
  }
  public void setCodeElab(String stringa)
  {
      code_elab=stringa;
  }
  public String getFlagSys()
  {
    return flag_sys;
  }
  public void setFlagSys(String stringa)
  {
      flag_sys=stringa;
  }
  public String getCodeFunz()
  {
    return code_funz;
  }
  public void setCodeFunz(String stringa)
  {
      code_funz=stringa;
  }
  public String getDescFunz()
  {
    return desc_funz;
  }
  public void setDescFunz(String stringa)
  {
      desc_funz=stringa;
  }
  public String getCodeStato()
  {
    return code_stato;
  }
  public void setCodeStato(String stringa)
  {
      code_stato=stringa;
  }
  public String getDescStato()
  {
    return desc_stato;
  }
  public void setDescStato(String stringa)
  {
      desc_stato=stringa;
  }
  public String getCodeUtente()
  {
    return code_utente;
  }
  public void setCodeUtente(String stringa)
  {
      code_utente=stringa;
  }
  public String getDataOraIniBatch()
  {
    return data_ora_ini_batch;
  }
  public void setDataOraIniBatch(String stringa)
  {
      data_ora_ini_batch=stringa;
  }
  public String getEsitoBatch()
  {
    return code_esito;
  }
  public void setEsitoBatch(String stringa)
  {
      code_esito=stringa;
  }
}