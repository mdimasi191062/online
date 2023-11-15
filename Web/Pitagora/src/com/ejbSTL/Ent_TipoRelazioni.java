package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;


public interface Ent_TipoRelazioni extends EJBObject 
{
  Vector getRelazioni()throws CustomException, RemoteException ;
  String getRelazioniXml()throws CustomException, RemoteException;
  Vector getAccountXGruppiAccount( int intCodeRelazione, int intCodeAccount  ) throws CustomException, RemoteException ;
  Vector getGruppiAccount( int intCodeRelazione ,String strDescGruppo ) throws CustomException, RemoteException;
  Vector getGruppiAccount( int intCodeRelazione  ) throws CustomException, RemoteException;
  Vector getAccount ( String strDescAccount, String strCodeAccount) throws CustomException, RemoteException;
  Vector getAccount ( )   throws CustomException, RemoteException;
  int inserisciAccountInGruppo( String strCodeAccount, String strCodeGruppo, int intCodeRelazione, String strDataInizio, String strDataFine, String strAccountPadre )   throws CustomException, RemoteException;
  int eliminaAccountDalGruppo( String strCodeAccount, String strCodeGruppo, int intCodeRelazione ) throws CustomException, RemoteException;
}