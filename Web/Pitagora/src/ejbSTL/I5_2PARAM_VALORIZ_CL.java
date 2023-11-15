package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.*;
import com.ejbSTL.I5_2PARAM_VALORIZ_CL_ROW;
import com.utl.*;

public interface I5_2PARAM_VALORIZ_CL extends EJBObject 
{
  public java.util.Vector findAll(java.util.Date DATA_INIZIO_CICLO_FATRZ,java.util.Date DATA_FINE_CICLO_FATRZ) throws RemoteException,CustomException;
  public I5_2PARAM_VALORIZ_CL_ROW loadObjectInsert() throws RemoteException,CustomException;
  public int checkxInserimento() throws RemoteException,CustomException;
  public int checkBatch() throws RemoteException,CustomException;
  public int checkCongelamento(Float Valore, java.util.Date DATA_INIZIO,java.util.Date DATA_FINE) throws RemoteException,CustomException;
  public int checkValoreEuribor(Float Valore, java.util.Date DATA_INIZIO,java.util.Date DATA_FINE) throws RemoteException,CustomException;
  public int updateValoreEuribor(Float Valore, java.util.Date DATA_INIZIO,java.util.Date DATA_FINE) throws RemoteException,CustomException;
  public I5_2PARAM_VALORIZ_CL_ROW CicloDiFatturazione(String CODE_TIPO_CONTR) throws RemoteException,CustomException;  
  public I5_2PARAM_VALORIZ_CL_ROW CicloDiFatturazione_CPM(String CODE_TIPO_CONTR) throws RemoteException,CustomException;    
}