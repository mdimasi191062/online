package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ent_TipoCausaleNew extends EJBObject 
{
    public Vector getTipiCausale()throws CustomException, RemoteException;
    public String getTipiCausaleXml()throws CustomException, RemoteException;
}