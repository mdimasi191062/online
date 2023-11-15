package com.utl;

public class ClassCLLI implements java.io.Serializable
{
  private String code_clli;
  private String nome_sede;


  public String getCode_clli()
  {
    return code_clli;
  }
  public void setCode_clli(String stringa)
  {
      code_clli=stringa;
  }

  
  public String getNome_sede()
  {
    return nome_sede;
  }
  public void setNome_sede(String stringa)
  {
      nome_sede=stringa;
  }

}