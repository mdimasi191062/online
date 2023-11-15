package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_TipoCausaleNewHome extends EJBHome 
{
  Ent_TipoCausaleNew create() throws RemoteException, CreateException;
}