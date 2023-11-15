package com.utl;

public class SitoElem implements java.io.Serializable
{
  private String codeSito;
  private String descSito;
  private String DataSito;
  private double ImportoTariffaFittoSito;
  private double ImportoTariffaSecuritySito;
  private int numModuliUll;
  private int numModuliItc;
  private int numTariffe;

  public String getCodeSito()
  { 
    return codeSito; 
  }
  public void setCodeSito(String stringa)
  {  
    codeSito=stringa;
  }
  public String getDataSito()
  { 
    return DataSito; 
  }
  public void setDataSito(String stringa)
  {  
    DataSito=stringa;
  }
  public double getImportoTariffaFittoSito()
  { 
    return ImportoTariffaFittoSito; 
  }
  public void setImportoTariffaFittoSito(double numero)
  {  
    ImportoTariffaFittoSito=numero;
  }

  public double getImportoTariffaSecuritySito()
  { 
    return ImportoTariffaSecuritySito; 
  }
  public void setImportoTariffaSecuritySito(double numero)
  {  
    ImportoTariffaSecuritySito=numero;
  }


  public int getnumModuliUll()
  { 
    return numModuliUll; 
  }
  public void setnumModuliUll(int numero)
  {  
    numModuliUll=numero;
  }

  public int getnumModuliItc()
  { 
    return numModuliItc; 
  }
  public void setnumModuliItc(int numero)
  {  
    numModuliItc=numero;
  }


 public int getNumTariffe()
  {  
    return numTariffe; 
  }
  public void setNumTariffe(int stringa)
  {  
    numTariffe=stringa; 
  }


  public String getDescSito()
  {  
    return descSito; 
  }
  public void setDescSito(String stringa)
  {  
    descSito=stringa; 
  }
}