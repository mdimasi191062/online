package com.ejbSTL;

import com.utl.CustomException;

import com.utl.DB_ScodamentoEventi;

import java.rmi.RemoteException;

import java.util.Vector;

import javax.ejb.EJBObject;

public interface ScodamentoEventi extends EJBObject
{

  Vector getScodamentoEventi() throws CustomException, RemoteException ;
//  String insScodamentoEventi(DB_ScodamentoEventi ScodamentoEventi) throws CustomException, RemoteException;
  String aggScodamentoEventi(DB_ScodamentoEventi ScodamentoEventi) throws CustomException, RemoteException;
//  String cancella_ScodamentoEventi(String cod_lotto) throws CustomException, RemoteException;
//  Vector getPreScodamentoEventi_codLotto(String cod_lotto) throws CustomException, RemoteException;
}

