package com.utl;
import java.io.Serializable;

public class ClassClient_ip implements Serializable
{
  String client_ip;
  
  public ClassClient_ip()
  {
    this.client_ip = null;
  }


  public String getClient_ip()
  {
    return client_ip;
  }

  public void setClient_ip(String newClient_ip)
  {
    client_ip = newClient_ip;
  }
}