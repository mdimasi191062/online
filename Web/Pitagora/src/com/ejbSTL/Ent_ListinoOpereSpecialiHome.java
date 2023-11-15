package com.ejbSTL;

import java.rmi.RemoteException;

import javax.ejb.CreateException;
import javax.ejb.EJBHome;

public interface Ent_ListinoOpereSpecialiHome extends EJBHome
{
  Ent_ListinoOpereSpeciali create() throws RemoteException, CreateException;
}
