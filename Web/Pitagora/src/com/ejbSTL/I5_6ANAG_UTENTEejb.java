package com.ejbSTL;
import java.rmi.RemoteException;
import java.util.Vector;

import javax.ejb.EJBObject;

import com.utl.CustomException;
import com.utl.I5_6anag_utenteROW;

public interface I5_6ANAG_UTENTEejb extends EJBObject
{
    public Vector find(String string, String string_0_)
	throws CustomException, RemoteException;
    
    public String creaNuovo(I5_6anag_utenteROW i5_6anag_utenterow)
	throws CustomException, RemoteException;
    
    public I5_6anag_utenteROW loadUtente(String string)
	throws CustomException, RemoteException;
    
    public String deleteUtente(String string)
	throws CustomException, RemoteException;
    
    public String updateUtente(I5_6anag_utenteROW i5_6anag_utenterow)
	throws CustomException, RemoteException;
    
    public String riabilitaUtente(String string)
	throws CustomException, RemoteException;
    
    public String insParamProfUte
	(String string, String string_1_, String string_2_, String string_3_)
	throws CustomException, RemoteException;
    
    public I5_6anag_utenteROW loadParamProfUte()
	throws CustomException, RemoteException;
}
