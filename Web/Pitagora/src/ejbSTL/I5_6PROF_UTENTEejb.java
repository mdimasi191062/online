package com.ejbSTL;
import javax.ejb.EJBObject;
import java.util.*;
import java.rmi.RemoteException;
import com.utl.*;
import com.ejbSTL.I5_6PROF_UTENTE_ROW;

public interface I5_6PROF_UTENTEejb extends EJBObject 
{
  public Vector FindAll(String codice) throws RemoteException,CustomException;
  public String creaProfilo(String codice,String descrizione) throws RemoteException,CustomException;
  public I5_6PROF_UTENTE_ROW loadProfilo(String codice) throws RemoteException,CustomException;  
  public String updateProfilo(String codice,String descrizione) throws RemoteException,CustomException;
  public String deleteProfilo(String codice) throws RemoteException,CustomException;
}