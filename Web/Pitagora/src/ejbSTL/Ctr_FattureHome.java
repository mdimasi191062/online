package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ctr_FattureHome extends EJBHome 
{
  Ctr_Fatture create() throws RemoteException, CreateException;
}