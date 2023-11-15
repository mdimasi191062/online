package com.utl;

public class ClassEstrazioniConf implements java.io.Serializable
{

  private String id_funz;
  private String nome_estrazione;
  private String funzione;
  private String n_parametri;
  private String nome_file;
  private String path_oracle;
  private String path_download;

  public String getId_funz()
  {
    return id_funz;
  }
  public void setId_funz(String stringa)
  {
      id_funz=stringa;
  }

  public String getNome_estrazione()
  {
    return nome_estrazione;
  }
  public void setNome_estrazione(String stringa)
  {
      nome_estrazione=stringa;
  }


  public String getFunzione()
  {
    return funzione;
  }
  public void setFunzione(String stringa)
  {
      funzione=stringa;
  }

  public String getN_parametri()
  {
    return n_parametri;
  }
  public void setN_parametri(String stringa)
  {
      n_parametri=stringa;
  }
  
  public String getNome_file()
  {
    return nome_file;
  }
  public void setNome_file(String stringa)
  {
      nome_file=stringa;
  }

  public String getPath_oracle()
  {
    return path_oracle;
  }
  public void setPath_oracle(String stringa)
  {
      path_oracle=stringa;
  }


    public String getPath_download()
  {
    return path_download;
  }
  public void setPath_download(String stringa)
  {
      path_download=stringa;
  }

  
}