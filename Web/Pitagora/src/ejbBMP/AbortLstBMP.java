package com.ejbBMP;
import javax.ejb.EJBObject;


import java.rmi.RemoteException;

public interface AbortLstBMP extends EJBObject 
{
  public String getAccount()  throws RemoteException;

  public void setAccount(String account)  throws RemoteException;

  }
