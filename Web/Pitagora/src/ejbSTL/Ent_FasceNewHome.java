package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_FasceNewHome extends EJBHome 
{
  Ent_FasceNew create() throws RemoteException, CreateException;
}