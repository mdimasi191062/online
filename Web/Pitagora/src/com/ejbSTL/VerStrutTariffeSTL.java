package com.ejbSTL;
import javax.ejb.EJBObject;
import java.util.*;
import java.rmi.*;
import com.utl.*;

public interface VerStrutTariffeSTL extends EJBObject 
{
    public Vector getContrXTipoContr(String codTipoContr) throws RemoteException;
    public Vector getPsXTipoContr(String codTipoContr) throws RemoteException;
    public Vector getOggFatrzXTipoContr(String codTipoContr) throws RemoteException;
    public Vector getCausaliXTipoContr(String codTipoContr,String code_ogg_fatrz) throws RemoteException;
}