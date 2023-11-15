package com.utl;
import java.io.Serializable;

public class ClassDatiTop implements Serializable
{
  String db_instance;
  String server;
  
  public ClassDatiTop()
  {
    this.db_instance = null;
    this.server = null;
  }


  public String getDB_instance()
  {
    return db_instance;
  }

  public void setDB_instance(String newDB_instance)
  {
    db_instance = newDB_instance;
  }

  public String getServer()
  {
    return server;
  }

  public void setServer(String newServer)
  {
    server = newServer;
  }
}