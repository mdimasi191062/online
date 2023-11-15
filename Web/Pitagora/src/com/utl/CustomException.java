package com.utl;
import java.rmi.RemoteException;

public class CustomException extends Exception 
{
  private String codice;
  private String descrizione;
  private String nome_funz;
  private String nome_ejb;
  private String tipo;
  
  public CustomException(String codice,String descrizione,String nome_funz,String nome_ejb,String tipo)
  {
    super(codice);
    this.codice=codice;
    this.descrizione=descrizione;
    this.nome_funz=nome_funz;
    this.nome_ejb=nome_ejb;
    this.tipo=tipo;
    
  }

  public String getExceptionDescription()
  {
    return descrizione;
  }
  public String getCodice()
  {
    return codice;
  }
  public String getTipo()
  {
    return tipo;
  }
  public String getNomeFunz()
  {
    return nome_funz;
  }
  public String getNomeEjb()
  {
    return nome_ejb;
  }
}
