package com.utl;


public class ListaFilesManualiPK implements java.io.Serializable
{
  private String nomeUtente;
  private String cognomeUtente;
  private String dataElaborazione;
  private String nomeFile;
  
  
  public ListaFilesManualiPK()
  {
  }

  public void setNomeUtente(String nomeUtente)
  {
    this.nomeUtente = nomeUtente;
  }

  public String getNomeUtente()
  {
    return nomeUtente;
  }

  public void setCognomeUtente(String cognomeUtente)
  {
    this.cognomeUtente = cognomeUtente;
  }

  public String getCognomeUtente()
  {
    return cognomeUtente;
  }

  public void setDataElaborazione(String dataElaborazione)
  {
    this.dataElaborazione = dataElaborazione;
  }

  public String getDataElaborazione()
  {
    return dataElaborazione;
  }

  public void setNomeFile(String nomeFile)
  {
    this.nomeFile = nomeFile;
  }

  public String getNomeFile()
  {
    return nomeFile;
  }
}
