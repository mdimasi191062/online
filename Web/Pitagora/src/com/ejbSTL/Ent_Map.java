package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ent_Map extends EJBObject 
{
 Vector getMap (int pint_OperazioneRichiesta)
 throws CustomException, RemoteException;
}