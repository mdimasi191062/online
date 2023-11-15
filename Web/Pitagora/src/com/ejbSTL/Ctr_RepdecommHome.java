package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ctr_RepdecommHome extends EJBHome 
{
  Ctr_Repdecomm create() throws RemoteException, CreateException;
}
