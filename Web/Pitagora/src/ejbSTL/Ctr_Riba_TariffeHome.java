package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ctr_Riba_TariffeHome extends EJBHome 
{
  Ctr_Riba_Tariffe create() throws RemoteException, CreateException;
}