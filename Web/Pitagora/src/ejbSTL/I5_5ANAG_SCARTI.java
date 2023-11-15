package com.ejbSTL;

import java.sql.*;
import java.io.Serializable;

public class I5_5ANAG_SCARTI implements Serializable
{

  protected String DESC_SCARTO;
  protected String CODE_DETT_SCARTO;

  public String getDESC_SCARTO()
   {
     return DESC_SCARTO;
   }

  public void setDESC_SCARTO(String pValue)
   {
     DESC_SCARTO = pValue;
   }

  public String getCODE_DETT_SCARTO()
   {
     return CODE_DETT_SCARTO;
   }

  public void setCODE_DETT_SCARTO(String pValue)
   {
     CODE_DETT_SCARTO = pValue;
   }

}