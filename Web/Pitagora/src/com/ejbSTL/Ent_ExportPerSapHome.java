package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_ExportPerSapHome extends EJBHome 
{
  Ent_ExportPerSap create() throws RemoteException, CreateException;
}