package com.ejbSTL;
import javax.ejb.EJBObject;
import java.util.Vector;
import java.rmi.RemoteException;
import com.utl.*;

public interface Ent_Fasce extends EJBObject 
{
  Vector getFasce( int pstr_OperazioneRichiesta )
        throws CustomException, RemoteException;

  Vector getDettaglioFasce( int pint_OperazioneRichiesta,
                                    String pstr_CodeFascia)
        throws CustomException, RemoteException;
}