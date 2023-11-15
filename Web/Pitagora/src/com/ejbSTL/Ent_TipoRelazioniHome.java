package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_TipoRelazioniHome extends EJBHome 
{
  Ent_TipoRelazioni create() throws RemoteException, CreateException;
}