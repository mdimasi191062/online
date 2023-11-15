package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ent_DownloadReport extends EJBObject 
{
  Vector getLstFunzionalita()throws CustomException, RemoteException;
  Vector getLstFunzionalitaCL()throws CustomException, RemoteException;
  Vector getLstTipoContr(String strCodeFunz, String strTipoBatch,String strFlagSys, String strCodeCiclo)throws CustomException, RemoteException;
  Vector getLstCicli(String strCodeFunz, String strTipoBatch, String strFlagSys)throws CustomException, RemoteException; 
  Vector getLstAccount(String strCodeFunz, String strCodeTipoContr, String strCiclo, String strTipoBatch, String strFlagSys)throws CustomException, RemoteException;
  DB_DownloadReport_Funzionalita getParamFunzionalita(String strCodeFunz)throws CustomException, RemoteException;
  DB_DownloadReport_Periodi getParamCiclo(String codeCiclo)throws CustomException, RemoteException;
  DB_DownloadReport_Servizi getParamTipoContr(String codeServizio,String tipoBatch)throws CustomException, RemoteException;  
  
  /*GENERICO- INIZIO*/
  Vector getDataDownload(String strCodeFunz, String strTipoBatch, String strQueryServizi, String strQueryPeriodi,
                         String strQueryAccount, String strEstensioneFile, String strEstensioneFileStorici,
                         String strPathReport, String strPathReportStorici, String strPathFileZip,
                         String strFlagSys, String strCodeServizio, String strCodeCiclo, 
                         String strCodeAccount, String strTipoFile)throws CustomException, RemoteException;  
}