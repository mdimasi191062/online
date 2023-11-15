package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_SpesaComplessivaHome extends EJBHome 
{
    Ent_SpesaComplessiva create() throws RemoteException, CreateException;
}