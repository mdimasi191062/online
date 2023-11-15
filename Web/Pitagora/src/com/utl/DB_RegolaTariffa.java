package com.utl;

public class DB_RegolaTariffa extends AbstractDataBean 
{
  /*
  tag attribute: CODE_REGOLA
  */
  private String CODE_REGOLA = "";
  /*
  tag attribute: DESC_REGOLA
  */
  private String DESC_REGOLA = "";
  /*
  tag attribute: DESC_ESTESA_REGOLA
  */
  private String DESC_ESTESA_REGOLA = "";
  /*
  tag attribute: TIPO_FLAG_REGOLA
  */
  private String TIPO_FLAG_REGOLA = "";
  /*
  tag attribute: TIPO_PARAMETRO
  */
  private String TIPO_PARAMETRO = "";
  /*
  tag attribute: DESC_PARAMETRO
  */
  private String DESC_PARAMETRO = "";
  /*
  tag attribute: PARAMETRO
  */
  private String PARAMETRO = "";
  /*
  tag attribute: PARAMETRO
  */
  private String DESC_ACCOUNT = "";



  public void setCODE_REGOLA(String value)
  {
    CODE_REGOLA = value;
  }


  public String getCODE_REGOLA()
  {
    return CODE_REGOLA;
  }


  public void setDESC_REGOLA(String value)
  {
    DESC_REGOLA = value;
  }


  public String getDESC_REGOLA()
  {
    return DESC_REGOLA;
  }


  public void setDESC_ESTESA_REGOLA(String value)
  {
    DESC_ESTESA_REGOLA = value;
  }


  public String getDESC_ESTESA_REGOLA()
  {
    return DESC_ESTESA_REGOLA;
  }


  public void setTIPO_FLAG_REGOLA(String value)
  {
    TIPO_FLAG_REGOLA = value;
  }


  public String getTIPO_FLAG_REGOLA()
  {
    return TIPO_FLAG_REGOLA;
  }


  public void setTIPO_PARAMETRO(String value)
  {
    TIPO_PARAMETRO = value;
  }


  public String getTIPO_PARAMETRO()
  {
    return TIPO_PARAMETRO;
  }


  public void setDESC_PARAMETRO(String value)
  {
    DESC_PARAMETRO = value;
  }


  public String getDESC_PARAMETRO()
  {
    return DESC_PARAMETRO;
  }


  public void setPARAMETRO(String value)
  {
    PARAMETRO = value;
  }


  public String getPARAMETRO()
  {
    return PARAMETRO;
  }

   public boolean equals(Object obj)
  {
    try{
    DB_RegolaTariffa myObj = (DB_RegolaTariffa)obj;
     return this.getCODE_REGOLA().equals(myObj.getCODE_REGOLA()) &&
        this.getPARAMETRO().equals(myObj.getPARAMETRO());
    }
    catch(Exception e){
      return false;
    }
  }

  public void setDESC_ACCOUNT(String value)
  {
    DESC_ACCOUNT = value;
  }


  public String getDESC_ACCOUNT()
  {
    return DESC_ACCOUNT;
  }
}