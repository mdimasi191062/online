package com.ejbSTL;
import javax.ejb.EJBObject;
import java.util.Vector;
import java.rmi.RemoteException;
import com.utl.*;

public interface Ent_ClassOggFatt extends EJBObject 
{
  Vector getclassoggfatt(int pint_OperazioneRichiesta)
        throws CustomException, RemoteException;
}