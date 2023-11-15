package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface GestioneScartiPopolamentoHome extends EJBHome 
{
  GestioneScartiPopolamento create() throws RemoteException, CreateException;
}