package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ent_Inventari extends EJBObject 
{
  Vector getInventarioProdotti (String strCodeIstanzaProdotto )  throws CustomException, RemoteException;
  Vector getInventarioComponenti (String strCodeIstanzaProdotto )  throws CustomException, RemoteException;
  Vector getInventarioPrestazioni (String strCodeIstanzaProdotto )  throws CustomException, RemoteException;
  Vector getInventarioComponente (String strCodeIstanzaComponente ) throws CustomException, RemoteException ;
  String getDescrizioneAccount (String strCodeAccount )  throws CustomException, RemoteException;
  String getDescrizioneOfferta (String strCodeOfferta )  throws CustomException, RemoteException;
  String getDescrizioneServizio (String strCodeServizio )  throws CustomException, RemoteException;
  String getDescrizioneStato (String strCodeStato )  throws CustomException, RemoteException;
  String getDescrizioneProdotto (String strCodeProdotto ) throws CustomException, RemoteException;
  String getDescrizioneComponente (String strCodeComponente )  throws CustomException, RemoteException;
  String getDescrizioneCausale (String strCodeCausale ) throws CustomException, RemoteException;
  String getDescrizioneCiclo (String strCodeCiclo ) throws CustomException, RemoteException;
  Vector getInventarioAnagraficoATM  (String strCodeIstanzaProdotto ) throws CustomException, RemoteException;
  Vector getInventarioAnagraficoRPVD (String strCodeIstanzaProdotto ) throws CustomException, RemoteException;
  Vector getInventarioAnagraficoPP   (String strCodeIstanzaProdotto ) throws CustomException, RemoteException;
  Vector getInventarioAnagraficoMP   (String strCodeIstanzaProdotto ) throws CustomException, RemoteException;
  Vector getInventarioAnagraficoITC  (String strCodeIstanzaProdotto ) throws CustomException, RemoteException;
  Vector getInventarioAnagraficoITCREV  (String strCodeIstanzaProdotto ) throws CustomException, RemoteException;  
  Vector getServizi   ()  throws CustomException, RemoteException;
  Vector getTipoCausaliNoVariazione   ()  throws CustomException, RemoteException;
  Vector getCausali   ()  throws CustomException, RemoteException;
  Vector getOfferte (String strCodeServizio )  throws CustomException, RemoteException;
  Vector getAccount (String strCodeServizio )  throws CustomException, RemoteException;
  Vector getProdotti    (String strCodeServizio, String strCodeOfferta ) throws CustomException, RemoteException;
  Vector getComponenti  (String strCodeServizio, String strCodeOfferta, String strCodeProdotto ) throws CustomException, RemoteException;
  Vector getPrestazioniAggiuntive (String strCodeServizio, String strCodeOfferta, String strCodeProdotto, String strCodeComponente ) throws CustomException, RemoteException;
  Integer getNewSequencePreinv()     throws CustomException, RemoteException;
 
  Integer insPreinventarioProdotti (DB_PreinventarioProdotti parProd)  throws CustomException, RemoteException ;
  Integer insPreinventarioComponenti (DB_PreinventarioComponenti parCompo)  throws CustomException, RemoteException;
  Integer insPreinventarioPrestazioni (DB_PreinventarioPrestAgg parPrest)  throws CustomException, RemoteException ;
  Integer insPreinventarioPP (DB_PreinventarioPP parPP)  throws CustomException, RemoteException;
  Integer insPreinventarioMP (DB_PreinventarioMP parMP)  throws CustomException, RemoteException;
  Integer insPreinventarioRPVD (DB_PreinventarioRPVD parRPVD)  throws CustomException, RemoteException;
  Integer insPreinventarioATM (DB_PreinventarioATM parATM )  throws CustomException, RemoteException;
  Integer insPreinventarioITC (DB_PreinventarioITC parITC)  throws CustomException, RemoteException;
  Integer insPreinventarioITCREV (DB_PreinventarioITCREV parITCREV)  throws CustomException, RemoteException;
  //int inserimentoRipristino( String strCodeUtente, String strID_Evento, String strDataElaborazione)   throws CustomException, RemoteException;
  // MS 17/12/2009 int inserimentoRipristino( String strCodeUtente, String strID_Evento, String strDataElaborazione,String CodIstProd,String strSistema_Mittente)   throws CustomException, RemoteException;
  int   inserimentoRipristino( String strCodeUtente, String strID_Evento, String strDataElaborazione,String CodIstProd,String strSistema_Mittente,String strCodTipoEvento,String strNoteRettifica)  throws CustomException, RemoteException;
  int inserisciElabBatch( String strCodeFunz, String strCodeUtente, String strCodeStatoBatch )   throws CustomException, RemoteException;
  int aggiornaElabBatch( String strCodeElab, String strElemElaborati, String strElemScartati, String strScarti, String strReturnCode )  throws CustomException, RemoteException;
  String getCodeIstanzaProd (String strCodeIstanzaProd) throws CustomException, RemoteException;
  Vector getStoricoCodeIstanzaProdXRipr (String strCodeIstanzaProdotto) throws CustomException, RemoteException;
  int getCheckRipristino( String strCodeIstanzaProd) throws CustomException, RemoteException;
  int checkRettificaSuperRipr( String strCodeIstanzaProd,String strID_Evento,String strID_EventoIniz) throws CustomException, RemoteException;
  int checkCodeStatoElem( String strCodeIstanzaProd) throws CustomException, RemoteException;
  Vector getstPrenvProdxCessazione (String strCodeIstanzaProdotto )  throws CustomException, RemoteException;
  Vector getstPrenvCompoxCessazione (String strCodeIstanzaProdotto,String strCodeIstanzaCompo )  throws CustomException, RemoteException;
  Vector getstPrenvPrestAggxCessazione (String strCodeIstanzaProdotto,String strCodeIstanzaCompo,String strCodeIstanzaPrest )  throws CustomException, RemoteException;
  public int inserimentoNoteRettificaRipristino( String code_istanza_prod, String strID_Evento, String motivazione)   throws CustomException, RemoteException;
  int removepreinvent( String param) throws CustomException, RemoteException;

}
