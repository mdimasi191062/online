package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ent_AnagraficaMessaggi extends EJBObject 
{
  Vector getAnagraficaMessaggi(int pint_OperazioneRichiesta,
                                      Vector pvct_ListaMessaggi)
        throws CustomException, RemoteException;

  String getAnagraficaMessaggi(int pint_OperazioneRichiesta,
                                        String pstr_CodiceMessaggio)
        throws CustomException, RemoteException;
}