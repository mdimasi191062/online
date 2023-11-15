package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_StatisticheHome extends EJBHome  {
    Ent_Statistiche create() throws RemoteException, CreateException;
}