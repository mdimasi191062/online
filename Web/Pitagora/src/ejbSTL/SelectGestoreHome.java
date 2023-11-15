package com.ejbSTL;

import java.rmi.RemoteException;

import javax.ejb.CreateException;
import javax.ejb.EJBHome;

public interface SelectGestoreHome extends EJBHome
{
  SelectGestore create() throws RemoteException, CreateException;
}
