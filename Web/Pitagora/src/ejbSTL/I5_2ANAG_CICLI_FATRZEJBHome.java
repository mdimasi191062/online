package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface I5_2ANAG_CICLI_FATRZEJBHome extends EJBHome 
{
  I5_2ANAG_CICLI_FATRZEJB create() throws RemoteException, CreateException;
}