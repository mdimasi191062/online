package com.ejbBMP;
import javax.ejb.EJBObject;


import java.rmi.RemoteException;

public interface CsvBMP extends EJBObject 
{
  public int getCsv()  throws RemoteException;
  public void setCsv(int nrgCsv)  throws RemoteException;
  public int getPs()  throws RemoteException;
  public void setPs(int nrgPs)  throws RemoteException;
  public String getAccount()  throws RemoteException;
  public void setAccount(String account)  throws RemoteException;

}