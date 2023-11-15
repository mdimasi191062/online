package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ent_Fatture extends EJBObject 
{
  // getAnagCicliFatrz
  Vector getAnagCicliFatrz (int pint_OperazioneRichiesta)
        throws CustomException, RemoteException;

  // getAnagCicliFatrz
  Vector getMinDateCicliFatrz (int pint_OperazioneRichiesta,
                               String pstr_CodeTipoContr,
                               String pstr_CodeCicloFatrz)
        throws CustomException, RemoteException;
  // insTestDocFattura
  Integer insTestDocFattura (int pint_OperazioneRichiesta,DB_Fatture pDB_Fattura )
        throws CustomException, RemoteException;

  // delDettDocFattura
  Integer delDettDocFattura(int pint_OperazioneRichiesta, String pstr_CodeDocFattura)
        throws CustomException, RemoteException;

  // delTestDocFattura
  Integer delTestDocFattura(int pint_OperazioneRichiesta, String pstr_CodeDocFattura)
        throws CustomException, RemoteException;
}