package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_DownloadParamHome extends EJBHome 
{
  Ent_DownloadParam create() throws RemoteException, CreateException;
}