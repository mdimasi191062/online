package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface I5_6treeHome extends EJBHome 
{
	I5_6tree create() throws RemoteException, CreateException;
}