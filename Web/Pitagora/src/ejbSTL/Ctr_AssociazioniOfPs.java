package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import com.utl.*;

public interface Ctr_AssociazioniOfPs extends EJBObject 
{
  // chkDisattivaAssociazione
  String chkDisattivaAssociazione (DB_OggettoFatturazione pDB_OggettoFatturazione)
                                   throws CustomException, RemoteException;

  // DisattivaAssociazione
  String DisattivaAssociazione (DB_OggettoFatturazione pDB_OggettoFatturazione)
                                   throws CustomException, RemoteException;

  // InsAssociazioneOfPs
  String InsAssociazioneOfPs (DB_OggettoFatturazione pDB_OggettoFatturazione)
                                throws CustomException, RemoteException;
  //InsAssociazioneOfPsXTipoContr
  String InsAssociazioneOfPsXTipoContr (DB_OggettoFatturazione pDB_OggettoFatturazione,
						String pstr_AccountDaEliminare)
                                throws CustomException, RemoteException;
}