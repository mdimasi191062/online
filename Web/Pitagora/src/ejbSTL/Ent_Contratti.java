package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ent_Contratti extends EJBObject 
{

  // getContratti
  Vector getContratti(int pint_OperazioneRichiesta,
                      int pint_Funzionalita,
                      String pstr_CodeGest,
                      String pstr_TipoContratto) 
        throws CustomException, RemoteException;

                              
  // getMaxDateXContratto
  String getMaxDateXContratto (int pint_OperazioneRichiesta,
                               String pstr_CodeContr)
        throws CustomException, RemoteException;

  // getAccountEsistenti
  Vector getAccountEsistenti (DB_Tariffe pDB_Tariffe)
    	throws CustomException, RemoteException;

  // getAccountEsistentiOfPs
  Vector getAccountEsistentiOfPs (DB_OggettoFatturazione pDB_OggFatt)
      throws CustomException, RemoteException;

  // getAccountVerificaSpeCom
  Vector getAccountVerificaSpeCom (int pint_OperazioneRichiesta,
                                      String pstr_CodeTipoContratto,
                                      String pstr_CodeElab)
      throws CustomException, RemoteException;
// getAccountSpeCom
Vector getAccountSpeCom (int pint_OperazioneRichiesta,
                              String pstr_CodeTipoContratto,
                              String pstr_PeriodoRiferimento,
                              String pstr_PeriodoDataIns)
      throws CustomException, RemoteException;
// getAccountSpeComAcqImp
Vector getAccountSpeComAcqImp (int pint_OperazioneRichiesta,
                                String pstr_CodeTipoContratto,
                                String pstr_CodeGest,
								String pstr_Mode)
    throws CustomException, RemoteException;
// getAccountSpeComCalPar
Vector getAccountSpeComCalPar (int pint_OperazioneRichiesta,
                                String pstr_CodeTipoContratto,
                                String pstr_CodeGest)
    throws CustomException, RemoteException;

  // getAccountNDC
  Vector getAccountNDC (int pint_OperazioneRichiesta,
                            String pstr_TipoContratto,
                            String pstr_CodeFunzVal,
                            String pstr_CodeFunzNdc)
        throws CustomException, RemoteException;


  // getAccountAnomali
  Vector getAccountAnomali (int pint_OperazioneRichiesta,
                            String pstr_TipoContratto,
                            String pstr_CodeAccount,
                            String pstr_CodeFunz)
        throws CustomException, RemoteException;


	// getAccountStatoProvvisorio
	Vector getAccountStatoProvvisorio (int pint_OperazioneRichiesta,
										String pstr_CodeAccount,
										String pstr_CodeGest,
										String pstr_TipoContratto,
										String pstr_CodeFunz)
		throws CustomException, RemoteException;


  // getAccountXCodeElab
  Vector getAccountXCodeElab ( int pint_OperazioneRichiesta,
                                      String pstr_CodeElab,
                                      String pstr_TipoContratto,
                                      String pstr_TipoFlagErrBloc)
       throws CustomException, RemoteException;

  // getAccountSpeComNoCong 
  Vector getAccountSpeComNoCong ( int pint_OperazioneRichiesta,
                                    String pstr_TipoContratto,
                                    String pstr_CodeAccount)
        throws CustomException, RemoteException;

  // getAccountRepricing
  Vector getAccountRepricing (int pint_OperazioneRichiesta,
                         String pstr_TipoContratto,
                         String pstr_ValorizAttiva,
                         String pstr_ValorizPassiva)
        throws CustomException, RemoteException;

  // getAccountXParamVal
  Vector getAccountXParamVal(int pint_OperazioneRichiesta)
        throws CustomException, RemoteException;

  // getAccountValAttiva
  Vector getAccountValAttiva (int pint_OperazioneRichiesta,
                         String pstr_TipoContratto,
                         String pstr_CicloFatrz,
                         String pstr_IstanzaCiclo,
                         String pstr_CodeAccount)
        throws CustomException, RemoteException;

  // getAccountFatture
  Vector getAccountFatture (int pint_OperazioneRichiesta,
                         String pstr_TipoContratto,
                         String pstr_CicloFatrz,
                         String pstr_IstanzaCiclo,
                         String pstr_TipoFattura)
        throws CustomException, RemoteException;

  // getAccountParamClasSconto
  Vector getAccountParamClasSconto ()
        throws CustomException, RemoteException;

  //getPeriodoParamClasSconto
    Vector getPeriodoParamClasSconto ()
        throws CustomException, RemoteException;
        
  //countGestoriParamClasSconto
    Integer countGestoriParamClasSconto (String pstr_Mese,
                                            String pstr_Anno,
                                            String pstr_CodeGest)
        throws CustomException, RemoteException;
        
  //getSumTotSpesaParamClasSconto
    Double getSumTotSpesaParamClasSconto (String pstr_Mese,
                                              String pstr_Anno,
                                              String pstr_CodeGest)
        throws CustomException, RemoteException;

  //GetlistaAccountParamClasSconto
    Vector GetlistaAccountParamClasSconto (String pstr_Mese,
                                              String pstr_Anno)/*,
                                              String pstr_CodeGest,
                                              String pstr_CodeTipoContr)*/
        throws CustomException, RemoteException;
  
  String getVerificaContrattoProvvisorio(String pstr_CodeContr) throws  RemoteException, CustomException;
  
  //getDatiObjFileEstrazioni
  I52Estrazioni_cvidya_lanci getDatiObjFileEstrazioni(String nomeFileEstrazione) throws  RemoteException,CustomException;
}