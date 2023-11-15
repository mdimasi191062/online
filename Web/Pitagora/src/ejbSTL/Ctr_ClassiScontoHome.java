package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ctr_ClassiScontoHome extends EJBHome 
{
    Ctr_ClassiSconto create() throws RemoteException, CreateException;
}