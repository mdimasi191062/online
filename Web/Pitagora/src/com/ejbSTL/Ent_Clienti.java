package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ent_Clienti extends EJBObject 
{
    // getClienti 
    Vector getClienti(int pint_OperazioneRichiesta,
                      int pint_Funzionalita,
                      String pstr_TipiContratto,
                      String pstr_ClientiSrc)
          throws CustomException, RemoteException;

    // getClientiIspOlo 
    Vector getClientiIspOlo ( int pint_OperazioneRichiesta,
                                   String pstr_TipoContratto,
                                   String pstr_Codetipocaus,
                                   String pstr_Codeps,
                                   String pstr_CodeOggfatrz,
                                   String pstr_codeprestagg)
        throws CustomException, RemoteException;


    // getPeriodiRiferimento
    Vector getPeriodiRiferimento (int pint_OperazioneRichiesta,
                                  String pstr_CodeTipoContratto)
        throws CustomException, RemoteException;

}