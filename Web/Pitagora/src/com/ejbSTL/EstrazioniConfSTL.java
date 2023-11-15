package com.ejbSTL;
import javax.ejb.EJBObject;
import java.util.*;
import java.rmi.*;
import com.utl.*;


public interface EstrazioniConfSTL extends EJBObject 
{

  public Vector getEstrazioniConf() throws RemoteException, CustomException;
  public Vector getEstrazioniCruscottoConf() throws RemoteException, CustomException;
    
    public Vector getEstrazioniConsistenzeAttive(String strCodeServizio, String strDataCompDa, String strDataCompA, String strCodeAccount, String strCodeProdotto ) throws RemoteException, CustomException;
    public Vector getDettaglioEstrazioniConsistenzeAttive(String strCodeServizio,String strCodeAccount, String strCodeProdotto, String strMeseAnnoComp,String strDataCompDa, String strDataCompA ) throws RemoteException, CustomException;
    public String getUltimoAggiornamento() throws RemoteException, CustomException;
}