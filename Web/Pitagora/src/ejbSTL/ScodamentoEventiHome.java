package com.ejbSTL;

import java.rmi.RemoteException;

import javax.ejb.CreateException;
import javax.ejb.EJBHome;

public interface ScodamentoEventiHome extends EJBHome
{
  ScodamentoEventi create() throws RemoteException, CreateException;
}
