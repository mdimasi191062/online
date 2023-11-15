package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ent_ProdottiServizi extends EJBObject 
{
  // getProdottiServizi
  Vector getProdottiServizi(int pint_OperazioneRichiesta,
                             int pint_Funzionalita,
                             String pstr_CodeGest,
                             String pstr_CodeContr,
                             String pstr_CodeTipoContr,
                             String pstr_CodePs)
        throws CustomException, RemoteException;


  // countPSXContratto
  Integer countPSXContratto(int pint_OperazioneRichiesta,
                            String pstr_CodeContr,
                            String pstr_CodePs,
                            String pstr_CodePrestAgg)
        throws CustomException, RemoteException;


  // countIntersectPSXContratto
  Integer countIntersectPSXContratto(int pint_OperazioneRichiesta,
                                     String pstr_CodeContrOri,
                                     String pstr_CodeContrDest)
        throws CustomException, RemoteException;
   
   // getMaxDateXPs
   String getMaxDateXPs (int pint_OperazioneRichiesta,
                         String pstr_CodePS)
        throws CustomException, RemoteException;

   // getCodePSPadreGenerale
   String getCodePSPadreGenerale (int pint_OperazioneRichiesta,
                                  String pstr_CodePS)
        throws CustomException, RemoteException;

   /*******************************************************
   // getPsCompFatt
   Vector getPsCompFatt (int pint_OperazioneRichiesta,
                             String pstr_CodePs)
   throws CustomException, RemoteException;

   // getPSRifValidi
   Vector getPSRifValidi (int pint_OperazioneRichiesta,
                          String pstr_CodeTipoContr,
                          String pstr_CodeGest,
                          String pstr_CodeContr)
   throws CustomException, RemoteException;
   *******************************************************/

   // getPS
   Vector getPS (int pint_OperazioneRichiesta,
                 String pstr_CodePS)
   throws CustomException, RemoteException;
}