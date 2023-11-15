package com.ejbBMP;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.FinderException;
import com.utl.CustomEJBException;

public interface GestAssOfPsBMPClusHome extends EJBHome 
{
  GestAssOfPsBMPClus create() throws RemoteException, CreateException;
  GestAssOfPsBMPClus findByPrimaryKey(GestAssOfPsBMPClusPK primaryKey) throws RemoteException, FinderException, CustomEJBException;
}