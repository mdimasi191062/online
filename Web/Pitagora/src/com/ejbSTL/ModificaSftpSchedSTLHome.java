package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface ModificaSftpSchedSTLHome extends EJBHome 
{
  ModificaSftpSchedSTL create() throws RemoteException, CreateException;
}