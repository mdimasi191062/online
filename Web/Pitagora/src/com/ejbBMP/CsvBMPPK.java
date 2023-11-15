package com.ejbBMP;

import com.utl.*;

public class CsvBMPPK extends AbstractPK  
{
  private String account;
  private int csv;
  private int ps; 
  public CsvBMPPK()
  {
  }

 public CsvBMPPK(int nrgCsv, int nrgPs, String acc)
  {
   this.csv=nrgCsv;
   this.ps=nrgPs;
   this.account=acc;
  }

  public String getAccount()
  {
    return account;
  }
  public void setAccount(String acc)
  {
      account=acc;
  }
  public int getCsv()
  {
    return csv;
  }
  public void setCsv(int nrgCsv)
  {
      csv=nrgCsv;
  }
  public int getPs()
  {
    return ps;
  }
  public void setPs(int nrgPs)
  {
      ps=nrgPs;
  }
}
