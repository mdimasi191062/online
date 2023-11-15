package com.utl;

import java.io.Serializable;

public class TariffaOpereSpecialiPar implements Serializable 
{
  public TariffaOpereSpecialiPar(){}
  public TariffaOpereSpecialiPar(String colonna0,String colonna1,String colonna2,String colonna3,String colonna4)
  {
    this.colonna0 = colonna0;
    this.colonna1 = colonna1;
    this.colonna2 = colonna2;
    this.colonna3 = colonna3;
    this.colonna4 = colonna4;
  }
  
  private String colonna0;
  private String colonna1;
  private String colonna2;
  private String colonna3;
  private String colonna4;

  public void setColonna0(String colonna0)
  {
    this.colonna0 = colonna0;
  }

  public String getColonna0()
  {
    return colonna0;
  }

  public void setColonna1(String colonna1)
  {
    this.colonna1 = colonna1;
  }

  public String getColonna1()
  {
    return colonna1;
  }

  public void setColonna2(String colonna2)
  {
    this.colonna2 = colonna2;
  }

  public String getColonna2()
  {
    return colonna2;
  }

  public void setColonna3(String colonna3)
  {
    this.colonna3 = colonna3;
  }

  public String getColonna3()
  {
    return colonna3;
  }

  public void setColonna4(String colonna4)
  {
    this.colonna4 = colonna4;
  }

  public String getColonna4()
  {
    return colonna4;
  }
}
