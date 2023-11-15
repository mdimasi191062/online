package com.ejbSTL;

import javax.ejb.EJBObject;

import java.rmi.RemoteException;

import com.utl.*;

import java.util.Vector;

import java.sql.*;

public interface Ent_Accordo extends EJBObject
{
 

 /* public String getAccordiXml() throws CustomException, RemoteException;*/
   String InsAccordo(Vector pvct_Tariffe, Vector pvct_Regole,Vector pvct_TariffeRif,
        int tipoTariffa,Vector pvct_Accordi,Vector pvct_InventarioProd)throws CustomException, RemoteException;
  String aggiorna_accordo(DB_Accordo accordo) throws CustomException, 
                                                     RemoteException;

  String cancella_accordo(String code_accordo) throws CustomException, 
                                                      RemoteException;

  Vector getAccordiFiltro(String codeAcco, 
                          String descAcco,
                          String codeAccount, 
                          String codeOfferta,
                          String valorizzati) throws CustomException, 
                                                  RemoteException;

Vector getAccordi(String codeOfferta) throws CustomException,RemoteException;
Vector getAccordo(String codeAcco) throws CustomException,RemoteException;                                               
int CheckAccordixOfferta(String code_offerta) throws CustomException, RemoteException;
String getServizioxAccount(String codeAccount ) throws CustomException,RemoteException;
int insINVENTARIO_PRODOTTI(DB_InventProd parPro,Connection pcls_Connection) throws CustomException, RemoteException;
int insJ2_ACCORDI_COMMERCIALI(String code_accordo,String desc_accordo,Connection pcls_Connection) throws RemoteException, CustomException;
int insJ2_ACCORDI_X_INVENTARIO(String pCODE_ACCORDO  ,String pCODE_INVENT  , String pCODE_ISTANZA_PROD ,String pATTIVO ,Connection pcls_Connection )  throws RemoteException, CustomException; 
int insJ2_ACCORDI_X_TARIFFE(String pCODE_ACCORDO ,String pCODE_TARIFFA ,String pCODE_PR_TARIFFA ,Connection pcls_Connection) throws RemoteException, CustomException;
    int insOFF_X_SERV_X_PROD(String code_offerta,
        String code_servizio,
        String code_prodotto,
        String data_inizio_valid,
        String data_fine_valid,
       Connection pcls_Connection) throws RemoteException,CustomException;
String getSequenceAccordo() throws RemoteException,CustomException;
String getSequenceTariffaStaccata() throws RemoteException, CustomException;
int  cessaAccordo(DB_Accordo objAccordi)throws CustomException, RemoteException;
void EliminaAccordo(DB_Accordo objAccordo)throws CustomException, RemoteException;
String UpdAccordo(DB_Accordo objAccordi,Vector pvct_Regole) throws CustomException, RemoteException;
Vector getOggettiFatturazione() throws CustomException, RemoteException;
String getSequenceProdottoAccordo() throws RemoteException, CustomException;
Vector getRegoleTariffa(int Code_Tariffa,int tipoTariffa)throws CustomException, RemoteException;
Vector getOfferte()throws CustomException, RemoteException;
}
