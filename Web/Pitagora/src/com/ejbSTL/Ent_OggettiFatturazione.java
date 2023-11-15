package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ent_OggettiFatturazione extends EJBObject 
{
  // getOggFatturazione
  Vector getOggFatturazione(int pint_OperazioneRichiesta,
                                int pint_Funzionalita,
                                String pstr_CodeTipoContr,
                                String pstr_CodeGest,
                                String pstr_CodeContr,
                                String pstr_CodePS,
                                String pstr_CodePrestAgg,
                                String pstr_CodeClasse)
        throws CustomException, RemoteException;


  // countOFPSValidiXContratto
  Integer countOFPSValidiXContratto ( int pint_OperazioneRichiesta,
                                      String pstr_CodeContr,
                                      String pstr_CodePs,
                                      String pstr_CodePrestAgg,
                                      String pstr_CodeOggFatrz)
        throws CustomException, RemoteException;


  // countOFPSXContratto
  Integer countOFPSXContratto ( int pint_OperazioneRichiesta,
                                String pstr_CodeContr,
                                String pstr_CodePs,
                                String pstr_CodePrestAgg,
                                String pstr_CodeOggFatrz)
        throws CustomException, RemoteException;



  // getMaxDateXOF
  String getMaxDateXOF (int pint_OperazioneRichiesta,
                        String pstr_CodeOF)
        throws CustomException, RemoteException;


  // getOggFattValidiXOfPsCorneli
  Vector getOggFattValidiXOfPsCorneli ( int pint_OperazioneRichiesta,
                                         String pstr_CodePS,
                                         String pstr_CodePrestAgg,
                                         String pstr_CodeTipoContr,
                                         String pstr_CodeTipoCausale,
                                         String pstr_CodeOggFatrz)
        throws CustomException, RemoteException;


  // countOFXOggFatrz
  Integer countOFXOggFatrz ( int pint_OperazioneRichiesta,
                             String pstr_CodeOF )
        throws CustomException, RemoteException;


  // getDataValidaXOF
  String getDataValidaXOF (int pint_OperazioneRichiesta,
                           String pstr_CodeOF)
        throws CustomException, RemoteException;
}