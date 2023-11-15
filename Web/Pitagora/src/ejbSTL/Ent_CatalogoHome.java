package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_CatalogoHome extends EJBHome 
{
  Ent_Catalogo create() throws RemoteException, CreateException;
}