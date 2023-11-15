package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ctr_UtilityHome extends EJBHome 
{
  Ctr_Utility create() throws RemoteException, CreateException;
}
