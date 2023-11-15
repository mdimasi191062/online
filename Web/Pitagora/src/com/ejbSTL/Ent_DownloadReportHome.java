package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_DownloadReportHome extends EJBHome 
{
  Ent_DownloadReport create() throws RemoteException, CreateException;
}