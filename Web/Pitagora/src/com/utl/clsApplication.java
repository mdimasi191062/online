package com.utl;

import java.util.*;

public class clsApplication 
{

  String AdminIndicator =null;
  Date DataLancioAllineamntoDB =null;
  
  public clsApplication()
  {
  }

  public String getAdminIndicator()
  {
    return AdminIndicator;
  }

  public void setAdminIndicator(String newAdminIndicator)
  {
    AdminIndicator = newAdminIndicator;
  }

  public void setDataLancioAllineamntoDB(Date newDataLancioAllineamntoDB)
  {
    DataLancioAllineamntoDB = newDataLancioAllineamntoDB;
  }

  public Date getDataLancioAllineamntoDB()
  {
    return DataLancioAllineamntoDB;
  }


  
}