package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.*;
import com.ejbSTL.I5_3GEST_SAP_SP_ROW;
import java.util.Vector;
import com.utl.*;

public interface I5_3GEST_SAP_SP extends EJBObject 
{
  public Vector findAll() throws RemoteException,CustomException;
  public Boolean insertGestoreSap(I5_3GEST_SAP_SP_ROW row) throws RemoteException,CustomException;
  public Boolean modifyGestoreSap(I5_3GEST_SAP_SP_ROW row) throws RemoteException,CustomException;
  public Boolean checkGestoreSap(I5_3GEST_SAP_SP_ROW row) throws RemoteException,CustomException;
  public Vector findOne( String gestSap , String gest , String descGest) throws RemoteException,CustomException;
}
