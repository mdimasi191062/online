package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface I5_2SCONTO_CLHome extends EJBHome 
{
  I5_2SCONTO_CL create() throws RemoteException, CreateException;
}