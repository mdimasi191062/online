package com.utl;

public class I5_6ELAB_UPL_FILES_ROW implements java.io.Serializable
{
  private String CODE_ELAB_UPL;
  private String CODE_ELAB;
  private String CODE_FUNZ;
  private String CODE_STATO_BATCH;
  private String CODE_UTENTE;
  private String NUM_RIGA_ELAB;
  private String DESC_ERROR;
  private String FILE_DOWNLOAD;
  
  public String getCODE_ELAB_UPL()
  {
    return CODE_ELAB_UPL;
  }
  public void setCODE_ELAB_UPL(String stringa)
  {
      CODE_ELAB_UPL=stringa;
  }
  
  public String getFILE_DOWNLOAD()
  {
    return FILE_DOWNLOAD;
  }
  public void setFILE_DOWNLOAD(String stringa)
  {
      FILE_DOWNLOAD=stringa;
  }
  
  public String getCODE_ELAB()
  {
    return CODE_ELAB;
  }
  public void setCODE_ELAB(String stringa)
  {
      CODE_ELAB=stringa;
  }
  
  public void setCODE_FUNZ(String stringa)
  {
      CODE_FUNZ=stringa;
  }
  public String getCODE_FUNZ()
  {
    return CODE_FUNZ;
  }

  public void setCODE_STATO_BATCH(String stringa)
  {
      CODE_STATO_BATCH=stringa;
  }
  public String getCODE_STATO_BATCH()
  {
    return CODE_STATO_BATCH;
  }

  public void setCODE_UTENTE(String stringa)
  {
      CODE_UTENTE=stringa;
  }
  public String getCODE_UTENTE()
  {
    return CODE_UTENTE;
  }

  public void setNUM_RIGA_ELAB(String stringa)
  {
      NUM_RIGA_ELAB=stringa;
  }
  public String getNUM_RIGA_ELAB()
  {
    return NUM_RIGA_ELAB;
  }

  public void setDESC_ERROR(String stringa)
  {
      DESC_ERROR=stringa;
  }
  public String getDESC_ERROR()
  {
    return DESC_ERROR;
  }
  
}