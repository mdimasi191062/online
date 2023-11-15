package com.utl;


public class ClassFileEstrazioni implements java.io.Serializable
{
  private String nome_file;
  private String path_file;


  public String getNome_file()
  {
    return nome_file;
  }
  public void setNome_file(String stringa)
  {
      nome_file=stringa;
  }

  
  public String getPath_file()
  {
    return path_file;
  }
  public void setPath_file(String stringa)
  {
      path_file=stringa;
  }

}