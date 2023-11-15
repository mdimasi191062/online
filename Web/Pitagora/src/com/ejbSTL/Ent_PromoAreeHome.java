package com.ejbSTL;


import java.rmi.RemoteException;

import javax.ejb.CreateException;
import javax.ejb.EJBHome;

public interface Ent_PromoAreeHome extends EJBHome{

    Ent_PromoAree create() throws RemoteException, CreateException;

}
