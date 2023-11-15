package com.ejbSTL;
import javax.ejb.EJBObject;
import java.util.*;
import java.rmi.*;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface ProdServSTL extends EJBObject
{
 public Vector getPsTar(String CodTipoContr)  throws RemoteException, CustomException;
 public Vector getPs(String CodTipoContr)     throws RemoteException, CustomException;
//Aggiornamento Mario 13/09/02 inizio
//Nico 13/09/02 inizio
  public Vector getPsAssOfPs(String CodTipoContr)  throws RemoteException, CustomException;
//Nico 13/09/02 fine
// Caricamento lista dei PS da Lista Tariffe per Contratto
 public Vector getPsXContr(String CodContr) throws RemoteException, CustomException;
//Caricamento della lista di NuovaCol.jsp
 public Vector getPsUm(String CodTipoCol)  throws RemoteException, CustomException;
//Aggiornamento Mario 13/09/02 fine
//Dario-inizio
 public Vector getPsUmQta(String CodTipoCol,String CodeSito,String CodeAccount) throws RemoteException, CustomException;
//GIANLUCA-26/09/2002 Caricamento lista dei PS da Inserimento Tariffe per Contratto
 public Vector getPsXContrIns(String TipoContr,String CodContr) throws RemoteException, CustomException;

//Tommaso inizio 09/10/2002 
 public ProdServElem getDataIni(String CodPs) throws RemoteException, CustomException;
//Tommaso fine 09/10/2002

//Martino 28/08/2006
  public Vector getPsAssOfPs(String CodTipoContr,String strPsRicerca)  throws RemoteException, CustomException;
  public Vector getPsTar(String CodTipoContr,String strRicerca) throws RemoteException, CustomException;
  public Vector getPsXContrIns(String TipoContr,String CodContr,String strRicerca) throws RemoteException, CustomException;
//Martino 09/10/2006
 public Vector getPsXContr(String CodContr,String strRicerca) throws RemoteException, CustomException;
 public Vector getPs(String CodTipoContr, String strPsRicerca) throws RemoteException, CustomException;
 
    public Vector getPsXContrClusIns(String TipoContr,String CodContr, String codeCluster, String tipoCluster) throws RemoteException, CustomException;
}
