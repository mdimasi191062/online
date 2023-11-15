package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import com.utl.*;
import java.util.Vector;

public interface Ent_Prodotti extends EJBObject 
{
  public Vector getProdotti()throws CustomException, RemoteException;
  public String getProdottiXml()throws CustomException, RemoteException;
}