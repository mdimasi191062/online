package com.ejbSTL;
import javax.ejb.EJBObject;
import java.util.*;
import java.rmi.*;
import com.utl.*;

public interface ClasseFattSTL extends EJBObject 
{
  public Vector getCfs() throws RemoteException, CustomException;
  public Vector getCfsTipoContr( String strTipoContr ) throws RemoteException, CustomException;
  public Vector getCfsCla() throws RemoteException, CustomException;
  
  //PASQUALE
  public Vector getClusterTipoContr( String strTipoContr ) throws RemoteException, CustomException;
}