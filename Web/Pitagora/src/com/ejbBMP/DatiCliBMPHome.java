package com.ejbBMP;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.FinderException;
import java.util.Collection;

public interface DatiCliBMPHome extends EJBHome
{
  DatiCliBMP create() throws RemoteException, CreateException;
  DatiCliBMP findByPrimaryKey(DatiCliBMPPK primaryKey) throws RemoteException, FinderException;
  Collection findValAttSpec1(String DataIni, String DataFine, String CodTipoContr,String CodeFunz,String Sys) throws FinderException, RemoteException;
  Collection findValAttClass(String DataIni, String DataFine, String CodTipoContr,String CodeFunz,String Sys) throws FinderException, RemoteException;
  Collection findAvanzRicClass(String Mese, String Anno, String CodTipoContr,String Sys) throws FinderException, RemoteException;
  Collection findNotaCreClass(String DataFine, String CodTipoContr,String Sys) throws FinderException, RemoteException;
  Collection findRepricClass(String CodTipoContr,String CodeFunz, String CodeElab, String Sys) throws FinderException, RemoteException;
  Collection findNotaCreSpec1(String DataIni, String DataFine, String CodTipoContr,String Sys) throws FinderException, RemoteException;
  Collection findValAttSpec2(String DataIni, String DataFine, String CodTipoContr,String CodeFunz,String Sys) throws FinderException, RemoteException;
  Collection findNotaCreSpec2(String DataIni, String DataFine, String CodTipoContr,String Sys) throws FinderException, RemoteException;
  DatiCliBMP findCodElabBatch(String CodFunz, String PeriodoRif, String Sys) throws RemoteException, FinderException;
  Collection findAllAccXNC(String CodFunzVA, String CodFunzNC, String CodTipoContr) throws FinderException, RemoteException;
  Collection findAllAccXNCAbort(String CodFunzVA, String CodFunzNC) throws FinderException, RemoteException;
  Collection findAccountNoCong(String CodFunz, String CodTipoContr) throws FinderException, RemoteException;
  //DatiCliBMP findMaxDataFine(String codeFunzBatchNC) throws FinderException, RemoteException;
  DatiCliBMP findMaxDataFine(String codeFunzBatchNC, String CodTipoContr) throws FinderException, RemoteException;//19/01/2004
  DatiCliBMP findNumFattLisUn(String flagTipoContr, String CodContr) throws RemoteException, FinderException;
  Collection findAllAccXVa(String CicloFatt, String DataIniCiclo, String CodTipoContr) throws FinderException, RemoteException;
  Collection findAllAccXVa2(String CicloFatt, String DataIniCiclo, String CodTipoContr, String prov) throws FinderException, RemoteException;
  Collection findAllAccXVaCiclo(String CicloFatt, String DataIniCiclo, String CodTipoContr) throws FinderException, RemoteException;
  Collection findAllAccXVaCiclo2(String CicloFatt, String DataIniCiclo, String CodTipoContr, String Prov) throws FinderException, RemoteException;
  Collection findAllAccNoVa(String CodTipoContr,String CicloFatt, String DataIniCiclo) throws FinderException, RemoteException;
  Collection findFattProvv(String CodeFunzBatch,String CicloFatt,String DataIniCiclo, String CodeTipoContr) throws RemoteException, FinderException;
  //void remove(String codeFunzBatch,String code_account) throws FinderException, RemoteException;
  DatiCliBMP findPredValAtt(String CodTipoContr) throws FinderException, RemoteException;
  Collection findAllAccNoteCred(String CodeFunzBatchNC ,String CodTipoContr) throws FinderException, RemoteException;
  Collection findAllAccRepricing(String chiamante,String CodeFunzBatchRE ,String CodTipoContr) throws FinderException, RemoteException;//20/06/2003
  DatiCliBMP findCodeParamAccount(String code_account) throws RemoteException, FinderException;  
  //DatiCliBMP findAggInsCodParam(String code_param, String code_account, int flag_commit) throws RemoteException, FinderException;
  void aggInsCodParam(Collection Account_provv) throws RemoteException, FinderException;
  void removeFattProvv(String codeFunzBatch,Collection Account_fatt_provv) throws RemoteException, FinderException;
  Collection findRepricSpec(String DataIni, String DataFine, String CodTipoContr,String CodeFunz,String Sys) throws FinderException, RemoteException;
  Collection findFattMan(String DataIni, String DataFine, String CodTipoContr,String CodeFunz,String Sys) throws FinderException, RemoteException;
 }
