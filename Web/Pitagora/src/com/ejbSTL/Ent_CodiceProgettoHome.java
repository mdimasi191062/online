package com.ejbSTL;


import java.rmi.RemoteException;

import javax.ejb.CreateException;
import javax.ejb.EJBHome;

public interface Ent_CodiceProgettoHome extends EJBHome{

    Ent_CodiceProgetto create() throws RemoteException, CreateException;

}
