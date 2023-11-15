package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ent_ModalitaApplicazione extends EJBObject 
{
  public String getModalitaApplicazioneXml()throws CustomException, RemoteException;
  public Vector getModalitaApplicazione()throws CustomException, RemoteException;

}