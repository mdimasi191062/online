package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;
import org.jdom.*;
import java.io.*;
import org.jdom.output.*;

public interface Ctr_Catalogo extends EJBObject 
{
  String createTreeCatalogoXml() throws CustomException, RemoteException;
  String createTreeCatalogoXml(String CodeOfferta) throws CustomException, RemoteException;
  String createTreeCatalogoXmlProdotti(String CodeOfferta, String CodeServizio) throws CustomException, RemoteException;
  String createTreeCatalogoXmlComponenti(String CodeProdotto) throws CustomException, RemoteException;
  String createTreeCatalogoXmlPrestazioni(String CodeProdotto, String CodeComponente) throws CustomException, RemoteException;
  String getModalitaApplicazioneNoleggioXml() throws CustomException, RemoteException ;
}