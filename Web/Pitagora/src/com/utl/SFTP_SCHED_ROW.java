package com.utl;

public class SFTP_SCHED_ROW implements java.io.Serializable
{
  private String id_message;
  private String code_elab;
  private String code_utente;
  private String start_sched_time;
  private String start_time;
  private String end_time;
  private String Modifica;
  private String desc_message;
  
  
  public void setId_message(String id_message)
  {
    this.id_message = id_message;
    this.Modifica=id_message;
  }

  public String getId_message()
  {
    return id_message;
  }

  public void setModifica(String modifica)
  {
    this.Modifica = modifica;
  }

  public String getModifica()
  {
    return Modifica;
  }

  public void setCode_elab(String code_elab)
  {
    this.code_elab = code_elab;
  }

  public String getCode_elab()
  {
    return code_elab;
  }

  public void setCode_utente(String code_utente)
  {
    this.code_utente = code_utente;
  }

  public String getCode_utente()
  {
    return code_utente;
  }

  public void setStart_sched_time(String start_sched_time)
  {
    this.start_sched_time = start_sched_time;
  }

  public String getStart_sched_time()
  {
    return start_sched_time;
  }

  public void setStart_time(String start_time)
  {
    this.start_time = start_time;
  }

  public String getStart_time()
  {
    return start_time;
  }

  public void setEnd_time(String end_time)
  {
    this.end_time = end_time;
  }

  public String getEnd_time()
  {
    return end_time;
  }

  public void setDesc_message(String desc_message)
  {
    this.desc_message = desc_message;
  }

  public String getDesc_message()
  {
    return desc_message;
  }
}
