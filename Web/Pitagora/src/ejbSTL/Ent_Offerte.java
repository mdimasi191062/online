package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import com.utl.*;
import java.util.Vector;

public interface Ent_Offerte extends EJBObject 
{
    public Vector getOfferte()throws CustomException, RemoteException;
    public Vector getOfferte(int Servizio,int Prodotto)throws CustomException, RemoteException;
    public String getOfferteXml()throws CustomException, RemoteException;
    public String getOfferteXml(int Servizio,int Prodotto)throws CustomException, RemoteException;
}