package com.ejbBMP;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.FinderException;
import java.util.Collection;

public interface CicloFatBMPHome extends EJBHome 
{
  CicloFatBMP create() throws RemoteException, CreateException;
  CicloFatBMP findByPrimaryKey(CicloFatBMPPK primaryKey) throws RemoteException, FinderException;
  Collection  findCicloFat() throws FinderException, RemoteException;
}
