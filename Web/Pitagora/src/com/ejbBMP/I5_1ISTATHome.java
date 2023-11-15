package com.ejbBMP;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.FinderException;
import java.util.Collection;

public interface I5_1ISTATHome extends EJBHome 
{
 // public I5_1ISTAT create(String desc_sconto, Float perc_sconto, Float decremento) throws RemoteException, CreateException;

  public Collection findAll() throws FinderException, RemoteException;

  public I5_1ISTAT findByPrimaryKey(String primaryKey) throws RemoteException, FinderException;
}