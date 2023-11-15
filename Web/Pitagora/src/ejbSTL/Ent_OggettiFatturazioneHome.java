package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_OggettiFatturazioneHome extends EJBHome 
{
  Ent_OggettiFatturazione create() throws RemoteException, CreateException;
}