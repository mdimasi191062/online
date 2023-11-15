package com.ejbSTL;
import javax.ejb.EJBObject;
import java.util.Vector;
import java.rmi.RemoteException;
import com.utl.*;

public interface Ent_TipiOfferte extends EJBObject 
{
  Vector getTipiOfferte(int pint_OperazioneRichiesta)
        throws CustomException, RemoteException;
}