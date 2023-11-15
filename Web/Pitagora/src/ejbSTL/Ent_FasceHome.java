package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_FasceHome extends EJBHome 
{
  Ent_Fasce create() throws RemoteException, CreateException;
}