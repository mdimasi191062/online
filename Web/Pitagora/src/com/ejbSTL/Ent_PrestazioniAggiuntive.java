package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ent_PrestazioniAggiuntive extends EJBObject 
{
 Vector getPrestazioniAggiuntive(int pint_OperazioneRichiesta,
                                 int pint_Funzionalita,
                                 String pstr_CodePS,
                                 String pstr_CodeContr,
                                 String pstr_CodeTipoContr,
                                 String pstr_CodeGest)
        throws CustomException, RemoteException;
}