package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.*;
import java.util.*;
import com.utl.*;

public interface I5_2SCONTO_CL extends EJBObject 
{
  public void insertSconto(String desc_sconto, Integer perc_sconto, java.math.BigDecimal decremento,String code_utente) throws RemoteException,CustomException;
  public Vector findAll(String strDescSconto) throws RemoteException,CustomException;
  public I5_2SCONTO_CL_ROW loadSconto(String CodeSconto) throws RemoteException,CustomException;
  public void removeSconto(String CodeSconto) throws RemoteException,CustomException;
  public void saveSconto(String codesconto,String descsconto,Integer percsconto,java.math.BigDecimal decremento) throws RemoteException,CustomException;
  public int CheckCodeSconto(String CodeSconto) throws RemoteException,CustomException;
}