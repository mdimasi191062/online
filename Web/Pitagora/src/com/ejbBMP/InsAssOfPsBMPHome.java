package com.ejbBMP;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.FinderException;
import java.util.Collection;
import java.util.*;
import java.lang.*;


public interface InsAssOfPsBMPHome extends EJBHome 
{

  InsAssOfPsBMP create(String data_ini,String cod_contratto,String PS,String dataInizioOf,
                       String modApplSelezValue,String freqSelezValue,String codiceUtente,
                       int shift,String flagAP,String data_fine) 
                        throws RemoteException, CreateException;

  InsAssOfPsBMP findByPrimaryKey(InsAssOfPsBMPPK primaryKey)  throws RemoteException, FinderException;
  InsAssOfPsBMP findAssOfPsMaxDataIni  (String cod_ps)        throws FinderException, RemoteException;
  InsAssOfPsBMP findAssOfPsMaxDataIniOf(String cod_contratto) throws FinderException, RemoteException;
  InsAssOfPsBMP findDataFineValOf      (String cod_of)        throws FinderException, RemoteException;
  InsAssOfPsBMP findMinData            (String cod_contratto,String cod_of,String cod_ps)        throws FinderException, RemoteException;
  InsAssOfPsBMP findMaxData            (String cod_contratto,String cod_of,String cod_ps)        throws FinderException, RemoteException;
  InsAssOfPsBMP findDataInizioOf      (String cod_of)        throws FinderException, RemoteException;

}