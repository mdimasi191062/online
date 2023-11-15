package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ctr_RepricingHome extends EJBHome 
{
    Ctr_Repricing create() throws RemoteException, CreateException;
}