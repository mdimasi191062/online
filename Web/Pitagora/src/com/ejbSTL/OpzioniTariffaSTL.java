package com.ejbSTL;
import javax.ejb.EJBObject;

import java.util.*;
import java.rmi.*;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;
public interface OpzioniTariffaSTL extends EJBObject 
{
 public OpzioniElem getOpzioniFlag(String codOf,String codPs) throws CustomException, RemoteException;
 public Vector getOpz() throws CustomException, RemoteException;
 public Vector getOpzTarXTipoContr(String codOf,String codPs) throws CustomException, RemoteException; //04-03-03
 public Vector getOpzTarXCliente(String codContr ,String codOf,String codPs) throws CustomException, RemoteException;  //05-03-03

 //viti 07-03-03
 public Vector getDispOpzXContr(String codeContr, String codOf,String codPs)throws CustomException, RemoteException;
 public Vector getDispOpz(String codOf,String codPs)throws CustomException, RemoteException;
}