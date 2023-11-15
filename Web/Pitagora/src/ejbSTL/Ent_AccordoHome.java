package com.ejbSTL;

import javax.ejb.EJBHome;

import java.rmi.RemoteException;

import javax.ejb.CreateException;

public interface Ent_AccordoHome extends EJBHome
{
  Ent_Accordo create() throws RemoteException, CreateException;
}
