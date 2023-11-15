package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ent_Statistiche extends EJBObject  {

    // getAccountStatistiche 
    Vector getAccountStatistiche(int pint_OperazioneRichiesta,
                                              int pint_Funzionalita,
                                              String pstr_TipoContratto)
          throws CustomException, RemoteException;
          
}