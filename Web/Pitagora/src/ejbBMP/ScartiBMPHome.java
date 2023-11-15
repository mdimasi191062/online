package com.ejbBMP;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.FinderException;
import java.util.Collection;

public interface ScartiBMPHome extends EJBHome 
{
    ScartiBMP create() throws RemoteException, CreateException;
    ScartiBMP findByPrimaryKey(ScartiBMPPK primaryKey) throws RemoteException, FinderException;
    Collection findScartiLst(String Account,String CodeFunz,String CodeContratto) throws RemoteException, FinderException;
}