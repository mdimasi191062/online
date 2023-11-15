package com.ejbSTL;
import javax.ejb.EJBObject;
import java.util.Vector;
import java.rmi.RemoteException;
import com.utl.*;

public interface Ctr_TariffeSconti extends EJBObject 
{
  String insert
      (Vector pvct_tariffe
      ,String pstr_codeSconto
      ,String pstr_dataInizioValid)
      throws CustomException, RemoteException;

  String disattiva
      (String pstr_codeTariffa
      ,String pstr_codePrTariffa
      ,String pstr_codeSconto
      ,String pstr_dataInizioValid
      ,String pstr_dataFineValid)
      throws CustomException, RemoteException;
}