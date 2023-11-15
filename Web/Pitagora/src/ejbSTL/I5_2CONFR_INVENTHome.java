package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface I5_2CONFR_INVENTHome extends EJBHome 
{
  I5_2CONFR_INVENT create() throws RemoteException, CreateException;
}

