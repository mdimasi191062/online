package com.utl;

public class ProdServElem implements java.io.Serializable
{
  private String codePs;
  private String descPs;
//MMM 24/10/02 inizio
  //private int QtaPs;
   private Double QtaPs;
//MMM 24/10/02 fine
  
//Tommaso inizio 09/10/2002
  private String dataIni;
//Tommaso fine 09/10/2002

  public String getCodePs()
  {
    return codePs;
  }
  public void setCodePs(String stringa)
  {
      codePs=stringa;
  }
  public String getDescPs()
  {
    return descPs;
  }
  public void setDescPs(String stringa)
  {
      descPs=stringa;
  }

///MMM 24/10/02 fine
public Double getQtaPs()
  {
      return QtaPs;
  }

  public void setQtaPs(Double valore)
  {
        QtaPs=valore;
  } 
/*
public int getQtaPs()
  {
      return QtaPs;
  }
  public void setQtaPs(int valore)
  {
        QtaPs=valore;
  }      
*/
//MMM 24/10/02 fine

//Tommaso inizio 09/10/2002
  public String getDataIni()
  {
    return dataIni;
  }
  public void setDataIni(String stringa)
  {
      dataIni=stringa;
  }
//Tommaso fine 09/10/2002
}