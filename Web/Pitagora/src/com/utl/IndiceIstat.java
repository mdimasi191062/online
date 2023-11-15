package com.utl;

public class IndiceIstat implements java.io.Serializable
{
  private String Anno;
  private Float Indice;


   public String getAnno()
  {
    return Anno;
  }
  public void setAnno(String anno)
  {
    Anno=anno;
  }

  public Float getIndice()
  {
    return Indice;
  }
  public void setIndice(Float indice)
  {
      Indice=indice;
  }
 
}