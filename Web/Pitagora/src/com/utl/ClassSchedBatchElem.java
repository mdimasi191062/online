package com.utl;

public class ClassSchedBatchElem implements java.io.Serializable
{
  private String code_elab;
  private String code_funz;
  private String desc_funz;
  private String code_stato_sched;
  private String desc_stato_sched;
  private String code_utente;
  private String data_ora_ins_sched;
  private String data_ora_sched;
  private String id_schedulazione;

  
  public String getIdSched()
  {
    return id_schedulazione;
  }
  public void setIdSched(String stringa)
  {
      id_schedulazione=stringa;
  }
  public String getCodeElab()
  {
    return code_elab;
  }
  public void setCodeElab(String stringa)
  {
      code_elab=stringa;
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
  public String getCodeStatoSched()
  {
    return code_stato_sched;
  }
  public void setCodeStatoSched(String stringa)
  {
      code_stato_sched=stringa;
  }
  public String getDescStatoSched()
  {
    return desc_stato_sched;
  }
  public void setDescStatoSched(String stringa)
  {
      desc_stato_sched=stringa;
  }
  public String getCodeUtente()
  {
    return code_utente;
  }
  public void setCodeUtente(String stringa)
  {
      code_utente=stringa;
  }
  public String getDataOraInsSched()
  {
    return data_ora_ins_sched;
  }
  public void setDataOraInsSched(String stringa)
  {
      data_ora_ins_sched=stringa;
  }
  public String getDataOraSched()
  {
    return data_ora_sched;
  }
  public void setDataOraSched(String stringa)
  {
      data_ora_sched=stringa;
  }
}