package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_ProdottiHome extends EJBHome 
{
  Ent_Prodotti create() throws RemoteException, CreateException;
}