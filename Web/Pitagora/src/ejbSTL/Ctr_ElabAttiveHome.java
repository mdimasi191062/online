package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ctr_ElabAttiveHome extends EJBHome 
{
  Ctr_ElabAttive create() throws RemoteException, CreateException;
}