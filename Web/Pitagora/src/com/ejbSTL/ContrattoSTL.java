package com.ejbSTL;
import javax.ejb.EJBObject;
import java.util.*;
import java.rmi.*;
import com.utl.*;

public interface ContrattoSTL extends EJBObject 
{
  public Vector getContratti(String CodTipoContr) throws RemoteException, CustomException;
//Gianluca-26/09/2002-inizio
  public Vector getContrattiXIns(String CodTipoContr) throws RemoteException, CustomException;
//Gianluca-26/09/2002-fine
  public Vector getContrAssOfPs(String TipoContr, String FlagSys) throws RemoteException, CustomException;
  public Vector getContrTipo(String TipoContr)throws RemoteException, CustomException;
  public int check_fatt_lu(String tipoContr, String codeContr, String flagSys ) throws RemoteException, CustomException;
  public String getDataIni(String codeContr, String flagSys ) throws RemoteException, CustomException;
  
    
    public Vector getContrAssOfPsCluster(String TipoContr, String FlagSys) throws RemoteException, CustomException;
    public Vector getContrattiXInsCluster(String CodTipoContr) throws RemoteException, CustomException;
}