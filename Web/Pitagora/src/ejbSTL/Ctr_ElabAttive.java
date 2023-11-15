package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ctr_ElabAttive extends EJBObject 
{
  public Vector getElabAttive() throws CustomException, RemoteException;
  public Vector getWebUplFile() throws CustomException, RemoteException;
  public DB_WebUplFiles getWebUpl(String CodeFunz) throws CustomException, RemoteException;
  public DB_ElabAttive getElabAttiva(String CodeFunz) throws CustomException, RemoteException;
  public String getXmlServizi(String StoredProcedure) throws CustomException, RemoteException;
  public String getXmlServizi(String StoredProcedure,String PeriodoRif) throws CustomException, RemoteException;
  public String getXmlAccount(String StoredProcedure) throws CustomException, RemoteException;  
  public String getXmlAccount(String StoredProcedure,String PeriodoRif) throws CustomException, RemoteException;  
  public String getXmlGestori(String StoredProcedure) throws CustomException, RemoteException;
  public String getXmlGestori(String StoredProcedure,String PeriodoRif) throws CustomException, RemoteException;
  public Vector getPeriodoRiferimento(String StoredProcedure) throws CustomException, RemoteException;
  //QS 06/12/2007-Modifica per GECOM: aggiunto alla funzione lancioBatch il flag checkInvioGecom
  public int lancioBatch(String pstr_CodeElab,String str_User, String str_Param, String str_PeriodoRif,
        String[] str_Gestori, String[] str_Servizi,String[] str_Account,
        String str_DataFinePeriodo,String ivaFc, boolean bol_AcquisizioneTldDaFile,boolean bol_CongelamentoSpesa,String strTextNomeFile,boolean bol_checkInvioGecom,String cinqueAnni,
        //String reprDel,String richEmissRepr,String dataDelib,String dataChiusAnnoCont,String motRepricing) throws CustomException, RemoteException;
         String newParameter) throws CustomException, RemoteException;
  public Vector getVerificaElabAttive(String CodeFunz) throws CustomException, RemoteException;
  public Vector getVerificaElabAttiveResocontoSap(String CodeFunz) throws CustomException, RemoteException;
  public DB_ElabBatch getVerificaElabAttiva(String CodeFunz,String CodeElab) throws CustomException, RemoteException;
  public DB_ElabBatchResocontoSAP getVerificaElabAttivaResoconto(String CodeFunz,String CodeElab) throws CustomException, RemoteException;  
  public Vector getVerificaDettaglioElabAttive(String StoredProcedure,String CodeElab) throws CustomException, RemoteException;  
  public Vector getVerificaDettaglioElabAttive(String StoredProcedure,String CodeElab,String DescAccGest) throws CustomException, RemoteException;  
  public String getDescErrore(int CodeErrore)throws CustomException, RemoteException;
  public Vector getScartiElabAttive(String StoredProcedure,String CodeGestoreAccount,String CodeElab) throws CustomException, RemoteException;
  public Vector getAccountFromServizio(String CodeServizio) throws CustomException, RemoteException;  
  public int insertElabPreinve(String codice_ciclo) throws CustomException, RemoteException;
  public int insGruppoAccount (String strDescGruppo , String strDataInizioValid, String strCodeAccount,  String strCodeRelazione ) throws CustomException, RemoteException;
  public String getValueUplFile () throws CustomException, RemoteException;
  public int lancioBatchResocontoSAP(String pstr_CodeElab,String str_User,
                                     String str_ParamJPUB2,String str_ParamJPUBS,
                                     String str_CodeCiclo) throws CustomException, RemoteException;
  public int lancioProgDigDiv(String pstr_CodeElab,String str_User,
                                     String strParamANNO) throws CustomException, RemoteException;
}