package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface CtrRepricingSTLHome extends EJBHome 
{
  CtrRepricingSTL create() throws RemoteException, CreateException;
}