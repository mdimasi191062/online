package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.*;
import com.ejbSTL.I5_2PROMOZIONI_ROW;
import java.util.Vector;
import com.utl.*;

public interface I5_2PROMOZIONI extends EJBObject 
{
  public Vector findAll() throws RemoteException,CustomException;
  public Vector findTipiAll() throws RemoteException,CustomException;
  public Vector findStoredAll() throws RemoteException,CustomException;
  public Boolean insertPromizioni(I5_2PROMOZIONI_ROW row) throws RemoteException,CustomException;
  public Boolean insertPromizioniOF(int codePromo, int classeOF, int servizio) throws RemoteException,CustomException;  
  public Boolean checkPromizioni(I5_2PROMOZIONI_ROW row) throws RemoteException,CustomException;
  public int eliminaPromo(String Promo) throws RemoteException,CustomException;
  public int modificaPromo(String Promo, String servizio , String oggFatt) throws RemoteException,CustomException;
  public Vector getServizi() throws RemoteException,CustomException;
  public Vector getServiziXPromo(String Promo) throws RemoteException,CustomException;  
}