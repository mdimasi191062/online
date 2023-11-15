package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_InventariHome extends EJBHome 
{
  Ent_Inventari create() throws RemoteException, CreateException;
}

