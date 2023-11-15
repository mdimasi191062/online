package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_OggettoFatturazioneNewHome extends EJBHome 
{
  Ent_OggettoFatturazioneNew create() throws RemoteException, CreateException;
}