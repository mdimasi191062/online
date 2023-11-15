package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_BatchNewHome extends EJBHome 
{
  Ent_BatchNew create() throws RemoteException, CreateException;
}