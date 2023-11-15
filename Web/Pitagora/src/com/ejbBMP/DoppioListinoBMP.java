package com.ejbBMP;
import javax.ejb.EJBObject;


import java.rmi.RemoteException;

public interface DoppioListinoBMP extends EJBObject 
{
  public int getLst()  throws RemoteException;
  public void setLst(int nrgLst)  throws RemoteException;
  public String getAccount()  throws RemoteException;
  public void setAccount(String account)  throws RemoteException;
  public String getCodeParam()  throws RemoteException;
  public void setCodeParam(String code)  throws RemoteException;


}