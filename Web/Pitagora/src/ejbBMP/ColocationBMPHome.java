package com.ejbBMP;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.FinderException;
import java.util.Collection;
import java.util.*;
import com.utl.*;

import java.lang.*;
 
public interface ColocationBMPHome extends EJBHome 
{
  //ColocationBMP create() throws RemoteException, CreateException;
  
    //metodo di prova ROSA "CORNELI",006269,141,04/10/2002,i,i
  //  ColocationBMP create(String code_utente,String sitoSelez, String accountSelez, String data_ini, Double imptar, Double impcons)throws RemoteException, CreateException;
ColocationBMP create(String code_utente,String sitoSelez, String accountSelez, String data_ini, Double imptar, Double impcons, int mod_ull, int mod_itc,String[] eleCodePs,String[] eleQtaPs)
  throws CreateException, RemoteException ,CustomEJBException;
   void remove(ColocationBMPPK pk) throws FinderException, RemoteException;

void store(String code_utente,String sitoSelez, String accountSelez, String data_ini, Double imptar, Double impcons, int mod_ull, int mod_itc,String[] eleCodePs,String[] eleQtaPs)
  throws CreateException, RemoteException ,CustomEJBException;
  
  ColocationBMP findByPrimaryKey(ColocationBMPPK primaryKey) throws RemoteException, FinderException;
  //Metodo per il caricamento della lista su ListaAccountCol
  Collection findAll(String CodSito) throws FinderException, RemoteException;
  //2/10/02 inizio
  //ColocationBMP findElabBatchInCorso()throws FinderException, RemoteException;
  ColocationBMP findDataIniValAcc(String accountSelez)throws FinderException, RemoteException;
  //2/10/02 fine
}               