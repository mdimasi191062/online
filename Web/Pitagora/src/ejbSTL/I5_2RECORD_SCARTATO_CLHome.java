package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface I5_2RECORD_SCARTATO_CLHome extends EJBHome 
{
  I5_2RECORD_SCARTATO_CL create() throws RemoteException, CreateException;
}