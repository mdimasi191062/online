package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_PrestazioniAggiuntiveNewHome extends EJBHome 
{
  Ent_PrestazioniAggiuntiveNew create() throws RemoteException, CreateException;
}