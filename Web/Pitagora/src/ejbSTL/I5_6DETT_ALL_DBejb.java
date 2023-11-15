package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.*;
import com.utl.I5_6TEST_ALL_DB_ROW;
import com.utl.I5_6DETT_ALL_DB_ROW;
import java.util.Vector;
import com.utl.CustomException;


public interface I5_6DETT_ALL_DBejb extends EJBObject 
{
  public Vector findAllTestata() throws RemoteException,CustomException;
  public I5_6TEST_ALL_DB_ROW loadTesto(java.util.Date DataLancio) throws RemoteException,CustomException; 
  public I5_6TEST_ALL_DB_ROW loadLastRunning() throws RemoteException,CustomException; 
  public Vector findAllDettaglio(String CODE_TEST_ALL) throws RemoteException,CustomException;
}