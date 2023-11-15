package com.ejbSTL;

import java.rmi.RemoteException;

import javax.ejb.CreateException;
import javax.ejb.EJBHome;

public interface AliquotaIvaHome extends EJBHome
{
  AliquotaIva create() throws RemoteException, CreateException;
}
