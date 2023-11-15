package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ent_Tariffe extends EJBObject 
{
  // getListaTariffe
  Vector getListaTariffe(int pint_OperazioneRichiesta,
                         String pstr_CodeContr,
                         String pstr_CodePs,
                         String pstr_CodePrestAgg,
                         String pstr_CodeTipoCausale,
                         String pstr_CodeOggFatrz)
        throws CustomException, RemoteException;


  // getDettaglioTariffa
  Vector getDettaglioTariffa(int pint_OperazioneRichiesta,
                             String pstr_CodeTariffa,
                             String pstr_DataCreazTariffa)
        throws CustomException, RemoteException;


  // insTariffa
  Integer insTariffa(int pint_OperazioneRichiesta,DB_Tariffe pDB_Tariffe )
        throws CustomException, RemoteException;


  // chkTariffa
  Integer chkTariffa(int pint_OperazioneRichiesta,
                     int pint_Funzionalita,
                     DB_Tariffe pDB_Tariffe )
        throws CustomException, RemoteException;


  // getTariffaXTipoContrUpd 
  Vector getTariffaXTipoContrUpd (int pint_OperazioneRichiesta, DB_Tariffe pDB_Tariffe )
        throws CustomException, RemoteException;


  // delTariffa
  Integer delTariffa(int pint_OperazioneRichiesta,
                     String pstr_CodeTariffa,
                     String pstr_MaxDataCreazione)
        throws CustomException, RemoteException;


  // getTariffaSequence
  Integer getTariffaSequence(int pint_OperazioneRichiesta)
        throws CustomException, RemoteException;


  // getTariffaMaxProgr
  Integer getTariffaMaxProgr (int pint_OperazioneRichiesta,
                              String pstr_CodeTariffa)
        throws CustomException, RemoteException;

  // getTariffaMaxDataCreaz
  DB_Tariffe getTariffaMaxDataCreaz (String pstr_CodeTariffa,
                                        String pstr_DataInizioTariffa,
                                        String pstr_DataCreazTariffa)
        throws CustomException, RemoteException;

  // updTariffa
  Integer updTariffa(int pint_OperazioneRichiesta,DB_Tariffe pDB_Tariffe )
        throws CustomException, RemoteException;      


  // getDettRibaTariffa
  Vector getDettRibaTariffa (int pint_OperazioneRichiesta,
                             String pstr_CodeContr,
                             String pstr_CodePs,
                             String pstr_CodePrestAgg,
                             String pstr_CodeTipoCaus,
                             String pstr_CodeOggFatrz)
        throws CustomException, RemoteException;      


// delTariffaXTipoContr 
Integer delTariffaTipoContr (int pint_OperazioneRichiesta,DB_Tariffe pDB_Tariffe)
    throws CustomException, RemoteException;



// updTariffaMagDataInizio 
Integer updTariffaMagDataInizio (int pint_OperazioneRichiesta,
                                    String pstr_CodeTariffa,
                                    String pstr_DataInizio)
    throws CustomException, RemoteException;


// delTariffaMagDataInizio 
Integer delTariffaMagDataInizio (int pint_OperazioneRichiesta,
                                    String pstr_CodeTariffa,
                                    String pstr_DataInizio)
    throws CustomException, RemoteException;



  // CountTariffeXTipoContr
  Integer chkTariffaTipoContrDel ( int pint_OperazioneRichiesta,DB_Tariffe pDB_Tariffe)
    throws CustomException, RemoteException;


  // updTariffaXDataCreaz 
  Integer updTariffaXDataCreaz (int pint_OperazioneRichiesta,
                                String pstr_CodeTariffa,
                                String pstr_DataFineTariffa,
                                String pstr_DataCreazioneTariffa)
    throws CustomException, RemoteException;

  // updTariffaSpesaComplessiva 
  Integer updTariffaSpesaComplessiva (int pint_OperazioneRichiesta,
                                        String pstr_CodeTipoContr,
                                        String pstr_CodeGest)
    throws CustomException, RemoteException;

  // Check tariffa Repricing
  int checkTariffaRepricing(String code_tariffa,
                            String code_pr_tariffa,
                            String data_inizio_validita,
                            String data_inizio_validita_old,
                            String code_ogg_fatrz) 
    throws CustomException, RemoteException;
}