package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ctr_NoteCreditoHome extends EJBHome 
{
    Ctr_NoteCredito create() throws RemoteException, CreateException;
}