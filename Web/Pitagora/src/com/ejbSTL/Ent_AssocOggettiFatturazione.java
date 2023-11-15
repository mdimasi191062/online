package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ent_AssocOggettiFatturazione extends EJBObject 
{
  // countOFPSAperti
  Integer countOFPSAperti      (int pint_OperazioneRichiesta,
                                String pstr_CodeTipoContr,
                                String pstr_CodeContr,
                                String pstr_CodeOggFatrz,
                                String pstr_CodePrestAgg,
                                String pstr_CodeTipoCaus,
                                String pstr_CodePs,
                                String pstr_AccountDaEliminare)
        throws CustomException, RemoteException;

  // getMinMaxDateOFPS
  Vector getMinMaxDateOFPS ( int pint_OperazioneRichiesta,
                             String pstr_CodeTipoContr,
                             String pstr_CodeContr,
                             String pstr_CodeOggFatrz,
                             String pstr_CodePrestAgg,
                             String pstr_CodeTipoCaus,
                             String pstr_CodePs,
                             String pstr_AccountDaEliminare)
        throws CustomException, RemoteException;

  // countOFPSGiaPresenti
  Integer countOFPSGiaPresenti (int pint_OperazioneRichiesta,
                                String pstr_CodeTipoContr,
                                String pstr_CodeContr,
                                String pstr_CodeOggFatrz,
                                String pstr_CodePrestAgg,
                                String pstr_CodeTipoCaus,
                                String pstr_CodePs,
                                String pstr_AccountDaEliminare)
        throws CustomException, RemoteException;

  // chkPreDisattivazioneAssociazione
  Integer chkPreDisattivazioneAssociazione(int pint_OperazioneRichiesta,
                                           DB_OggettoFatturazione pDB_OggettoFatturazione)
        throws CustomException, RemoteException;

  // chkPostDisattivazioneAssociazione
  Integer chkPostDisattivazioneAssociazione(int pint_OperazioneRichiesta,
                                            DB_OggettoFatturazione pDB_OggettoFatturazione)
        throws CustomException, RemoteException;

  // getOggFatturazione
  Vector getAssocOggFatturazione(int pint_OperazioneRichiesta,
                                  int pint_Funzionalita,
                                  String pstr_CodeTipoContr,
                                  String pstr_CodeGest,
                                  String pstr_CodeContr,
                                  String pstr_CodePS,
                                  String pstr_CodePrestAgg,
                                  String pstr_CodeTipoCaus,
                                  String pstr_CodeOggFatrz,
                                  boolean pbln_AssociazioniDisattive,
				  String pstr_CodeAccountDaEliminare)
        throws CustomException, RemoteException;

  // updAssociazioneOfPs
  Integer updAssociazioneOfPs (int pint_OperazioneRichiesta,
                               DB_OggettoFatturazione pDB_OggettoFatturazione)
        throws CustomException, RemoteException;


  // insAssociazioneOfPs
  Integer insAssociazioneOfPs (int pint_OperazioneRichiesta,
                               DB_OggettoFatturazione pDB_OggettoFatturazione)
        throws CustomException, RemoteException;


  // getMinDataValidaOFPS
  String getMinDataValidaOFPS ( int pint_OperazioneRichiesta,
                                String pstr_CodeTipoContr,
                                String pstr_CodeContr,
                                String pstr_CodeOggFatrz,
                                String pstr_CodePrestAgg,
                                String pstr_CodeTipoCaus,
                                String pstr_CodePs)
        throws CustomException, RemoteException;


  // getCampiInsOFPS
  Vector getCampiInsOFPS (int pint_OperazioneRichiesta,
                             String pstr_CodeTipoContr,
                             String pstr_CodeContr,
                             String pstr_CodePrestAgg,
                             String pstr_CodePs,
                             String pstr_AccountDaEliminare)
        throws CustomException, RemoteException;
}