package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_TariffeHome extends EJBHome 
{
  Ent_Tariffe create() throws RemoteException, CreateException;
}