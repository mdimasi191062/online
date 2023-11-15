package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface I5_3GEST_SAP_SPHome extends EJBHome 
{
  I5_3GEST_SAP_SP create() throws RemoteException, CreateException;
}