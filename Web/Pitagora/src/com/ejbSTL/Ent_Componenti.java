package com.ejbSTL;
import javax.ejb.EJBObject;
import java.util.Vector;
import java.rmi.RemoteException;
import com.utl.*;


public interface Ent_Componenti extends EJBObject 
{
  public Vector getComponenti(int Prodotto)throws CustomException, RemoteException;
}