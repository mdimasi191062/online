package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface I5_2PARAM_VALORIZ_CLHome extends EJBHome 
{
  I5_2PARAM_VALORIZ_CL create() throws RemoteException, CreateException;
}