package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ctr_SpesaComplessivaHome extends EJBHome 
{
  Ctr_SpesaComplessiva create() throws RemoteException, CreateException;
}