package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_RegoleTariffeHome extends EJBHome 
{
  Ent_RegoleTariffe create() throws RemoteException, CreateException;
}