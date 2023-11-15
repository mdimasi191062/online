package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_PrestazioniAggiuntiveHome extends EJBHome 
{
  Ent_PrestazioniAggiuntive create() throws RemoteException, CreateException;
}