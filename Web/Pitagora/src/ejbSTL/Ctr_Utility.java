package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ctr_Utility extends EJBObject 
{
  public Vector getStatistiche_odl() throws CustomException, RemoteException;  
  public Vector getScartiFreschi() throws CustomException, RemoteException;  
  public Vector getPreServiziSpecial()throws CustomException, RemoteException;  
  public Vector getGestoriSpecial(String code_tipo_contr)throws CustomException, RemoteException;  
  public Vector getPreDisponibiliSpecial(String code_servizio, String code_accorpante)throws CustomException,RemoteException;    
  public int insAccorpamentiSpecial(String str_Servizi,String str_AccountAccorpante,String[] str_AccountAccorpati) throws CustomException, RemoteException;  
  public int insScartiFreschi(String str_flagap) throws CustomException, RemoteException;
  public Vector getScartiPopolamento(String datarif) throws CustomException, RemoteException;
  public Vector getMonitRiscontri1(String datarif) throws CustomException, RemoteException;
  public Vector getMonitRiscontri2(String datarif) throws CustomException, RemoteException;
  public Vector getMonitRiscontri3(String datarif) throws CustomException, RemoteException;
  public Vector getMonitRiscontri4(String datarif) throws CustomException, RemoteException;
  public Vector getMonitRiscontri5(String datarif) throws CustomException, RemoteException;
  public Vector getScartiVal(String datarif) throws CustomException, RemoteException;
  public Vector getAccountDup(String datarif) throws CustomException, RemoteException;
  public int insOrdiniCessazNoCodeContr(String str_Tabella,String str_Ticket,String str_datarif) throws CustomException, RemoteException;  
  public int insOrdiniCessazSiCodeContr(String str_Tabella,String str_Ticket,String str_datarif) throws CustomException, RemoteException;  
  public int lanciaStatoRisorsa(String risorsa) throws CustomException, RemoteException;  
  public Vector getAnalisiRisorsa(String risorsa) throws CustomException, RemoteException;  
  public Vector getUltimaFatt(String risorsa) throws CustomException, RemoteException;
  public Vector getUltimaNdc(String risorsa) throws CustomException, RemoteException;
  public Vector getRagSocOlo(String risorsa) throws CustomException, RemoteException;  
  public int updRagSocOlo(String codAccount,String descAccount) throws CustomException, RemoteException;  
  public ControlliPreValorizElem getControlliPreValoriz() throws CustomException, RemoteException;  
  public ControlliProgDigDivElem getControlliProgDigDiv() throws CustomException, RemoteException;  
  public Vector getAnagContrRegNow(String datarif) throws CustomException, RemoteException;
  public Vector getAnagContrXdslNow(String datarif) throws CustomException, RemoteException;
  public Vector getAnagGestRegNow(String datarif) throws CustomException, RemoteException;
  public Vector getAnagGestXdslNow(String datarif) throws CustomException, RemoteException; 
  public int annullaTutto(String codeAccount,String codeIstanza,String dataInizioFatt,String codeH3,String dataFineAcq,String tracciamento) throws CustomException, RemoteException;    
  public int annullaTuttoSingolo(String codeInventario,String codeH3,String tracciamento) throws CustomException, RemoteException;    
  public int annullaOrdine(String IdOrdCrmws,String tracciamento,String dataAcq) throws CustomException, RemoteException;    
  public int trasportoMirato(String IdOrdCrmws) throws CustomException, RemoteException;    
  public Vector getOperatoriClassic(String lista_servizi)throws CustomException, RemoteException;    
  public Vector getOperatoriSpecial(String lista_servizi)throws CustomException, RemoteException;   
  public Vector getElab_Batch_valo() throws CustomException, RemoteException;  
  public Vector getElab_Batch_flsap() throws CustomException, RemoteException;    
  public Vector getElab_Batch_cong() throws CustomException, RemoteException;  
  public Vector getTestoRepr() throws CustomException, RemoteException;
  public int truncateAnnullaOrdine() throws CustomException, RemoteException; 
  public int truncateAnnullaTutto() throws CustomException, RemoteException; 
  public int insertAnnullaOrdine(String codeOrdineCrmws,String dataAcq) throws CustomException, RemoteException; 
  public int insertAnnullaTutto(String codeInventario) throws CustomException, RemoteException;   
  public int annullaTuttoMassivo() throws CustomException, RemoteException;   
  public int annullaOrdineMassivo() throws CustomException, RemoteException;   
  public Vector getQuadratureSapClassic(String strTipoExport,String strCicloVal) throws CustomException, RemoteException; 
  public Vector getQuadratureSapSpecial(String strTipoExport,String strCicloVal) throws CustomException, RemoteException;
  public Vector getcomuniClusterByFilter(String strtipoCluster,String strcodeCluster, String istatComune, String dataIniVal, String dataFineVal) throws CustomException, RemoteException;    
  public Vector getcomuniCluster() throws CustomException, RemoteException;    
  public Vector getcodeCluster() throws CustomException, RemoteException;  
  public Vector gettipoCluster() throws CustomException, RemoteException;    
  public Vector getPeriodoRiferimento(String StoredProcedure)  throws CustomException, RemoteException;   
  public int cruscottoGuiByCodeId(String codeId) throws CustomException, RemoteException;   
  public int cruscottoGuiCountRunn(String codeFunz) throws CustomException, RemoteException;      
  public int cruscottoGuiStatus(String codeFunz) throws CustomException, RemoteException; 
  public Vector getCruscottoDett(String tipoDett)  throws CustomException, RemoteException;     
  public Vector getTimeLineRisorsa(String IdRisorsa)  throws CustomException, RemoteException;  
  public Vector getTimeLineCons(String IdRisorsa)  throws CustomException, RemoteException;  
  public TmlRisorsaDett getTmlRisorsaDett(String codeInvent) throws CustomException, RemoteException;    
  public TmlRisorsaDett getTmlUltFatt(String codeInvent) throws CustomException, RemoteException;    
  public TmlRisorsaDett getTmlUltNC(String codeInvent) throws CustomException, RemoteException;    
  public Vector getTimeLineScarti(String codeInvent)  throws CustomException, RemoteException;    
}





