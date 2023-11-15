package com.ejbBMP;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.FinderException;
import com.utl.CustomEJBException;

public interface GestAssOfPsBMPHome extends EJBHome 
{
  GestAssOfPsBMP create() throws RemoteException, CreateException;
  GestAssOfPsBMP findByPrimaryKey(GestAssOfPsBMPPK primaryKey) throws RemoteException, FinderException, CustomEJBException;
}