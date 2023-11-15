package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ent_TipiCausale extends EJBObject 
{
  // getTipiCausale
  Vector getTipiCausale (int pint_OperazioneRichiesta,
                         int pint_Funzionalita,
                         String pstr_CodePS,
                         String pstr_CodeGest,
                         String pstr_CodeContr,
                         String pstr_CodePrestAgg,
                         String pstr_CodeTipoContr,
                         String pstr_CodeOggFatrz)
        throws CustomException, RemoteException;
}