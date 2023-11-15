package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ctr_ValAttivaHome extends EJBHome 
{
    Ctr_ValAttiva create() throws RemoteException, CreateException;
}