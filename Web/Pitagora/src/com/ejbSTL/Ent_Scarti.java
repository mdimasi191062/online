package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ent_Scarti extends EJBObject 
{
   // getScarti
   Vector getScarti (int pint_OperazioneRichiesta,
                     String pstr_CodeAccount,
                     String pstr_CodeFunz,
                     String pstr_CodeTestSpesaCompl,
                     String pstr_CodeElab)
   throws CustomException, RemoteException;

  // updScarti
  Integer updScarti(int pint_OperazioneRichiesta,
                           String pstr_CodeScarto,
                           String pstr_TipoFlagStatoScarto)
   throws CustomException, RemoteException;
}