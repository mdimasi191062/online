package com.ejbSTL;
import javax.ejb.EJBObject;
import java.util.Vector;
import java.rmi.RemoteException;
import com.utl.*;

public interface Ent_FasceNew extends EJBObject 
{
  public Vector getAnagrafica()throws CustomException, RemoteException;
  public Vector getFasce()throws CustomException, RemoteException;
  public String getFasceXml()throws CustomException, RemoteException;
  public Vector getUnitaDiMisura()throws CustomException, RemoteException;
}