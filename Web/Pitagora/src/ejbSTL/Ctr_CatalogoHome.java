package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ctr_CatalogoHome extends EJBHome 
{
  Ctr_Catalogo create() throws RemoteException, CreateException;
}