package com.ejbSTL;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;

public interface Ent_AssocOggettiFatturazioneHome extends EJBHome 
{
  Ent_AssocOggettiFatturazione create() throws RemoteException, CreateException;
}