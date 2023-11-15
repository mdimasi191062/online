package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.*;
import javax.ejb.*;
import javax.ejb.CreateException;

public interface SchedBatchSTLHome extends EJBHome 
{
  SchedBatchSTL create() throws RemoteException, CreateException;
}