package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ent_TipoArrotondamento extends EJBObject 
{
     public Vector getTipoArrotondamento()throws CustomException, RemoteException;
}
