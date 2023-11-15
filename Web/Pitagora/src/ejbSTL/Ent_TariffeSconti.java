package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ent_TariffeSconti extends EJBObject 
{
 Integer delTariffeSconti(int pint_OperazioneRichiesta,
                          String pstr_CodeTariffa,
                          String pstr_CodePrTariffa)
 throws CustomException, RemoteException;

 Integer chkTariffeSconti(int pint_OperazioneRichiesta,
                          String pstr_CodeTariffa,
                          String pstr_CodePrTariffa)
 throws CustomException, RemoteException;
 
 Integer updTariffeSconti(int pint_OperazioneRichiesta,
                          String pstr_CodeTariffa,
                          String pstr_CodePrTariffa,
                          String pstr_CodePrTariffaOld)
 throws CustomException, RemoteException;

   
 // delTariffeScontiTipoContr 
 Integer delTariffeScontiTipoContr (int pint_OperazioneRichiesta,
                                    DB_Tariffe pDB_Tariffe)
 throws CustomException, RemoteException;


  Vector getTariffeSconti( int pint_OperazioneRichiesta,
                                  int pint_Funzionalita,
                                  String pstr_CodeGest,
                                  String pstr_CodeContr,
                                  String pstr_CodeTipoContr,
                                  String pint_FlagFiltro)
                    throws CustomException, RemoteException;


  Vector getTariffeSconti
      (int pint_operazioneRichiesta
      ,int pint_funzionalita
      ,String pstr_codeTariffa
      ,String pstr_codeSconto)
      throws CustomException, RemoteException;


  int insert
      (String pstr_codeTariffa
      ,String pstr_codePrTariffa
      ,String pstr_codeSconto
      ,String pstr_dataInizioValid)
      throws CustomException, RemoteException;


  public int update
      (String pstr_codeTariffa
      ,String pstr_codePrTariffa
      ,String pstr_codeSconto
      ,String pstr_dataInizioValid
      ,String pstr_dataFineValid)
      throws CustomException, RemoteException;


  Vector getDettaglioTariffaSconto( int pint_OperazioneRichiesta,
                                            int pint_Funzionalita,
                                            String pstr_CODE_TARIFFA,
                                            String pstr_CODE_PR_TARIFFA,
                                            String pstr_CODE_SCONTO,
                                            String pstr_DATA_INIZIO_VALID)
                              throws CustomException, RemoteException; 
}