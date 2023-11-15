package com.utl;

public class MessaggioBean 
{
  private String _messaggio;
  public MessaggioBean(String messaggio)
  {
    _messaggio=messaggio;
  }

  public String getMessaggio()
  {
      return _messaggio;
  }
}