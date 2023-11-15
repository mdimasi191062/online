package com.utl;

import java.io.Serializable;

public class DB_ListinoOpereSpeciali implements Serializable
{
  private String descListinoApplicato;
  
  public DB_ListinoOpereSpeciali()
  {
  }

  public void setDescListinoApplicato(String descListinoApplicato)
  {
    this.descListinoApplicato = descListinoApplicato;
  }

  public String getDescListinoApplicato()
  {
    return descListinoApplicato;
  }


  public String toString()
  {
    return "[descListinoApplicato: "+ descListinoApplicato +"]";
  }
}
