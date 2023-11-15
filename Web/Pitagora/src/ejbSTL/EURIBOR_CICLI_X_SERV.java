package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.*;
import com.ejbSTL.EURIBOR_CICLI_X_SERV_ROW;
import com.utl.*;

public interface EURIBOR_CICLI_X_SERV extends EJBObject 
{
  public java.util.Vector findAll(java.util.Date DATA_INIZIO_CICLO,java.util.Date DATA_FINE_CICLO) throws RemoteException,CustomException;
  public EURIBOR_CICLI_X_SERV_ROW loadObjectInsert() throws RemoteException,CustomException;
  public int checkxInserimento() throws RemoteException,CustomException;
  public int checkBatch() throws RemoteException,CustomException;
  public int checkCongelamento(Float Valore, java.util.Date DATA_INIZIO,java.util.Date DATA_FINE) throws RemoteException,CustomException;
  public int checkValoreEuribor(Float Valore, java.util.Date DATA_INIZIO,java.util.Date DATA_FINE) throws RemoteException,CustomException;
  public int updateValoreEuribor(Float Valore, java.util.Date DATA_INIZIO,java.util.Date DATA_FINE) throws RemoteException,CustomException;
  public EURIBOR_CICLI_X_SERV_ROW CicloDiFatturazione(String CODE_TIPO_CONTR) throws RemoteException,CustomException;  
  public EURIBOR_CICLI_X_SERV_ROW CicloDiFatturazione_CPM(String CODE_TIPO_CONTR) throws RemoteException,CustomException;    
}