package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_TariffeNewHome extends EJBHome 
{
  Ent_TariffeNew create() throws RemoteException, CreateException;
}