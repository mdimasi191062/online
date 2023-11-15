package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_Batch_PREHome extends EJBHome 
{
  Ent_Batch_PRE create() throws RemoteException, CreateException;
}