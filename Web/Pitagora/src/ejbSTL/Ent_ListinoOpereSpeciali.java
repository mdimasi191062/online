package com.ejbSTL;

import com.utl.CustomException;

import com.utl.StoredProcedureResult;
import com.utl.TariffaOpereSpeciali;

import com.utl.TariffaOpereSpecialiPar;

import java.rmi.RemoteException;

import java.util.List;
import java.util.Vector;

import javax.ejb.EJBObject;

public interface Ent_ListinoOpereSpeciali extends EJBObject
{
  public Vector getListinoOpereSpeciali(String pstr_CodeTipoContr) throws CustomException, RemoteException;
  public Vector<TariffaOpereSpeciali> getTariffeByListino(String listino, String pstr_CodeTipoContr, String vuota) throws CustomException, RemoteException;
  public boolean checkListinoExsists(String listino, String pstr_CodeTipoContr) throws CustomException, RemoteException;
  public void updateListino(String oldListinoDescr, String newListinoDescr, Vector<String> tariffaDescr) throws CustomException, RemoteException;
  public void checkAndUpdateListino(String oldListinoDescr, String pstr_CodeTipoContr, String newListinoDescr, Vector<String> tariffaDescr) throws CustomException, RemoteException;
 // public Vector<StoredProcedureResult> insertTariffa(String codeUtente, int idVoce, String dataInizioTariffa, String descTariffa, String imptTariffa, String codeUnitaMisura, String descListinoApplicato) throws CustomException, RemoteException;
  public Vector<StoredProcedureResult> insertTariffa(String codeUtente,  String dataInizioTariffa, String descListinoApplicato, List<TariffaOpereSpecialiPar> tarOSP) throws CustomException, RemoteException;
  public Vector<StoredProcedureResult> eliminaListino(String nomeListino) throws CustomException, RemoteException;
  
}
