package com.utl;
import com.utl.AbstractDataBean;

public class DB_TariffeRegole extends DB_TariffeNew
{
  /*
  tag attribute: CODE_TARIFFA
  */
  private String CODE_REGOLA = "";
  /*
  tag attribute: CODE_PR_TARIFFA
  */
  private String CODE_PARAMETRO = "";

  public void setCODE_REGOLA(String value)
  {
    CODE_REGOLA = value;
  }


  public String getCODE_REGOLA()
  {
    return CODE_REGOLA;
  }

  public void setCODE_PARAMETRO(String value)
  {
    CODE_REGOLA = value;
  }


  public String getCODE_PARAMETRO()
  {
    return CODE_REGOLA;
  }
}
