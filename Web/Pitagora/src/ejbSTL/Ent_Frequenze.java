package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ent_Frequenze extends EJBObject 
{
  Vector getFrequenze (int pint_OperazioneRichiesta) 
  throws CustomException, RemoteException;
}