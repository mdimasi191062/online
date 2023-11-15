package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ctr_Contratti extends EJBObject 
{
  // getClientiStatoProvvisorio
  Vector getAccountStatoProvvisorio (Vector pvct_AccountSelezionati, 
                                     String pstr_TipoContratto,
                                     String pstr_CodeFunz)
    throws CustomException, RemoteException;

  // getClientiSpeComNoCong
  Vector getAccountSpeComNoCong (Vector pvct_AccountSelezionati,
                                 String pstr_TipoContratto)
    throws CustomException, RemoteException;

  // getAccountValAttiva
  Vector getAccountValAttiva    (Vector pvct_AccountSelezionati, 
                                 String pstr_TipoContratto,
                                 String pstr_CodeCicloFatrz,
                                 String pstr_IstanzaCicloFatrz)
    throws CustomException, RemoteException;

  // insAccountParamValoriz
  String insAccountParamValoriz ()
    throws CustomException, RemoteException;

// getAccountXCalcoloParametriClassiSconto
  Vector getAccountXCalcoloParametriClassiSconto ()
    throws CustomException, RemoteException;
}