package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_ModalitaApplicazioneHome extends EJBHome 
{
  Ent_ModalitaApplicazione create() throws RemoteException, CreateException;
}