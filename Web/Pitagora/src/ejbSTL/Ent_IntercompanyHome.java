package com.ejbSTL;


import java.rmi.RemoteException;

import javax.ejb.CreateException;
import javax.ejb.EJBHome;

public interface Ent_IntercompanyHome extends EJBHome{

    Ent_Intercompany create() throws RemoteException, CreateException;

}
