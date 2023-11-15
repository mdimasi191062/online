package com.ejbBMP;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.FinderException;
import java.util.Collection;

public interface ElaborBatchBMPHome extends EJBHome
{
    ElaborBatchBMP create() throws RemoteException, CreateException;

    ElaborBatchBMP findElabBatchCodeFunz(String CodeFunz) throws RemoteException, FinderException;
   
    ElaborBatchBMP findManualCodeFunz(String[] account) throws RemoteException, FinderException;
    
    ElaborBatchBMP findManualUpdateCodeFunz(String[] account) throws FinderException, RemoteException;
    ElaborBatchBMP findByPrimaryKey(ElaborBatchBMPPK primaryKey) throws RemoteException, FinderException;
    ElaborBatchBMP findElabBatchCSV(String CodeFunz) throws RemoteException, FinderException;
    ElaborBatchBMP findElabBatchCSV2(String CodeFunz, String Sys) throws RemoteException, FinderException;
    ElaborBatchBMP findElabBatchCL() throws RemoteException, FinderException;
    ElaborBatchBMP findElabBatchXDSL() throws RemoteException, FinderException;
    ElaborBatchBMP findElabBatchULL() throws RemoteException, FinderException;
    Collection findLstVer(String CodeFunz,String CodeTipoContratto) throws RemoteException, FinderException;
    Collection findLstVerRepricing(String CodeFunz,String CodeTipoContratto) throws RemoteException, FinderException;
    ElaborBatchBMP findElabBatchUguali(int flagContratto) throws RemoteException, FinderException;
    ElaborBatchBMP findElabBatchCtrlEV(String CodeFunzBatch) throws RemoteException, FinderException;
    ElaborBatchBMP findElabBatchEsistNC(String CodeFunzBatch,String CodeAccount) throws RemoteException, FinderException;
    ElaborBatchBMP findElabBatchInCorso() throws RemoteException, FinderException;
    ElaborBatchBMP findElabBatchCodeTipoContrUguali(String CodeTipoContr) throws RemoteException, FinderException;    
 }


