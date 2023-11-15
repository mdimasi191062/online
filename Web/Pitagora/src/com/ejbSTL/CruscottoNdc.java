package com.ejbSTL;

import com.utl.CustomException;

import java.rmi.RemoteException;

import java.util.Collection;

import java.util.Vector;

import javax.ejb.EJBObject;
import javax.ejb.FinderException;

public interface CruscottoNdc extends EJBObject
{

  public Vector findAll( String FiltroDATA_INIZIO_CICLO_FATRZ, String FiltroDATA_FINE_CICLO_FATRZ, String FiltroTIPO_FLAG_FUNZIONE_CREAZ_IMPT, String FiltroRIFERITO_FATTURA, String FiltroCODE_GEST, String FiltroCODE_ACCOUNT ) throws FinderException, RemoteException,CustomException;
  public Vector findAll_cla( String FiltroDATA_INIZIO_CICLO_FATRZ, String FiltroDATA_FINE_CICLO_FATRZ, String FiltroTIPO_FLAG_FUNZIONE_CREAZ_IMPT, String FiltroRIFERITO_FATTURA, String FiltroCODE_GEST, String FiltroCODE_ACCOUNT ) throws FinderException, RemoteException,CustomException;
  
}
