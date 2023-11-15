package com.ejbSTL;

import javax.ejb.EJBObject;
import java.rmi.*;
import java.util.*;
import com.ejbSTL.I5_1CONTR;
import com.utl.*;



public interface GestioneScartiPopolamento extends EJBObject 
{
  public Vector getListaOloConScarti(String pCodeTipoContr) throws RemoteException,CustomException;
  public Vector getListaScartiXOlo(String pCodeTipoContr, String pCodeContr) throws RemoteException,CustomException;
  
  
  ///PASSSS
    public Vector getServizi() throws RemoteException,CustomException;
    public Vector getCausaleScarto() throws RemoteException,CustomException;
    //public Vector getTipologiaScarto() throws RemoteException,CustomException;
    public Vector getOlo() throws RemoteException,CustomException;
    public Vector getScarti(String COD_SERVIZIO, String COD_CAUSALE_SCARTO, String COD_OLO, String DATA_DA, String DATA_A) throws RemoteException,CustomException;
    public boolean riproponiScarti(String COD_SERVIZIO, String COD_CAUSALE_SCARTO, String COD_OLO, String DATA_DA, String DATA_A, String RICICLO_FATTURAZIONE_CORRENTE) throws RemoteException,CustomException;
  ///PASSSS
}
