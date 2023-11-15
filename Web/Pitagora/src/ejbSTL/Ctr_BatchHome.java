package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ctr_BatchHome extends EJBHome 
{
  Ctr_Batch create() throws RemoteException, CreateException;
}