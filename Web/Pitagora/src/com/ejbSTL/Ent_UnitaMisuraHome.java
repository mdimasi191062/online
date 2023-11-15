package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_UnitaMisuraHome extends EJBHome 
{
  Ent_UnitaMisura create() throws RemoteException, CreateException;
}