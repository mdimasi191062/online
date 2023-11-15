package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ent_OggettoFatturazioneNew extends EJBObject 
{
  public String getOggettiFatturazioneXml(int CodeServizio)throws CustomException, RemoteException;
  public Vector getOggettiFatturazione(int CodeServizio)throws CustomException, RemoteException;
}