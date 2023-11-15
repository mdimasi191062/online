package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface I5_2TEST_AVANZ_COSTI_RICAVIHome extends EJBHome 
{
  I5_2TEST_AVANZ_COSTI_RICAVI create() throws RemoteException, CreateException;
  
}