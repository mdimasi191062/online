package com.ejbSTL;

import java.rmi.RemoteException;

import javax.ejb.CreateException;
import javax.ejb.EJBHome;

public interface Ent_CinqueAnniHome extends EJBHome{
    Ent_CinqueAnni create() throws RemoteException, CreateException;
}
