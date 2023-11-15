package com.ejbSTL;

import com.utl.CustomException;

import com.utl.DB_AliquotaIva;

import java.rmi.RemoteException;

import java.util.Vector;

import javax.ejb.EJBObject;

public interface AliquotaIva extends EJBObject
{

  Vector getAllAliquote() throws CustomException, RemoteException ;
  String insAliquotaIva(DB_AliquotaIva aliquotaIva) throws CustomException, RemoteException;
  String aggAliquotaIva(DB_AliquotaIva aliquotaIva) throws CustomException, RemoteException;
  String cancella_aliquotaIva(String code_aliquota) throws CustomException, RemoteException;
  Vector getPreAliquote_codAliquota(String codeAliquota) throws CustomException, RemoteException;
  
  Vector getAllAliquoteClassic() throws CustomException, RemoteException ;
  String insAliquotaIvaClassic(DB_AliquotaIva aliquotaIva) throws CustomException, RemoteException;
  String aggAliquotaIvaClassic(DB_AliquotaIva aliquotaIva) throws CustomException, RemoteException;
  String cancella_aliquotaIvaClassic(String code_aliquota) throws CustomException, RemoteException;
  Vector getPreAliquote_codAliquotaClassic(String codeAliquota) throws CustomException, RemoteException;

  
}
