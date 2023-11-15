package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface I5_6PROF_UTENTEejbHome extends EJBHome 
{
  I5_6PROF_UTENTEejb create() throws RemoteException, CreateException;
}