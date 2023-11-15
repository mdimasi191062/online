package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ctr_TariffeNewHome extends EJBHome 
{
  Ctr_TariffeNew create() throws RemoteException, CreateException;
}