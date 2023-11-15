package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import com.utl.*;
import java.util.Vector;
import com.utl.CustomException;

public interface Ent_ClassiScontoNew extends EJBObject 
{
  public Vector getClassiDiSconto()throws CustomException, RemoteException;
  public String getClassiDiScontoXml()throws CustomException, RemoteException;
  public Vector getAnagrafica()throws CustomException, RemoteException;
}