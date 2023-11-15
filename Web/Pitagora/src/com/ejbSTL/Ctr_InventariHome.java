package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ctr_InventariHome extends EJBHome 
{
  Ctr_Inventari create() throws RemoteException, CreateException;
}