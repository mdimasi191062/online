package com.ejbBMP;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.FinderException;
import java.util.Collection;

public interface AbortLstBMPHome extends EJBHome 
{
  AbortLstBMP create() throws RemoteException, CreateException;
  AbortLstBMP findByPrimaryKey(AbortLstBMPPK primaryKey) throws RemoteException, FinderException;
  Collection findAll(String CodContratto) throws FinderException, RemoteException;
  }