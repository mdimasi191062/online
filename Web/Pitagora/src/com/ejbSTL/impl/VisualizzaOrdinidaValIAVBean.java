package com.ejbSTL.impl;

import com.ejbSTL.ResultRefuseIav;
import com.ejbSTL.ResultEccezioniIav;
import com.ejbSTL.ResultInventIav;
import com.ejbSTL.ResultItrfAssIav;
import com.ejbSTL.ResultItrfProvIav;
import com.ejbSTL.ResultItrfIav;

import com.ejbSTL.TypeFlussoIav;

import com.model.ValorPathModel;

import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.util.*;

import java.util.Vector;
import java.rmi.RemoteException;
import java.sql.*;
import oracle.jdbc.OracleTypes;
import com.utl.*;


public class VisualizzaOrdinidaValIAVBean extends AbstractClassicEJB implements SessionBean 
{

    private Connection conn=null;
    private CallableStatement cs = null;
    private PreparedStatement ps = null;
    private ResultSet rs=null;
    
    private static final String queryGetAllFlusso = "SELECT TP.ID_FLUSSO, TP.TIPO_FLUSSO, TP.DESCRIPTION FROM I5_5IAV_TIPI_FLUSSO TP WHERE TP.AMBITO != 'Error' ";  
    
    private static final String queryGetFluxFromCode = "SELECT DESCRIPTION FROM I5_5IAV_TIPI_FLUSSO  ";  
    private static final String queryAnagraficaBatch = "SELECT D.DESC_FUNZ, D.TIPO_FUNZ, D.PATH_REPORT, D.PATH_REPORT_STORICI, D.ESTENSIONE_FILE, D.ESTENSIONE_FILE_STORICO, D.PATH_FILE_ZIP" + 
    " FROM i5_6sys_report_download D";
    
    private static final String queryGetAllServizi = "SELECT DISTINCT S.CODE_SERVIZIO, S.DESCRIZIONE_SERVIZIO FROM I5_5IAV_SERVIZI S ORDER BY lpad(S.CODE_SERVIZIO,4) ASC "; 
    private static final String queryGetAllOperatori = "SELECT DISTINCT O.CODE_GEST, O.DESCRIZIONE_OLO FROM I5_5IAV_TRASCOD_OPERATORE O ORDER BY O.CODE_GEST ASC ";  
    
    
    private String tableName = null;
    private String tableName_err = null;

 public void ejbCreate()
  {
  }

  public void ejbActivate()
  {
  }

  public void ejbPassivate()
  {
  }

  public void ejbRemove()
  {
  }

  public void setSessionContext(SessionContext ctx)
  {
  }
  
    

    
    
    public Vector<ResultInventIav> getTableFromFluxCode(String operatoreIav, String serviziIav, String fatturazioneIav) throws SQLException,RemoteException{
            Vector<ResultInventIav> result = new Vector<ResultInventIav>();
            
            tableName = null;
            tableName_err = null;
            
            tableName = "I5_1INVENT_PS_XDSL";
        
             result = getInventQuery(operatoreIav, serviziIav, fatturazioneIav);
                             
            
            return result;   
        }
       
     
    public Vector<ResultInventIav> getTableFromFluxCode2(String operatoreIav, String ambitoIav, String statoOrdiniIav) throws SQLException,RemoteException{
            Vector<ResultInventIav> result = new Vector<ResultInventIav>();
            
            tableName = null;
            tableName_err = null;
            
            tableName = "I5_1INVENT_PS_XDSL";
        
             result = getInventQuery2(operatoreIav, ambitoIav, statoOrdiniIav);
                             
            
            return result;   
        }
        
        
    public Vector<ResultInventIav> getInventQuery(String operatoreIav, String serviziIav, String fatturazioneIav) throws SQLException,
                                                                                 RemoteException {
        
        Vector<ResultInventIav> result = new Vector<ResultInventIav>();
        
        System.out.println(fatturazioneIav);
        
        String dateString = fatturazioneIav;
        String[] dates = dateString.split(",");
        String date1 = dates[0]/*+" 00:00:00"*/;
        String date2 = dates[1]/*+" 23:59:59"*/;

        String queryInventWhere1="";
        String queryInventWhere2="";
        
        String queryInventWithInput=
        "select "+
        "s.descrizione_servizio,inv.CODE_ACCOUNT,CONT.CODE_TIPO_CONTR,"+
        "min(inv.data_dro) as minData, max(inv.data_dro) as maxData, count(*) as countRow"+
        " from i5_5itfr_fat_iav_ass itrf"+
        " inner join I5_1invent_ps_xdsl inv on itrf.code_itrf_fat_xdsl = inv.code_itrf_fat_xdsl"+
        " inner join i5_5iav_servizi s on s.code_servizio=itrf.servizio_iav"+
        " INNER JOIN I5_5IAV_TRAS_CONTRATTI CONT on s.CODE_TIPO_CONTR=CONT.CODE_TIPO_CONTR"+
        " where inv.DATA_FINE_FATRZ IS NULL"+
        " AND inv.DATA_INIZIO_FATRZ >= TO_DATE('" + date1 + "', 'DD/MM/YYYY')";
        
        if(serviziIav.equals("TUTTI"))
            queryInventWhere1="";
        else
            queryInventWhere1=" and s.code_servizio ='"+serviziIav +"'";
            
        if(operatoreIav.equals("TUTTI"))
            queryInventWhere2="";
        else
            queryInventWhere2= " and CONT.CODE_GEST ='"+operatoreIav +"'";
        
           
        String queryGroupBy=" group by s.descrizione_servizio,inv.CODE_ACCOUNT,CONT.CODE_TIPO_CONTR";
        
        String queryToDo=queryInventWithInput+queryInventWhere1+queryInventWhere2+queryGroupBy;

        System.out.println(queryToDo);
        
         try{
           
           conn = getConnection(dsName);               
           ps = conn.prepareStatement(queryToDo);          
           rs = ps.executeQuery();            
           
               while (rs!=null && rs.next()) 
               {  
                   ResultInventIav resultInventIav = new ResultInventIav();
                   
                   String descServizio = rs.getString("descrizione_servizio");
                   String minData = rs.getString("minData");
                   String maxData = rs.getString("maxData");
                   String countRow = rs.getString("countRow");
                   String code_invent = rs.getString("CODE_ACCOUNT");
                   String code_tipo_contr = rs.getString("CODE_TIPO_CONTR");
                                  
                   resultInventIav.setFlowName(descServizio);
                   resultInventIav.setCODE_LOTTO(minData);
                   resultInventIav.setCODE_ISTANZA_OLD(maxData);
                   resultInventIav.setID_TRASPORTO(countRow);
                   resultInventIav.setCODE_INVENT(code_invent);
                   resultInventIav.setCODE_TIPO_CONTR(code_tipo_contr);

                   result.add(resultInventIav);                  
               }  
           
           
           }catch(SQLException e){
               System.out.println (e.getMessage());
               e.printStackTrace();
               closeConnection();
           }  finally{
                 closeConnection();
             }
        
        System.out.println(result.size());
        
        return result;
    } 

    public Vector<ResultInventIav> getInventQuery2(String operatoreIav, String ambitoIav, String statoOrdiniIav) throws SQLException,
                                                                                 RemoteException {
      //alf  
        Vector<ResultInventIav> result = new Vector<ResultInventIav>();
        
        String queryInventWhere1="";
        String queryInventWhere2="";
        String queryInventWhere3="";
        
        if(operatoreIav.equals("%"))
            queryInventWhere1="";
        else
            queryInventWhere1=" AND itrf.CODE_GEST = '"+operatoreIav +"' ";
            
        if(ambitoIav.equals("%"))
            queryInventWhere2="";
        else
            queryInventWhere2= " AND tf.TIPO_FLUSSO like '"+ambitoIav +"' ";
            
        queryInventWhere3= " AND itrf.TIPO_FLAG_ACQ_RICH in ("+statoOrdiniIav +") ";
            
            
        String queryInventWithInput=
        "select count(*) as conteggio , to_char(min(itrf.DATA_ACQ_CHIUS),'dd/mm/yyyy') as data_min, to_char(max(itrf.DATA_ACQ_CHIUS),'dd/mm/yyyy') as data_max,tf.AMBITO as ambito "+
        "from i5_5itfr_fat_iav_ass itrf, I5_5IAV_TRAS_CONTRATTI CONT, i5_5iav_servizi s, I5_5IAV_TIPI_FLUSSO tf, I5_1ACCOUNT_X_CONTR ac, I5_2PARAM_VALORIZ_SP pv, i5_1invent_ps_xdsl inv "+
        "where CONT.CODE_CONTR = itrf.code_contr "+
        "AND s.CODE_TIPO_CONTR = CONT.CODE_TIPO_CONTR "+
        "AND tf.ID_FLUSSO = itrf.ID_FLUSSO "+
        "AND itrf.CODE_GEST = CONT.CODE_GEST (+) "+
        "AND ac.CODE_CONTR (+) = itrf.CODE_CONTR "+
        "AND pv.CODE_ACCOUNT (+) = ac.CODE_ACCOUNT "+
        "AND inv.CODE_ITRF_FAT_XDSL = itrf.CODE_ITRF_FAT_XDSL "+
        "AND (inv.DATA_ULTIMA_FATRZ is null OR inv.DATA_ULTIMA_FATRZ >= pv.DATA_INIZIO_CICLO_FATRZ) "+
        "AND inv.CODE_TIPO_CONTR = CONT.CODE_TIPO_CONTR "+
        "AND pv.CODE_ACCOUNT = inv.CODE_ACCOUNT "+
        "AND itrf.DESC_ID_RISORSA = inv.CODE_ISTANZA_PS "+
        "AND pv.TIPO_FLAG_STATO_CONG = 'N' "+
        queryInventWhere1 + 
        queryInventWhere2 + 
        queryInventWhere3 +
        "group by tf.AMBITO "+
        "UNION ALL "+
        "select count(*) as conteggio , to_char(min(itrf.DATA_ACQ_CHIUS),'dd/mm/yyyy') as data_min, to_char(max(itrf.DATA_ACQ_CHIUS),'dd/mm/yyyy') as data_max, tf.AMBITO || ' ' || substr(tf.TIPO_FLUSSO, -3) as ambito  "+
        "from i5_5itfr_fat_iav_prov itrf, I5_5IAV_TRAS_CONTRATTI CONT, i5_5iav_servizi s, I5_5IAV_TIPI_FLUSSO tf, I5_1ACCOUNT_X_CONTR ac, I5_2PARAM_VALORIZ_SP pv, i5_1invent_ps_xdsl inv "+
        "where CONT.CODE_CONTR = itrf.code_contr "+
        "AND s.CODE_TIPO_CONTR = CONT.CODE_TIPO_CONTR "+
        "AND tf.ID_FLUSSO = itrf.ID_FLUSSO "+
        "AND itrf.CODE_GEST = CONT.CODE_GEST (+) "+
        "AND ac.CODE_CONTR (+) = itrf.CODE_CONTR "+
        "AND pv.CODE_ACCOUNT (+) = ac.CODE_ACCOUNT "+
        "AND inv.CODE_ITRF_FAT_XDSL = itrf.CODE_ITRF_FAT_XDSL "+
        "AND (inv.DATA_ULTIMA_FATRZ is null OR inv.DATA_ULTIMA_FATRZ >= pv.DATA_INIZIO_CICLO_FATRZ) "+
        "AND inv.CODE_TIPO_CONTR = CONT.CODE_TIPO_CONTR "+
        "AND pv.CODE_ACCOUNT = inv.CODE_ACCOUNT "+
        "AND itrf.DESC_ID_RISORSA = inv.CODE_ISTANZA_PS "+
        "AND pv.TIPO_FLAG_STATO_CONG = 'N' "+
        queryInventWhere1 + 
        queryInventWhere2 + 
        queryInventWhere3 + 
        "group by tf.AMBITO || ' ' || substr(tf.TIPO_FLUSSO, -3) "+
        "UNION ALL "+
        "select count(*) as conteggio , to_char(min(itrf.DATA_ACQ_CHIUS),'dd/mm/yyyy') as data_min, to_char(max(itrf.DATA_ACQ_CHIUS),'dd/mm/yyyy') as data_max, tf.AMBITO || ' ' || substr(tf.TIPO_FLUSSO, -3) as ambito  "+
        "from i5_5itfr_fat_iav_prov_opera itrf, I5_5IAV_TRAS_CONTRATTI CONT, i5_5iav_servizi s, I5_5IAV_TIPI_FLUSSO tf, I5_1ACCOUNT_X_CONTR ac, I5_2PARAM_VALORIZ_SP pv, i5_1invent_ps_xdsl inv "+
        "where CONT.CODE_CONTR = itrf.code_contr "+
        "AND s.CODE_TIPO_CONTR = CONT.CODE_TIPO_CONTR "+
        "AND tf.ID_FLUSSO = itrf.ID_FLUSSO "+
        "AND itrf.CODE_GEST = CONT.CODE_GEST (+) "+
        "AND ac.CODE_CONTR (+) = itrf.CODE_CONTR "+
        "AND pv.CODE_ACCOUNT (+) = ac.CODE_ACCOUNT "+
        "AND inv.CODE_ITRF_FAT_XDSL = itrf.CODE_ITRF_FAT_XDSL "+
        "AND (inv.DATA_ULTIMA_FATRZ is null OR inv.DATA_ULTIMA_FATRZ >= pv.DATA_INIZIO_CICLO_FATRZ) "+
        "AND inv.CODE_TIPO_CONTR = CONT.CODE_TIPO_CONTR "+
        "AND pv.CODE_ACCOUNT = inv.CODE_ACCOUNT "+
        "AND itrf.DESC_ID_RISORSA = inv.CODE_ISTANZA_PS "+
        "AND pv.TIPO_FLAG_STATO_CONG = 'N' "+
        queryInventWhere1 + 
        queryInventWhere2 + 
        queryInventWhere3 + 
        "group by tf.AMBITO || ' ' || substr(tf.TIPO_FLUSSO, -3) ";
        
        String queryToDo=queryInventWithInput;

        System.out.println(queryToDo);
        
         try{
           
           conn = getConnection(dsName);               
           ps = conn.prepareStatement(queryToDo);          
           rs = ps.executeQuery();            
           
               while (rs!=null && rs.next()) 
               {  
                   ResultInventIav resultInventIav = new ResultInventIav();
                   
                   String descServizio = rs.getString("ambito");
                   String minData = rs.getString("data_min");
                   String maxData = rs.getString("data_max");
                   String countRow = rs.getString("conteggio");

                                  
                   resultInventIav.setFlowName(descServizio);
                   resultInventIav.setCODE_LOTTO(minData);
                   resultInventIav.setCODE_ISTANZA_OLD(maxData);
                   resultInventIav.setID_TRASPORTO(countRow);

                   result.add(resultInventIav);                  
               }  
           
           
           }catch(SQLException e){
               System.out.println (e.getMessage());
               e.printStackTrace();
               closeConnection();
           }  finally{
                 closeConnection();
             }
        
        System.out.println(result.size());
        
        return result;
    } 
 
  
  public String getNameFluxFromCode(String code) throws SQLException,
                                                          RemoteException {
                                                          
        String name = "";
                                                          
      try{
        
        conn = getConnection(dsName);
        
        String concatQuery = "'"+ code + "'";
        
        System.out.println(queryGetFluxFromCode + concatQuery);
        
          ps = conn.prepareStatement(queryGetFluxFromCode + concatQuery);
          
          rs = ps.executeQuery();
          
          while(rs.next()) {
            name = rs.getString(1);
          }
        
      }catch(SQLException e){
              System.out.println (e.getMessage());
              e.printStackTrace();
              closeConnection();
          }  finally{
                closeConnection();
            }
            
            return name;
  }
  
    public Vector<ResultInventIav> getAllFieldsFromCodeInvent(String codeInvent, String operatoreIav, String serviziIav, String fatturazioneIav) throws SQLException,
                                                                                   RemoteException {
          
          Vector<ResultInventIav> result = new Vector<ResultInventIav>();
          
          tableName = "I5_1INVENT_PS_XDSL";

          
          result = getInventQueryAllFields(codeInvent,operatoreIav, serviziIav, fatturazioneIav);
           
                
          return result;
      }

    public Vector<ResultItrfIav> getAllFieldsFromCodeInvent2(String codeInvent, String operatoreIav, String ambitoIav, String statoOrdiniIav) throws SQLException,
                                                                                   RemoteException {
          
          Vector<ResultItrfIav> result = new Vector<ResultItrfIav>();
          
          tableName = "I5_1INVENT_PS_XDSL";

          
          result = getInventQueryAllFields2(codeInvent,operatoreIav, statoOrdiniIav);
           
                
          return result;
      }      
      
    public Vector<ResultInventIav> getInventQueryAllFields(String codeInvent,String operatoreIav, String serviziIav, String fatturazioneIav) throws SQLException,
                                                                          RemoteException {
              
            Vector<ResultInventIav> results = new Vector<ResultInventIav>();

            String dateString = codeInvent;
            String[] dates = dateString.split(",");
            String date1 = dates[0]/*+" 00:00:00"*/;
            String date2 = dates[1]/*+" 23:59:59"*/;

               try{
                   
                   conn = getConnection(dsName);
                   
                   
                   String nomeFile = codeInvent.trim() + ".csv";
                   
                   String columns = 
                   "CODE_INVENT, CODE_TIPO_CAUS, CODE_ACCOUNT, CODE_CAUS_ORD, CODE_STATO_PS, CODE_TIPO_OFF, CODE_TIPO_CAUS_VARIAZ, CODE_PS, "+
                   "CODE_TIPO_CONTR, DATA_DRO,DATA_DVTC, DATA_INIZIO_VALID, CODE_ISTANZA_PS, DATA_FINE_VALID, DATA_INIZIO_FATRZ, DATA_ULTIMA_FATRZ, " +
                   "DATA_FINE_NOL, DATA_CESS, DATA_VARIAZ, DATA_FINE_FATRZ, DATA_FATRB, QNTA_VALO, DATA_ULTIMA_APPL_CANONI, CODE_UTENTE_CREAZ, DATA_CREAZ, "+ 
                   "CODE_UTENTE_MODIF, DATA_MODIF, NUM_VARIAZ, CODE_PS_FATT_PRINC, CODE_AREA_RACCOLTA, CODE_NUM_TD, CODE_LOTTO, CODE_PS_OLD, "+
                   "CODE_ISTANZA_OLD, TIPO_CONTR_OLD, TIPO_FLAG_PROMOZ, DESC_CODE_VPI , VALO_MCR, ID_TRASPORTO, FLAG_TRASPORTO, ID_BANDA, VALO_PCR_BANDA, "+
                   "FLAG_SYS, ID_ACCESSO, ID_VC, QNTA_VALO_OLD, TIPO_PROVENIENZA , OPZ_CONTRATTUALE , VALO_PCR_UP, UTENZA_RIF, CODE_OL, TIPO_SLA_PLUS, "+
                   "OFFERTA_SLA_PLUS, COPERTURA_ORARIA, FLAG_DISP, OPZ_COMM, TIPO_MODULAZ, MOD_ACCESSO, TIPO_VALID, CODICE_PROGETTO, TIPO_MOD_FAT, "+
                   "DATA_INIZIO_NOL, CODE_TIPO_PREST, FLAG_ESITO_PREQ,BANDA_VL, CODE_CLLI, CODE_ID_ULLCO, CODE_COMUNE, CODE_DISTR, VALO_MCR_UP, "+
                   "ID_RIS_OLD, PROFILO_ACCESSO, MOD_VENDITA , FLAG_MODEM, TIPO_FAMIGLIA, MOD_FATTURAZIONE, MOD_FATTURAZIONE_TRASP, CODE_PROFILO_ESTESO, "+
                   "FLAG_LINEA_NUM_AGG, CLASS_SERV, CODE_MACRO_AREA, CODE_IDBRE_DSLAM, FLAG_NUOVO_FEEDER, COUNT_FEEDER, CODICE_PROGETTO_BILL, "+
                   "CODICE_QUALITA, CODICE_DELIVERY, CAMPO_SERV_IT, FLAG_MONITORAGGIO, TECNOLOGIA, ID_ORD_CRMWS, CODE_ITRF_FAT_XDSL, ID_CVLAN, "+
                   "CODE_TIPO_CAUS_VARIAZ_CONG, CODE_SUPER_MACRO_AREA, FLAG_LA, INSTALLAZIONE, ID_MTCO, CONNETTORE_MTCO, COD_TOPONOMASTICA, "+
                   "FLAG_4REFERENTE, TIPO_CPE, FLAG_INTERVENTO, CODE_HOSTING, TECNOLOGIA_FIBRA, FLAG_QUALIFICA, FLAG_TEST2, TIPO_CLUSTER, CODE_CLUSTER";
                   
                   String query = "SELECT " + columns + " FROM " + tableName +" WHERE CODE_ACCOUNT = '" + date1 + "' AND CODE_TIPO_CONTR = '" + date2 + "'";
                   
                   System.out.println(query);
                   
                   ps = conn.prepareStatement(query);
                   
                   rs = ps.executeQuery();

                   
                   while(rs.next()) {
                             ResultInventIav result =  new ResultInventIav();
                             
                             /*String nameFile = rs.getString("NOME_FILE");
                             String[] partsOfNameFile = null;
                             
                             result.setNameFile(nameFile != null ? nameFile : null);
                             result.setNameFlow(nameFile.replace(".csv", " "));//partsOfNameFile[0] != null ? partsOfNameFile[0] : null );  */ 
                             
                             result.setCODE_INVENT(rs.getString("CODE_INVENT"));
                             result.setCODE_TIPO_CAUS(rs.getString("CODE_TIPO_CAUS"));
                             result.setCODE_ACCOUNT(rs.getString("CODE_ACCOUNT"));
                             result.setCODE_CAUS_ORD(rs.getString("CODE_CAUS_ORD"));
                             result.setCODE_STATO_PS(rs.getString("CODE_STATO_PS"));
                             result.setCODE_TIPO_OFF(rs.getString("CODE_TIPO_OFF"));
                             result.setCODE_TIPO_CAUS_VARIAZ(rs.getString("CODE_TIPO_CAUS_VARIAZ"));
                             result.setCODE_PS(rs.getString("CODE_PS"));
                             result.setCODE_TIPO_CONTR(rs.getString("CODE_TIPO_CONTR"));
                             result.setDATA_DRO(rs.getString("DATA_DRO"));
                             result.setDATA_DVTC(rs.getString("DATA_DVTC"));
                             result.setDATA_INIZIO_VALID(rs.getString("DATA_INIZIO_VALID"));
                             result.setCODE_ISTANZA_PS(rs.getString("CODE_ISTANZA_PS"));
                             result.setDATA_FINE_VALID(rs.getString("DATA_FINE_VALID"));
                             result.setDATA_INIZIO_FATRZ(rs.getString("DATA_INIZIO_FATRZ"));
                             result.setDATA_ULTIMA_FATRZ(rs.getString("DATA_ULTIMA_FATRZ"));
                             result.setDATA_FINE_NOL(rs.getString("DATA_FINE_NOL"));
                             result.setDATA_CESS(rs.getString("DATA_CESS"));
                             result.setDATA_VARIAZ(rs.getString("DATA_VARIAZ"));
                             result.setDATA_FINE_FATRZ(rs.getString("DATA_FINE_FATRZ"));
                             result.setDATA_FATRB(rs.getString("DATA_FATRB"));
                             result.setQNTA_VALO(rs.getString("QNTA_VALO"));
                             result.setDATA_ULTIMA_APPL_CANONI(rs.getString("DATA_ULTIMA_APPL_CANONI"));
                             result.setCODE_UTENTE_CREAZ(rs.getString("CODE_UTENTE_CREAZ"));
                             result.setDATA_CREAZ(rs.getString("DATA_CREAZ"));
                             result.setCODE_UTENTE_MODIF(rs.getString("CODE_UTENTE_MODIF"));
                             result.setDATA_MODIF(rs.getString("DATA_MODIF"));
                             result.setNUM_VARIAZ(rs.getString("NUM_VARIAZ"));
                             result.setCODE_PS_FATT_PRINC(rs.getString("CODE_PS_FATT_PRINC"));
                             result.setCODE_AREA_RACCOLTA(rs.getString("CODE_AREA_RACCOLTA"));
                             result.setCODE_NUM_TD(rs.getString("CODE_NUM_TD"));
                             result.setCODE_LOTTO(rs.getString("CODE_LOTTO"));
                             result.setCODE_PS_OLD(rs.getString("CODE_PS_OLD"));
                             result.setCODE_ISTANZA_OLD(rs.getString("CODE_ISTANZA_OLD"));
                             result.setTIPO_CONTR_OLD(rs.getString("TIPO_CONTR_OLD"));
                             result.setTIPO_FLAG_PROMOZ(rs.getString("TIPO_FLAG_PROMOZ"));
                             result.setDESC_CODE_VPI(rs.getString("DESC_CODE_VPI"));
                             result.setVALO_MCR(rs.getString("VALO_MCR"));
                             result.setID_TRASPORTO(rs.getString("ID_TRASPORTO"));
                             result.setFLAG_TRASPORTO(rs.getString("FLAG_TRASPORTO"));
                             result.setID_BANDA(rs.getString("ID_BANDA"));
                             result.setVALO_PCR_BANDA(rs.getString("VALO_PCR_BANDA"));
                             result.setFLAG_SYS(rs.getString("FLAG_SYS"));
                             result.setID_ACCESSO(rs.getString("ID_ACCESSO"));
                             result.setID_VC(rs.getString("ID_VC"));
                             result.setQNTA_VALO_OLD(rs.getString("QNTA_VALO_OLD"));
                             result.setTIPO_PROVENIENZA(rs.getString("TIPO_PROVENIENZA"));
                             result.setOPZ_CONTRATTUALE(rs.getString("OPZ_CONTRATTUALE"));
                             result.setVALO_PCR_UP(rs.getString("VALO_PCR_UP"));
                             result.setUTENZA_RIF(rs.getString("UTENZA_RIF"));
                             result.setCODE_OL(rs.getString("CODE_OL"));
                             result.setTIPO_SLA_PLUS(rs.getString("TIPO_SLA_PLUS"));
                             result.setOFFERTA_SLA_PLUS(rs.getString("OFFERTA_SLA_PLUS"));
                             result.setCOPERTURA_ORARIA(rs.getString("COPERTURA_ORARIA"));
                             result.setFLAG_DISP(rs.getString("FLAG_DISP"));
                             result.setOPZ_COMM(rs.getString("OPZ_COMM"));
                             result.setTIPO_MODULAZ(rs.getString("TIPO_MODULAZ"));
                             result.setMOD_ACCESSO(rs.getString("MOD_ACCESSO"));
                             result.setTIPO_VALID(rs.getString("TIPO_VALID"));
                             result.setCODICE_PROGETTO(rs.getString("CODICE_PROGETTO"));
                             result.setTIPO_MOD_FAT(rs.getString("TIPO_MOD_FAT"));
                             result.setDATA_INIZIO_NOL(rs.getString("DATA_INIZIO_NOL"));
                             result.setCODE_TIPO_PREST(rs.getString("CODE_TIPO_PREST"));
                             result.setFLAG_ESITO_PREQ(rs.getString("FLAG_ESITO_PREQ"));
                             result.setBANDA_VL(rs.getString("BANDA_VL"));
                             result.setCODE_CLLI(rs.getString("CODE_CLLI"));
                             result.setCODE_ID_ULLCO(rs.getString("CODE_ID_ULLCO"));
                             result.setCODE_COMUNE(rs.getString("CODE_COMUNE"));
                             result.setCODE_DISTR(rs.getString("CODE_DISTR"));
                             result.setVALO_MCR_UP(rs.getString("VALO_MCR_UP"));
                             result.setID_RIS_OLD(rs.getString("ID_RIS_OLD"));
                             result.setPROFILO_ACCESSO(rs.getString("PROFILO_ACCESSO"));
                             result.setMOD_VENDITA(rs.getString("MOD_VENDITA"));
                             result.setFLAG_MODEM(rs.getString("FLAG_MODEM"));
                             result.setTIPO_FAMIGLIA(rs.getString("TIPO_FAMIGLIA"));
                             result.setMOD_FATTURAZIONE(rs.getString("MOD_FATTURAZIONE"));
                             result.setMOD_FATTURAZIONE_TRASP(rs.getString("MOD_FATTURAZIONE_TRASP"));
                             result.setCODE_PROFILO_ESTESO(rs.getString("CODE_PROFILO_ESTESO"));
                             result.setFLAG_LINEA_NUM_AGG(rs.getString("FLAG_LINEA_NUM_AGG"));
                             result.setCLASS_SERV(rs.getString("CLASS_SERV"));
                             result.setCODE_MACRO_AREA(rs.getString("CODE_MACRO_AREA"));
                             result.setCODE_IDBRE_DSLAM(rs.getString("CODE_IDBRE_DSLAM"));                     
                             result.setFLAG_NUOVO_FEEDER(rs.getString("FLAG_NUOVO_FEEDER"));
                             result.setCOUNT_FEEDER(rs.getString("COUNT_FEEDER"));
                             result.setCODICE_PROGETTO_BILL(rs.getString("CODICE_PROGETTO_BILL"));
                             result.setCODICE_QUALITA(rs.getString("CODICE_QUALITA"));
                             result.setCODICE_DELIVERY(rs.getString("CODICE_DELIVERY"));
                             result.setCAMPO_SERV_IT(rs.getString("CAMPO_SERV_IT"));
                             result.setFLAG_MONITORAGGIO(rs.getString("FLAG_MONITORAGGIO"));
                             result.setTECNOLOGIA(rs.getString("TECNOLOGIA"));
                             result.setID_ORD_CRMWS(rs.getString("ID_ORD_CRMWS"));
                             result.setCODE_ITRF_FAT_XDSL(rs.getString("CODE_ITRF_FAT_XDSL"));
                             result.setID_CVLAN(rs.getString("ID_CVLAN"));
                             result.setCODE_TIPO_CAUS_VARIAZ_CONG(rs.getString("CODE_TIPO_CAUS_VARIAZ_CONG"));
                             result.setCODE_SUPER_MACRO_AREA(rs.getString("CODE_SUPER_MACRO_AREA"));
                             result.setFLAG_LA(rs.getString("FLAG_LA"));
                             result.setINSTALLAZIONE(rs.getString("INSTALLAZIONE"));
                             result.setID_MTCO(rs.getString("ID_MTCO"));
                             result.setCONNETTORE_MTCO(rs.getString("CONNETTORE_MTCO"));
                             result.setCOD_TOPONOMASTICA(rs.getString("COD_TOPONOMASTICA"));
                             result.setFLAG_4REFERENTE(rs.getString("FLAG_4REFERENTE"));
                             result.setTIPO_CPE(rs.getString("TIPO_CPE"));
                             result.setFLAG_INTERVENTO(rs.getString("FLAG_INTERVENTO"));
                             result.setCODE_HOSTING(rs.getString("CODE_HOSTING"));
                             result.setTECNOLOGIA_FIBRA(rs.getString("TECNOLOGIA_FIBRA"));
                             result.setFLAG_QUALIFICA(rs.getString("FLAG_QUALIFICA"));
                             result.setFLAG_TEST2(rs.getString("FLAG_TEST2"));
                             result.setTIPO_CLUSTER(rs.getString("TIPO_CLUSTER"));
                             result.setCODE_CLUSTER(rs.getString("CODE_CLUSTER"));

                             
                              results.add(result);
                     } 
                     
                                         
                   
               }catch(SQLException e){
                   System.out.println (e.getMessage());
                   e.printStackTrace();
                   closeConnection();
               }  finally{
                     closeConnection();
                 }
                 
            return results;

    }
 
    private String isNull(String input) {
        if ( input != null) {
            return input;
        }
        return "";
    }
    
    public Vector<ResultItrfIav> getInventQueryAllFields2(String codeInvent,String operatoreIav, String statoOrdiniIav) throws SQLException,
                                                                          RemoteException {
              
            //alfVector<ResultInventIav> results = new Vector<ResultInventIav>();
           Vector<ResultItrfIav> results = new Vector<ResultItrfIav>();
           String ambitoIav = "%";
           if (codeInvent.toUpperCase().contains("ASSU")) {
               ambitoIav = "ASS%";
           } else if (codeInvent.toUpperCase().contains("PROVI") && codeInvent.toUpperCase().contains("BTS")) {
               ambitoIav = "IFV_BTS";
           } else if (codeInvent.toUpperCase().contains("PROVI") && codeInvent.toUpperCase().contains("ULL")) {
               ambitoIav = "IFV_ULL";
           } else if (codeInvent.toUpperCase().contains("PROVI") && codeInvent.toUpperCase().contains("WLR")) {
               ambitoIav = "IFV_WLR";
           } else if (codeInvent.toUpperCase().contains("PROVI") && codeInvent.length() > 3 && codeInvent.toUpperCase().substring(codeInvent.length()-3).equalsIgnoreCase("PRO")) {
               ambitoIav = "IFV_PRO";
           }
           
           
               try{
                   
                   conn = getConnection(dsName);
                   
                   
                   String nomeFile = codeInvent.trim() + ".csv";
                   
                  /*ALF String columns = 
                   "NOME_FILE, DATA_ACQ_CHIUS, CODE_INVENT, CODE_TIPO_CAUS, CODE_ACCOUNT, CODE_CAUS_ORD, CODE_STATO_PS, CODE_TIPO_OFF, CODE_TIPO_CAUS_VARIAZ, CODE_PS, "+
                   "CODE_TIPO_CONTR, DATA_DRO,DATA_DVTC, DATA_INIZIO_VALID, CODE_ISTANZA_PS, DATA_FINE_VALID, DATA_INIZIO_FATRZ, DATA_ULTIMA_FATRZ, " +
                   "DATA_FINE_NOL, DATA_CESS, DATA_VARIAZ, DATA_FINE_FATRZ, DATA_FATRB, QNTA_VALO, DATA_ULTIMA_APPL_CANONI, CODE_UTENTE_CREAZ, DATA_CREAZ, "+ 
                   "CODE_UTENTE_MODIF, DATA_MODIF, NUM_VARIAZ, CODE_PS_FATT_PRINC, CODE_AREA_RACCOLTA, CODE_NUM_TD, CODE_LOTTO, CODE_PS_OLD, "+
                   "CODE_ISTANZA_OLD, TIPO_CONTR_OLD, TIPO_FLAG_PROMOZ, DESC_CODE_VPI , VALO_MCR, ID_TRASPORTO, FLAG_TRASPORTO, ID_BANDA, VALO_PCR_BANDA, "+
                   "FLAG_SYS, ID_ACCESSO, ID_VC, QNTA_VALO_OLD, TIPO_PROVENIENZA , OPZ_CONTRATTUALE , VALO_PCR_UP, UTENZA_RIF, CODE_OL, TIPO_SLA_PLUS, "+
                   "OFFERTA_SLA_PLUS, COPERTURA_ORARIA, FLAG_DISP, OPZ_COMM, TIPO_MODULAZ, MOD_ACCESSO, TIPO_VALID, CODICE_PROGETTO, TIPO_MOD_FAT, "+
                   "DATA_INIZIO_NOL, CODE_TIPO_PREST, FLAG_ESITO_PREQ,BANDA_VL, CODE_CLLI, CODE_ID_ULLCO, CODE_COMUNE, CODE_DISTR, VALO_MCR_UP, "+
                   "ID_RIS_OLD, PROFILO_ACCESSO, MOD_VENDITA , FLAG_MODEM, TIPO_FAMIGLIA, MOD_FATTURAZIONE, MOD_FATTURAZIONE_TRASP, CODE_PROFILO_ESTESO, "+
                   "FLAG_LINEA_NUM_AGG, CLASS_SERV, CODE_MACRO_AREA, CODE_IDBRE_DSLAM, FLAG_NUOVO_FEEDER, COUNT_FEEDER, CODICE_PROGETTO_BILL, "+
                   "CODICE_QUALITA, CODICE_DELIVERY, CAMPO_SERV_IT, FLAG_MONITORAGGIO, TECNOLOGIA, ID_ORD_CRMWS, CODE_ITRF_FAT_XDSL, ID_CVLAN, "+
                   "CODE_TIPO_CAUS_VARIAZ_CONG, CODE_SUPER_MACRO_AREA, FLAG_LA, INSTALLAZIONE, ID_MTCO, CONNETTORE_MTCO, COD_TOPONOMASTICA, "+
                   "FLAG_4REFERENTE, TIPO_CPE, FLAG_INTERVENTO, CODE_HOSTING, TECNOLOGIA_FIBRA, FLAG_QUALIFICA, FLAG_TEST2, TIPO_CLUSTER, CODE_CLUSTER, TIPO_FLAG_ACQ_RICH";
*/
                   String columns = "";
                   if (codeInvent.toUpperCase().contains("ASSU")) {
                        //columns = "Y.NOME_FILE, Y.CODE_ITRF_FAT_XDSL, Y.DATA_ACQ_CHIUS, Y.IDENTIFICATIVOTT, Y.ID_IDENTIFICATIVO_TT, Y.TIPOSERVIZIO, Y.SERVIZIO_EROGATO, Y.TIPOTICKETOLO, "+
                         columns = "Y.NOME_FILE, Y.DATA_ACQ_CHIUS, Y.IDENTIFICATIVOTT, Y.ID_IDENTIFICATIVO_TT, Y.TIPOSERVIZIO, Y.SERVIZIO_EROGATO, Y.TIPOTICKETOLO, "+
                        "Y.OGGETTO_SEGNALATO, Y.RISCONTRO, Y.DATAORAINIZIOSEGN, Y.DATAORAFINEDISSERVIZIO, Y.CHIUSURATT_TTMWEB, Y.NOMEOLO, Y.CODICEFONTE, Y.DESCCAUSACHIUSURAOLO, Y.CLASSIFICAZIONE_TECNICA, "+
                        "Y.COMPETENZA_CHIUSURA, Y.ANNO_CHIUSURA, Y.MESE_CHIUSURA, Y.RISCONTRATI_AUTORIPR, Y.REMOTO_ON_FIELD, Y.CODICE_IMPRESA, Y.DESCRIZIONE_IMPRESA, Y.ADDR_CIRCUITINFO, Y.ADDR_CUST, Y.LOCATIONDESC, "+
                        "Y.TECHASSIGNED, Y.DATA_CREAZIONE_WR, Y.CODE_GEST, Y.SERVIZIO_IAV, Y.DATA_DRO, Y.CODE_CONTR, Y.CODE_PS_FATT, Y.TIPO_FLAG_ACQ_RICH";
                   }
                 
                   if (codeInvent.toUpperCase().contains("PROVI") && codeInvent.toUpperCase().contains("BTS")) {
                       columns = "Y.NOME_FILE, Y.DATA_ACQ_CHIUS, Y.CODICE_OLO, Y.NOME_RAG_SOC_GEST,Y.CODICE_ORDINE_OLO,  Y.STATO_AGGR,  Y.CODICE_CAUSALE_OLO,  Y.DESCRIZIONE_CAUSALE_OLO,  Y.DATA_DRO,  Y.IDRISORSA,   Y.PARTICELLAOLO,   Y.VIA_OLO,   Y.CIVICOOLO,   Y.LOCALITA_OLO,    Y.FLAG_NPD,    Y.DATA_CHIUSURA,    Y.FL_MOS_MOI, Y.DESC_IMPRESA, Y.MITTENTE,    Y.CARATTERISTICA, Y.TIPO_SERVIZIO, Y.TIPOLOGIA,     Y.CODICE_CAUSALE_SOSP_OLO, Y.DATA_INIZIO_SOSPENSIONE,     Y.DATA_FINE_SOSPENSIONE, Y.DESCRIZIONE_CAUSALE_SOSP_OLO,     Y.COGNOME_REF,    Y.FISSO_REF,     Y.MOBILE_REF,      Y.NOME_REF,      Y.QUALIFICA_REFERENTE,     Y.CODE_GEST, Y.SERVIZIO_IAV, Y.DATA_DRO, Y.CODE_CONTR,     Y.CODE_PS_FATT, Y.TIPO_FLAG_ACQ_RICH ";
                   }
                   if (codeInvent.toUpperCase().contains("PROVI") && codeInvent.toUpperCase().contains("ULL")) {
                       columns = "Y.NOME_FILE, Y.DATA_ACQ_CHIUS, Y.CODICE_OLO, Y.NOME_RAG_SOC_GEST, Y.CODICE_CAUSALE_OLO, Y.DESCRIZIONE_CAUSALE_OLO, Y.CODICE_PROGETTO, Y.CODICE_ORDINE_OLO, Y.STATO_AGGR, Y.CARATTERISTICA, "+
                       "Y.VIA_OLO, Y.PARTICELLAOLO, Y.CIVICOOLO, Y.COMUNE, Y.LOCALITA_OLO, Y.PROV, Y.IDRISORSA, Y.CODICE_RICHULL_TI, Y.DATA_RICEZIONE_ORDINE, Y.CODICE_CAUSALE, Y.DESCRIZIONE_CAUSALE, Y.TIPO_SERVIZIO, "+
                       "Y.DATA_ULTIMA_MODIFICA_ORDINE, Y.DATA_CHIUSURA, Y.FLAG_NPD, Y.FL_MOS_MOI, Y.DESC_IMPRESA, Y.MITTENTE, Y.TIPOLOGIA, Y.CODICE_CAUSALE_SOSP_OLO, Y.DATA_INIZIO_SOSPENSIONE, Y.DATA_FINE_SOSPENSIONE, "+
                       "Y.DATA_INVIO_NOTIFICA_SOSP, Y.DESCRIZIONE_CAUSALE_SOSP_OLO, Y.COGNOME_REF, Y.EMAIL_REF, Y.FAX_REF, Y.FISSO_REF, Y.MOBILE_REF, Y.NOME_REF, Y.QUALIFICA_REFERENTE, Y.CODE_GEST, Y.SERVIZIO_IAV, Y.DATA_DRO, "+
                       "Y.CODE_CONTR, Y.CODE_PS_FATT, Y.TIPO_FLAG_ACQ_RICH";
                   }
                   if (codeInvent.toUpperCase().contains("PROVI") && codeInvent.toUpperCase().contains("WLR")) {
                       columns = "Y.NOME_FILE, Y.DATA_ACQ_CHIUS, Y.CODICE_OLO, Y.NOME_RAG_SOC_GEST, Y.CODICE_ORDINE_OLO, Y.STATO, Y.IDRISORSA, Y.CODICE_RICHULL_TI, Y.CODICE_CAUSALE_OLO, Y.DESCRIZIONE_CAUSALE_OLO, Y.DATA_ULTIMA_MODIFICA_ORDINE, "+
                       "Y.CARATTERISTICA, Y.UTENZA_PRIMARIA, Y.CODICE_CAUSALE_SOSP_OLO, Y.PARTICELLAOLO, Y.VIA_OLO, Y.LOCALITA_OLO, Y.PROV, Y.DATA_CHIUSURA, Y.FLAG_NPD, Y.FL_MOS_MOI, Y.DESC_IMPRESA, Y.MITTENTE, Y.TIPOLOGIA, Y.DATA_INIZIO_SOSPENSIONE, "+
                       "Y.DATA_FINE_SOSPENSIONE, Y.DATA_INVIO_NOTIFICA_SOSP, Y.DESCRIZIONE_CAUSALE_SOSP_OLO, Y.COGNOME_REF, Y.EMAIL_REF, Y.FAX_REF, Y.FISSO_REF, Y.MOBILE_REF, Y.NOME_REF, Y.QUALIFICA_REFERENTE, Y.CODE_GEST, Y.SERVIZIO_IAV, "+
                       "Y.DATA_DRO, Y.CODE_CONTR, Y.CODE_PS_FATT, Y.TIPO_FLAG_ACQ_RICH";
                   }

                   if (codeInvent.toUpperCase().contains("PROVI") && codeInvent.length() > 3 && codeInvent.toUpperCase().substring(codeInvent.length()-3).equalsIgnoreCase("PRO")) {
                       columns = "Y.NOME_FILE, Y.DATA_ACQ_CHIUS, Y.CODICE_OLO, Y.NOME_RAG_SOC_GEST, Y.CODICE_ORDINE_OLO, Y.STATO, Y.IDRISORSA, Y.CODICE_RICHULL_TI, Y.CODICE_CAUSALE_OLO, Y.DESCRIZIONE_CAUSALE_OLO, Y.DATA_ULTIMA_MODIFICA_ORDINE, "+
                       "Y.CARATTERISTICA, Y.UTENZA_PRIMARIA, Y.CODICE_CAUSALE_SOSP_OLO, Y.PARTICELLAOLO, Y.VIA_OLO, Y.LOCALITA_OLO, Y.PROV, Y.DATA_CHIUSURA, Y.FLAG_NPD, Y.FL_MOS_MOI, Y.DESC_IMPRESA, Y.MITTENTE, Y.TIPOLOGIA, Y.DATA_INIZIO_SOSPENSIONE, "+
                       "Y.DATA_FINE_SOSPENSIONE, Y.DATA_INVIO_NOTIFICA_SOSP, Y.DESCRIZIONE_CAUSALE_SOSP_OLO, Y.COGNOME_REF, Y.EMAIL_REF, Y.FAX_REF, Y.FISSO_REF, Y.MOBILE_REF, Y.NOME_REF, Y.QUALIFICA_REFERENTE, Y.CODE_GEST, Y.SERVIZIO_IAV, "+
                       "Y.DATA_DRO, Y.CODE_CONTR, Y.CODE_PS_FATT, Y.TIPO_FLAG_ACQ_RICH, Y.FLAG_REFERENTE, Y.VERIFICA_4_REF, Y.CHIAMATA_4_REF, Y.PIN_4_REF, Y.INDICATORE_4_REF ";
                   }

                   String queryInventWhere1="";
                   String queryInventWhere2="";
                   String queryInventWhere3="";
                   
                   if(operatoreIav.equals("%"))
                       queryInventWhere1="";
                   else
                       queryInventWhere1=" AND itrf.CODE_GEST = '"+operatoreIav +"' ";
                       
                   if(ambitoIav.equals("%"))
                       queryInventWhere2="";
                   else
                       queryInventWhere2= " AND tf.TIPO_FLUSSO like '"+ambitoIav +"' ";
                       
                   queryInventWhere3= " AND itrf.TIPO_FLAG_ACQ_RICH in ("+statoOrdiniIav +") ";
                       
                       
                   String queryInventWithInput=
                   "(select itrf.DESC_ID_RISORSA, itrf.NOME_FILE, itrf.DATA_ACQ_CHIUS, itrf.TIPO_FLAG_ACQ_RICH "+
                   "from i5_5itfr_fat_iav_ass itrf, I5_5IAV_TRAS_CONTRATTI CONT, i5_5iav_servizi s, I5_5IAV_TIPI_FLUSSO tf, I5_1ACCOUNT_X_CONTR ac, I5_2PARAM_VALORIZ_SP pv, i5_1invent_ps_xdsl inv "+
                   "where CONT.CODE_CONTR = itrf.code_contr "+
                   "AND s.CODE_TIPO_CONTR = CONT.CODE_TIPO_CONTR "+
                   "AND tf.ID_FLUSSO = itrf.ID_FLUSSO "+
                   "AND itrf.CODE_GEST = CONT.CODE_GEST (+) "+
                   "AND ac.CODE_CONTR (+) = itrf.CODE_CONTR "+
                   "AND pv.CODE_ACCOUNT (+) = ac.CODE_ACCOUNT "+
                   "AND inv.CODE_ITRF_FAT_XDSL = itrf.CODE_ITRF_FAT_XDSL "+
                   "AND (inv.DATA_ULTIMA_FATRZ is null OR inv.DATA_ULTIMA_FATRZ >= pv.DATA_INIZIO_CICLO_FATRZ) "+
                   "AND inv.CODE_TIPO_CONTR = CONT.CODE_TIPO_CONTR "+
                   "AND pv.CODE_ACCOUNT = inv.CODE_ACCOUNT "+
                   "AND itrf.DESC_ID_RISORSA = inv.CODE_ISTANZA_PS "+
                   "AND pv.TIPO_FLAG_STATO_CONG = 'N' "+
                   queryInventWhere1 + 
                   queryInventWhere2 + 
                   queryInventWhere3 + 
                   "UNION ALL "+
                   "select itrf.DESC_ID_RISORSA, itrf.NOME_FILE, itrf.DATA_ACQ_CHIUS, itrf.TIPO_FLAG_ACQ_RICH "+
                   "from i5_5itfr_fat_iav_prov itrf, I5_5IAV_TRAS_CONTRATTI CONT, i5_5iav_servizi s, I5_5IAV_TIPI_FLUSSO tf, I5_1ACCOUNT_X_CONTR ac, I5_2PARAM_VALORIZ_SP pv, i5_1invent_ps_xdsl inv "+
                   "where CONT.CODE_CONTR = itrf.code_contr "+
                   "AND s.CODE_TIPO_CONTR = CONT.CODE_TIPO_CONTR "+
                   "AND tf.ID_FLUSSO = itrf.ID_FLUSSO "+
                   "AND itrf.CODE_GEST = CONT.CODE_GEST (+) "+
                   "AND ac.CODE_CONTR (+) = itrf.CODE_CONTR "+
                   "AND pv.CODE_ACCOUNT (+) = ac.CODE_ACCOUNT "+
                   "AND inv.CODE_ITRF_FAT_XDSL = itrf.CODE_ITRF_FAT_XDSL "+
                   "AND (inv.DATA_ULTIMA_FATRZ is null OR inv.DATA_ULTIMA_FATRZ >= pv.DATA_INIZIO_CICLO_FATRZ) "+
                   "AND inv.CODE_TIPO_CONTR = CONT.CODE_TIPO_CONTR "+
                   "AND pv.CODE_ACCOUNT = inv.CODE_ACCOUNT "+
                   "AND itrf.DESC_ID_RISORSA = inv.CODE_ISTANZA_PS "+
                   "AND pv.TIPO_FLAG_STATO_CONG = 'N' "+
                   queryInventWhere1 + 
                   queryInventWhere2 + 
                   queryInventWhere3 + 
                   "UNION ALL "+
                   "select itrf.DESC_ID_RISORSA, itrf.NOME_FILE, itrf.DATA_ACQ_CHIUS, itrf.TIPO_FLAG_ACQ_RICH "+
                   "from i5_5itfr_fat_iav_prov_opera itrf, I5_5IAV_TRAS_CONTRATTI CONT, i5_5iav_servizi s, I5_5IAV_TIPI_FLUSSO tf, I5_1ACCOUNT_X_CONTR ac, I5_2PARAM_VALORIZ_SP pv, i5_1invent_ps_xdsl inv "+
                   "where CONT.CODE_CONTR = itrf.code_contr "+
                   "AND s.CODE_TIPO_CONTR = CONT.CODE_TIPO_CONTR "+
                   "AND tf.ID_FLUSSO = itrf.ID_FLUSSO "+
                   "AND itrf.CODE_GEST = CONT.CODE_GEST (+) "+
                   "AND ac.CODE_CONTR (+) = itrf.CODE_CONTR "+
                   "AND pv.CODE_ACCOUNT (+) = ac.CODE_ACCOUNT "+
                   "AND inv.CODE_ITRF_FAT_XDSL = itrf.CODE_ITRF_FAT_XDSL "+
                   "AND (inv.DATA_ULTIMA_FATRZ is null OR inv.DATA_ULTIMA_FATRZ >= pv.DATA_INIZIO_CICLO_FATRZ) "+
                   "AND inv.CODE_TIPO_CONTR = CONT.CODE_TIPO_CONTR "+
                   "AND pv.CODE_ACCOUNT = inv.CODE_ACCOUNT "+
                   "AND itrf.DESC_ID_RISORSA = inv.CODE_ISTANZA_PS "+
                   "AND pv.TIPO_FLAG_STATO_CONG = 'N' "+
                   queryInventWhere1 + 
                   queryInventWhere2 + 
                   queryInventWhere3 + 
                   ") x ";
                   
                   //alf String query = "SELECT " + columns + " FROM " + tableName + "," + queryInventWithInput + " WHERE CODE_ISTANZA_PS = x.DESC_ID_RISORSA ";
                    String query = "";
                   if (codeInvent.toUpperCase().contains("ASSU")) {
                      query = "SELECT " + columns + " FROM I5_5ITFR_FAT_IAV_ASS Y," + queryInventWithInput + " WHERE Y.DESC_ID_RISORSA = x.DESC_ID_RISORSA ";
                   }
                   else {
                       
                       if (codeInvent.toUpperCase().contains("PROVI") && codeInvent.length() > 3 && codeInvent.toUpperCase().substring(codeInvent.length()-3).equalsIgnoreCase("PRO")) {
                           query = "SELECT " + columns + " FROM I5_5ITFR_FAT_IAV_PROV_OPERA Y," + queryInventWithInput + " WHERE Y.DESC_ID_RISORSA = x.DESC_ID_RISORSA ";
                       } else {
                            query = "SELECT " + columns + " FROM I5_5ITFR_FAT_IAV_PROV Y," + queryInventWithInput + " WHERE Y.DESC_ID_RISORSA = x.DESC_ID_RISORSA ";
                       }
                   }
                   
                   System.out.println(query);
                   
                   ps = conn.prepareStatement(query);
                   
                   rs = ps.executeQuery();

                   
                   while(rs.next()) {
                            
                             /*alf
                              ResultInventIav result =  new ResultInventIav();
                                                        
                             result.setNOME_FILE(isNull(rs.getString("NOME_FILE")));
                             result.setDATA_ACQ_CHIUS(isNull(rs.getString("DATA_ACQ_CHIUS")));
                             result.setCODE_INVENT(isNull(rs.getString("CODE_INVENT")));
                             result.setCODE_TIPO_CAUS(isNull(rs.getString("CODE_TIPO_CAUS")));
                             result.setCODE_ACCOUNT(isNull(rs.getString("CODE_ACCOUNT")));
                             result.setCODE_CAUS_ORD(isNull(rs.getString("CODE_CAUS_ORD")));
                             result.setCODE_STATO_PS(isNull(rs.getString("CODE_STATO_PS")));
                             result.setCODE_TIPO_OFF(isNull(rs.getString("CODE_TIPO_OFF")));
                             result.setCODE_TIPO_CAUS_VARIAZ(isNull(rs.getString("CODE_TIPO_CAUS_VARIAZ")));
                             result.setCODE_PS(rs.getString(isNull("CODE_PS")));
                             result.setCODE_TIPO_CONTR(rs.getString(isNull("CODE_TIPO_CONTR")));
                             result.setDATA_DRO(isNull(rs.getString("DATA_DRO")));
                             result.setDATA_DVTC(isNull(rs.getString("DATA_DVTC")));
                             result.setDATA_INIZIO_VALID(isNull(rs.getString("DATA_INIZIO_VALID")));
                             result.setCODE_ISTANZA_PS(isNull(rs.getString("CODE_ISTANZA_PS")));
                             result.setDATA_FINE_VALID(isNull(rs.getString("DATA_FINE_VALID")));
                             result.setDATA_INIZIO_FATRZ(isNull(rs.getString("DATA_INIZIO_FATRZ")));
                             result.setDATA_ULTIMA_FATRZ(isNull(rs.getString("DATA_ULTIMA_FATRZ")));
                             result.setDATA_FINE_NOL(isNull(rs.getString("DATA_FINE_NOL")));
                             result.setDATA_CESS(isNull(rs.getString("DATA_CESS")));
                             result.setDATA_VARIAZ(isNull(rs.getString("DATA_VARIAZ")));
                             result.setDATA_FINE_FATRZ(isNull(rs.getString("DATA_FINE_FATRZ")));
                             result.setDATA_FATRB(isNull(rs.getString("DATA_FATRB")));
                             result.setQNTA_VALO(isNull(rs.getString("QNTA_VALO")));
                             result.setDATA_ULTIMA_APPL_CANONI(isNull(rs.getString("DATA_ULTIMA_APPL_CANONI")));
                             result.setCODE_UTENTE_CREAZ(isNull(rs.getString("CODE_UTENTE_CREAZ")));
                             result.setDATA_CREAZ(isNull(rs.getString("DATA_CREAZ")));
                             result.setCODE_UTENTE_MODIF(isNull(rs.getString("CODE_UTENTE_MODIF")));
                             result.setDATA_MODIF(isNull(rs.getString("DATA_MODIF")));
                             result.setNUM_VARIAZ(isNull(rs.getString("NUM_VARIAZ")));
                             result.setCODE_PS_FATT_PRINC(isNull(rs.getString("CODE_PS_FATT_PRINC")));
                             result.setCODE_AREA_RACCOLTA(isNull(rs.getString("CODE_AREA_RACCOLTA")));
                             result.setCODE_NUM_TD(isNull(rs.getString("CODE_NUM_TD")));
                             result.setCODE_LOTTO(isNull(rs.getString("CODE_LOTTO")));
                             result.setCODE_PS_OLD(isNull(rs.getString("CODE_PS_OLD")));
                             result.setCODE_ISTANZA_OLD(isNull(rs.getString("CODE_ISTANZA_OLD")));
                             result.setTIPO_CONTR_OLD(isNull(rs.getString("TIPO_CONTR_OLD")));
                             result.setTIPO_FLAG_PROMOZ(isNull(rs.getString("TIPO_FLAG_PROMOZ")));
                             result.setDESC_CODE_VPI(isNull(rs.getString("DESC_CODE_VPI")));
                             result.setVALO_MCR(isNull(rs.getString("VALO_MCR")));
                             result.setID_TRASPORTO(isNull(rs.getString("ID_TRASPORTO")));
                             result.setFLAG_TRASPORTO(isNull(rs.getString("FLAG_TRASPORTO")));
                             result.setID_BANDA(isNull(rs.getString("ID_BANDA")));
                             result.setVALO_PCR_BANDA(isNull(rs.getString("VALO_PCR_BANDA")));
                             result.setFLAG_SYS(isNull(rs.getString("FLAG_SYS")));
                             result.setID_ACCESSO(isNull(rs.getString("ID_ACCESSO")));
                             result.setID_VC(isNull(rs.getString("ID_VC")));
                             result.setQNTA_VALO_OLD(isNull(rs.getString("QNTA_VALO_OLD")));
                             result.setTIPO_PROVENIENZA(isNull(rs.getString("TIPO_PROVENIENZA")));
                             result.setOPZ_CONTRATTUALE(isNull(rs.getString("OPZ_CONTRATTUALE")));
                             result.setVALO_PCR_UP(isNull(rs.getString("VALO_PCR_UP")));
                             result.setUTENZA_RIF(isNull(rs.getString("UTENZA_RIF")));
                             result.setCODE_OL(isNull(rs.getString("CODE_OL")));
                             result.setTIPO_SLA_PLUS(isNull(rs.getString("TIPO_SLA_PLUS")));
                             result.setOFFERTA_SLA_PLUS(isNull(rs.getString("OFFERTA_SLA_PLUS")));
                             result.setCOPERTURA_ORARIA(isNull(rs.getString("COPERTURA_ORARIA")));
                             result.setFLAG_DISP(isNull(rs.getString("FLAG_DISP")));
                             result.setOPZ_COMM(isNull(rs.getString("OPZ_COMM")));
                             result.setTIPO_MODULAZ(isNull(rs.getString("TIPO_MODULAZ")));
                             result.setMOD_ACCESSO(isNull(rs.getString("MOD_ACCESSO")));
                             result.setTIPO_VALID(isNull(rs.getString("TIPO_VALID")));
                             result.setCODICE_PROGETTO(isNull(rs.getString("CODICE_PROGETTO")));
                             result.setTIPO_MOD_FAT(isNull(rs.getString("TIPO_MOD_FAT")));
                             result.setDATA_INIZIO_NOL(isNull(rs.getString("DATA_INIZIO_NOL")));
                             result.setCODE_TIPO_PREST(isNull(rs.getString("CODE_TIPO_PREST")));
                             result.setFLAG_ESITO_PREQ(isNull(rs.getString("FLAG_ESITO_PREQ")));
                             result.setBANDA_VL(isNull(rs.getString("BANDA_VL")));
                             result.setCODE_CLLI(isNull(rs.getString("CODE_CLLI")));
                             result.setCODE_ID_ULLCO(isNull(rs.getString("CODE_ID_ULLCO")));
                             result.setCODE_COMUNE(isNull(rs.getString("CODE_COMUNE")));
                             result.setCODE_DISTR(isNull(rs.getString("CODE_DISTR")));
                             result.setVALO_MCR_UP(isNull(rs.getString("VALO_MCR_UP")));
                             result.setID_RIS_OLD(isNull(rs.getString("ID_RIS_OLD")));
                             result.setPROFILO_ACCESSO(isNull(rs.getString("PROFILO_ACCESSO")));
                             result.setMOD_VENDITA(isNull(rs.getString("MOD_VENDITA")));
                             result.setFLAG_MODEM(isNull(rs.getString("FLAG_MODEM")));
                             result.setTIPO_FAMIGLIA(isNull(rs.getString("TIPO_FAMIGLIA")));
                             result.setMOD_FATTURAZIONE(isNull(rs.getString("MOD_FATTURAZIONE")));
                             result.setMOD_FATTURAZIONE_TRASP(isNull(rs.getString("MOD_FATTURAZIONE_TRASP")));
                             result.setCODE_PROFILO_ESTESO(isNull(rs.getString("CODE_PROFILO_ESTESO")));
                             result.setFLAG_LINEA_NUM_AGG(isNull(rs.getString("FLAG_LINEA_NUM_AGG")));
                             result.setCLASS_SERV(isNull(rs.getString("CLASS_SERV")));
                             result.setCODE_MACRO_AREA(isNull(rs.getString("CODE_MACRO_AREA")));
                             result.setCODE_IDBRE_DSLAM(isNull(rs.getString("CODE_IDBRE_DSLAM")));                     
                             result.setFLAG_NUOVO_FEEDER(isNull(rs.getString("FLAG_NUOVO_FEEDER")));
                             result.setCOUNT_FEEDER(isNull(rs.getString("COUNT_FEEDER")));
                             result.setCODICE_PROGETTO_BILL(isNull(rs.getString("CODICE_PROGETTO_BILL")));
                             result.setCODICE_QUALITA(isNull(rs.getString("CODICE_QUALITA")));
                             result.setCODICE_DELIVERY(isNull(rs.getString("CODICE_DELIVERY")));
                             result.setCAMPO_SERV_IT(isNull(rs.getString("CAMPO_SERV_IT")));
                             result.setFLAG_MONITORAGGIO(isNull(rs.getString("FLAG_MONITORAGGIO")));
                             result.setTECNOLOGIA(isNull(rs.getString("TECNOLOGIA")));
                             result.setID_ORD_CRMWS(isNull(rs.getString("ID_ORD_CRMWS")));
                             result.setCODE_ITRF_FAT_XDSL(isNull(rs.getString("CODE_ITRF_FAT_XDSL")));
                             result.setID_CVLAN(isNull(rs.getString("ID_CVLAN")));
                             result.setCODE_TIPO_CAUS_VARIAZ_CONG(isNull(rs.getString("CODE_TIPO_CAUS_VARIAZ_CONG")));
                             result.setCODE_SUPER_MACRO_AREA(isNull(rs.getString("CODE_SUPER_MACRO_AREA")));
                             result.setFLAG_LA(isNull(rs.getString("FLAG_LA")));
                             result.setINSTALLAZIONE(isNull(rs.getString("INSTALLAZIONE")));
                             result.setID_MTCO(isNull(rs.getString("ID_MTCO")));
                             result.setCONNETTORE_MTCO(isNull(rs.getString("CONNETTORE_MTCO")));
                             result.setCOD_TOPONOMASTICA(isNull(rs.getString("COD_TOPONOMASTICA")));
                             result.setFLAG_4REFERENTE(isNull(rs.getString("FLAG_4REFERENTE")));
                             result.setTIPO_CPE(isNull(rs.getString("TIPO_CPE")));
                             result.setFLAG_INTERVENTO(isNull(rs.getString("FLAG_INTERVENTO")));
                             result.setCODE_HOSTING(isNull(rs.getString("CODE_HOSTING")));
                             result.setTECNOLOGIA_FIBRA(isNull(rs.getString("TECNOLOGIA_FIBRA")));
                             result.setFLAG_QUALIFICA(isNull(rs.getString("FLAG_QUALIFICA")));
                             result.setFLAG_TEST2(isNull(rs.getString("FLAG_TEST2")));
                             result.setTIPO_CLUSTER(isNull(rs.getString("TIPO_CLUSTER")));
                             result.setCODE_CLUSTER(isNull(rs.getString("CODE_CLUSTER")));
                             
                             result.setTIPO_FLAG_ACQ_RICH(isNull(rs.getString("TIPO_FLAG_ACQ_RICH")));
                         */
                             // if (codeInvent.toUpperCase().contains("ASSU")) {
                             ResultItrfIav result =  new ResultItrfIav();
                                 
                             if (codeInvent.toUpperCase().contains("ASSU")) {
                                 result.setNOME_FILE(isNull(rs.getString("NOME_FILE")));
                                 result.setDATA_ACQ_CHIUS(isNull(rs.getString("DATA_ACQ_CHIUS")));
                                 result.setIDENTIFICATIVOTT(isNull(rs.getString("IDENTIFICATIVOTT")));
                                 result.setID_IDENTIFICATIVO_TT(isNull(rs.getString("ID_IDENTIFICATIVO_TT")));
                                 result.setTIPOSERVIZIO(isNull(rs.getString("TIPOSERVIZIO")));
                                 result.setSERVIZIO_EROGATO(isNull(rs.getString("SERVIZIO_EROGATO")));
                                 result.setTIPOTICKETOLO(isNull(rs.getString("TIPOTICKETOLO")));
                                 result.setOGGETTO_SEGNALATO(isNull(rs.getString("OGGETTO_SEGNALATO")));
                                 result.setRISCONTRO(isNull(rs.getString("RISCONTRO")));
                                 result.setDATAORAINIZIOSEGN(isNull(rs.getString("DATAORAINIZIOSEGN")));
                                 result.setDATAORAFINEDISSERVIZIO(isNull(rs.getString("DATAORAFINEDISSERVIZIO")));
                                 result.setCHIUSURATT_TTMWEB(isNull(rs.getString("CHIUSURATT_TTMWEB")));
                                 result.setNOMEOLO(isNull(rs.getString("NOMEOLO")));
                                 result.setCODICEFONTE(isNull(rs.getString("CODICEFONTE")));
                                 result.setDESCCAUSACHIUSURAOLO(isNull(rs.getString("DESCCAUSACHIUSURAOLO")));
                                 result.setCLASSIFICAZIONE_TECNICA(isNull(rs.getString("CLASSIFICAZIONE_TECNICA")));
                                 result.setCOMPETENZA_CHIUSURA(isNull(rs.getString("COMPETENZA_CHIUSURA")));
                                 result.setANNO_CHIUSURA(isNull(rs.getString("ANNO_CHIUSURA")));
                                 result.setMESE_CHIUSURA(isNull(rs.getString("MESE_CHIUSURA")));
                                 result.setRISCONTRATI_AUTORIPR(isNull(rs.getString("RISCONTRATI_AUTORIPR")));
                                 result.setREMOTO_ON_FIELD(isNull(rs.getString("REMOTO_ON_FIELD")));
                                 result.setCODICE_IMPRESA(isNull(rs.getString("CODICE_IMPRESA")));
                                 result.setDESCRIZIONE_IMPRESA(isNull(rs.getString("DESCRIZIONE_IMPRESA")));
                                 result.setADDR_CIRCUITINFO(isNull(rs.getString("ADDR_CIRCUITINFO")));
                                 result.setADDR_CUST(isNull(rs.getString("ADDR_CUST")));
                                 result.setLOCATIONDESC(isNull(rs.getString("LOCATIONDESC")));
                                 result.setTECHASSIGNED(isNull(rs.getString("TECHASSIGNED")));
                                 result.setDATA_CREAZIONE_WR(isNull(rs.getString("DATA_CREAZIONE_WR")));
                                 result.setCODE_GEST(isNull(rs.getString("CODE_GEST")));
                                 result.setSERVIZIO_IAV(isNull(rs.getString("SERVIZIO_IAV")));
                                 result.setDATA_DRO(isNull(rs.getString("DATA_DRO")));
                                 result.setCODE_CONTR(isNull(rs.getString("CODE_CONTR")));
                                 result.setCODE_PS_FATT(isNull(rs.getString("CODE_PS_FATT")));
                                 result.setTIPO_FLAG_ACQ_RICH(isNull(rs.getString("TIPO_FLAG_ACQ_RICH")));
                             }
                         
                             if (codeInvent.toUpperCase().contains("PROVI") && codeInvent.toUpperCase().contains("BTS")) {
                                 result.setNOME_FILE(isNull(rs.getString("NOME_FILE")));
                                 result.setDATA_ACQ_CHIUS(isNull(rs.getString("DATA_ACQ_CHIUS")));
                                 result.setCODICE_OLO(isNull(rs.getString("CODICE_OLO")));
                                 result.setNOME_RAG_SOC_GEST(isNull(rs.getString("NOME_RAG_SOC_GEST")));
                                 result.setCODICE_ORDINE_OLO(isNull(rs.getString("CODICE_ORDINE_OLO")));
                                 result.setSTATO_AGGR(isNull(rs.getString("STATO_AGGR")));
                                 result.setCODICE_CAUSALE_OLO(isNull(rs.getString("CODICE_CAUSALE_OLO")));
                                 result.setDESCRIZIONE_CAUSALE_OLO(isNull(rs.getString("DESCRIZIONE_CAUSALE_OLO")));
                                 result.setDATA_DRO(isNull(rs.getString("DATA_DRO")));
                                 result.setIDRISORSA(isNull(rs.getString("IDRISORSA")));
                                 result.setDATA_DRO(isNull(rs.getString("DATA_DRO")));
                                 result.setPARTICELLAOLO(isNull(rs.getString("PARTICELLAOLO")));
                                 result.setVIA_OLO(isNull(rs.getString("VIA_OLO")));
                                 result.setCIVICOOLO(isNull(rs.getString("CIVICOOLO")));
                                 result.setLOCALITA_OLO(isNull(rs.getString("LOCALITA_OLO")));
                                 result.setFLAG_NPD(isNull(rs.getString("FLAG_NPD")));
                                 result.setDATA_CHIUSURA(isNull(rs.getString("DATA_CHIUSURA")));
                                 result.setFL_MOS_MOI(isNull(rs.getString("FL_MOS_MOI")));
                                 result.setDESC_IMPRESA(isNull(rs.getString("DESC_IMPRESA")));
                                 result.setMITTENTE(isNull(rs.getString("MITTENTE")));
                                 result.setCARATTERISTICA(isNull(rs.getString("CARATTERISTICA")));
                                 result.setTIPO_SERVIZIO(isNull(rs.getString("TIPO_SERVIZIO")));
                                 result.setTIPOLOGIA(isNull(rs.getString("TIPOLOGIA")));
                                 result.setCODICE_CAUSALE_SOSP_OLO(isNull(rs.getString("CODICE_CAUSALE_SOSP_OLO")));
                                 result.setDATA_INIZIO_SOSPENSIONE(isNull(rs.getString("DATA_INIZIO_SOSPENSIONE")));
                                 result.setDATA_FINE_SOSPENSIONE(isNull(rs.getString("DATA_FINE_SOSPENSIONE")));
                                 result.setDESCRIZIONE_CAUSALE_SOSP_OLO(isNull(rs.getString("DESCRIZIONE_CAUSALE_SOSP_OLO")));
                                 result.setCOGNOME_REF(isNull(rs.getString("COGNOME_REF")));
                                 result.setFISSO_REF(isNull(rs.getString("FISSO_REF")));
                                 result.setMOBILE_REF(isNull(rs.getString("MOBILE_REF")));
                                 result.setNOME_REF(isNull(rs.getString("NOME_REF")));
                                 result.setQUALIFICA_REFERENTE(isNull(rs.getString("QUALIFICA_REFERENTE")));
                                 result.setCODE_GEST(isNull(rs.getString("CODE_GEST")));
                                 result.setSERVIZIO_IAV(isNull(rs.getString("SERVIZIO_IAV")));
                                 result.setDATA_DRO(isNull(rs.getString("DATA_DRO")));
                                 result.setCODE_CONTR(isNull(rs.getString("CODE_CONTR")));
                                 result.setCODE_PS_FATT(isNull(rs.getString("CODE_PS_FATT")));
                                 result.setTIPO_FLAG_ACQ_RICH(isNull(rs.getString("TIPO_FLAG_ACQ_RICH")));
                             }   
                             
                             if (codeInvent.toUpperCase().contains("PROVI") && codeInvent.toUpperCase().contains("ULL")) {
                                 result.setNOME_FILE(isNull(rs.getString("NOME_FILE")));
                                 result.setDATA_ACQ_CHIUS(isNull(rs.getString("DATA_ACQ_CHIUS")));
                                 result.setCODICE_OLO(isNull(rs.getString("CODICE_OLO")));
                                 result.setNOME_RAG_SOC_GEST(isNull(rs.getString("NOME_RAG_SOC_GEST")));
                                 result.setCODICE_CAUSALE_OLO(isNull(rs.getString("CODICE_CAUSALE_OLO")));
                                 result.setDESCRIZIONE_CAUSALE_OLO(isNull(rs.getString("DESCRIZIONE_CAUSALE_OLO")));
                                 result.setCODICE_PROGETTO(isNull(rs.getString("CODICE_PROGETTO")));
                                 result.setCODICE_ORDINE_OLO(isNull(rs.getString("CODICE_ORDINE_OLO")));
                                 result.setSTATO_AGGR(isNull(rs.getString("STATO_AGGR")));
                                 result.setCARATTERISTICA(isNull(rs.getString("CARATTERISTICA")));
                                 result.setVIA_OLO(isNull(rs.getString("VIA_OLO")));
                                 result.setPARTICELLAOLO(isNull(rs.getString("PARTICELLAOLO")));
                                 result.setCIVICOOLO(isNull(rs.getString("CIVICOOLO")));
                                 result.setCOMUNE(isNull(rs.getString("COMUNE")));
                                 result.setLOCALITA_OLO(isNull(rs.getString("LOCALITA_OLO")));
                                 result.setPROV(isNull(rs.getString("PROV")));
                                 result.setIDRISORSA(isNull(rs.getString("IDRISORSA")));
                                 result.setCODICE_RICHULL_TI(isNull(rs.getString("CODICE_RICHULL_TI")));
                                 result.setDATA_RICEZIONE_ORDINE(isNull(rs.getString("DATA_RICEZIONE_ORDINE")));
                                 result.setCODICE_CAUSALE(isNull(rs.getString("CODICE_CAUSALE")));
                                 result.setDESCRIZIONE_CAUSALE(isNull(rs.getString("DESCRIZIONE_CAUSALE")));
                                 result.setTIPO_SERVIZIO(isNull(rs.getString("TIPO_SERVIZIO")));
                                 result.setDATA_ULTIMA_MODIFICA_ORDINE(isNull(rs.getString("DATA_ULTIMA_MODIFICA_ORDINE")));
                                 result.setDATA_CHIUSURA(isNull(rs.getString("DATA_CHIUSURA")));
                                 result.setFLAG_NPD(isNull(rs.getString("FLAG_NPD")));
                                 result.setFL_MOS_MOI(isNull(rs.getString("FL_MOS_MOI")));
                                 result.setDESC_IMPRESA(isNull(rs.getString("DESC_IMPRESA")));
                                 result.setMITTENTE(isNull(rs.getString("MITTENTE")));
                                 result.setTIPOLOGIA(isNull(rs.getString("TIPOLOGIA")));
                                 result.setCODICE_CAUSALE_SOSP_OLO(isNull(rs.getString("CODICE_CAUSALE_SOSP_OLO")));
                                 result.setDATA_INIZIO_SOSPENSIONE(isNull(rs.getString("DATA_INIZIO_SOSPENSIONE")));
                                 result.setDATA_FINE_SOSPENSIONE(isNull(rs.getString("DATA_FINE_SOSPENSIONE")));
                                 result.setDATA_INIZIO_SOSPENSIONE(isNull(rs.getString("DATA_INVIO_NOTIFICA_SOSP")));
                                 result.setDESCRIZIONE_CAUSALE_SOSP_OLO(isNull(rs.getString("DESCRIZIONE_CAUSALE_SOSP_OLO")));
                                 result.setCOGNOME_REF(isNull(rs.getString("COGNOME_REF")));
                                 result.setEMAIL_REF(isNull(rs.getString("EMAIL_REF")));
                                 result.setFAX_REF(isNull(rs.getString("FAX_REF")));
                                 result.setFISSO_REF(isNull(rs.getString("FISSO_REF")));
                                 result.setMOBILE_REF(isNull(rs.getString("MOBILE_REF")));
                                 result.setNOME_REF(isNull(rs.getString("NOME_REF")));
                                 result.setQUALIFICA_REFERENTE(isNull(rs.getString("QUALIFICA_REFERENTE")));
                                 result.setCODE_GEST(isNull(rs.getString("CODE_GEST")));
                                 result.setSERVIZIO_IAV(isNull(rs.getString("SERVIZIO_IAV")));
                                 result.setDATA_DRO(isNull(rs.getString("DATA_DRO")));
                                 result.setCODE_CONTR(isNull(rs.getString("CODE_CONTR")));
                                 result.setCODE_PS_FATT(isNull(rs.getString("CODE_PS_FATT")));
                                 result.setTIPO_FLAG_ACQ_RICH(isNull(rs.getString("TIPO_FLAG_ACQ_RICH")));

                             }
                             if (codeInvent.toUpperCase().contains("PROVI") && codeInvent.toUpperCase().contains("WLR")) {
                                 result.setNOME_FILE(isNull(rs.getString("NOME_FILE")));
                                 result.setDATA_ACQ_CHIUS(isNull(rs.getString("DATA_ACQ_CHIUS")));
                                 result.setCODICE_OLO(isNull(rs.getString("CODICE_OLO")));
                                 result.setNOME_RAG_SOC_GEST(isNull(rs.getString("NOME_RAG_SOC_GEST")));
                                 result.setCODICE_ORDINE_OLO(isNull(rs.getString("CODICE_ORDINE_OLO")));
                                 result.setSTATO(isNull(rs.getString("STATO")));
                                 result.setIDRISORSA(isNull(rs.getString("IDRISORSA")));
                                 result.setCODICE_RICHULL_TI(isNull(rs.getString("CODICE_RICHULL_TI")));
                                 result.setCODICE_CAUSALE_OLO(isNull(rs.getString("CODICE_CAUSALE_OLO")));
                                 result.setDESCRIZIONE_CAUSALE_OLO(isNull(rs.getString("DESCRIZIONE_CAUSALE_OLO")));
                                 result.setDATA_ULTIMA_MODIFICA_ORDINE(isNull(rs.getString("DATA_ULTIMA_MODIFICA_ORDINE")));
                                 result.setCARATTERISTICA(isNull(rs.getString("CARATTERISTICA")));
                                 result.setUTENZA_PRIMARIA(isNull(rs.getString("UTENZA_PRIMARIA")));
                                 result.setCODICE_CAUSALE_SOSP_OLO(isNull(rs.getString("CODICE_CAUSALE_SOSP_OLO")));
                                 result.setPARTICELLAOLO(isNull(rs.getString("PARTICELLAOLO")));
                                 result.setVIA_OLO(isNull(rs.getString("VIA_OLO")));
                                 result.setLOCALITA_OLO(isNull(rs.getString("LOCALITA_OLO")));
                                 result.setPROV(isNull(rs.getString("PROV")));
                                 result.setDATA_CHIUSURA(isNull(rs.getString("DATA_CHIUSURA")));
                                 result.setFLAG_NPD(isNull(rs.getString("FLAG_NPD")));
                                 result.setFL_MOS_MOI(isNull(rs.getString("FL_MOS_MOI")));
                                 result.setDESC_IMPRESA(isNull(rs.getString("DESC_IMPRESA")));
                                 result.setMITTENTE(isNull(rs.getString("MITTENTE")));
                                 result.setTIPOLOGIA(isNull(rs.getString("TIPOLOGIA")));
                                 result.setDATA_INIZIO_SOSPENSIONE(isNull(rs.getString("DATA_INIZIO_SOSPENSIONE")));
                                 result.setDATA_FINE_SOSPENSIONE(isNull(rs.getString("DATA_FINE_SOSPENSIONE")));
                                 result.setDATA_INIZIO_SOSPENSIONE(isNull(rs.getString("DATA_INVIO_NOTIFICA_SOSP")));
                                 result.setDESCRIZIONE_CAUSALE_SOSP_OLO(isNull(rs.getString("DESCRIZIONE_CAUSALE_SOSP_OLO")));
                                 result.setCOGNOME_REF(isNull(rs.getString("COGNOME_REF")));
                                 result.setEMAIL_REF(isNull(rs.getString("EMAIL_REF")));
                                 result.setFAX_REF(isNull(rs.getString("FAX_REF")));
                                 result.setFISSO_REF(isNull(rs.getString("FISSO_REF")));
                                 result.setMOBILE_REF(isNull(rs.getString("MOBILE_REF")));
                                 result.setNOME_REF(isNull(rs.getString("NOME_REF")));
                                 result.setQUALIFICA_REFERENTE(isNull(rs.getString("QUALIFICA_REFERENTE")));
                                 result.setCODE_GEST(isNull(rs.getString("CODE_GEST")));
                                 result.setSERVIZIO_IAV(isNull(rs.getString("SERVIZIO_IAV")));
                                 result.setDATA_DRO(isNull(rs.getString("DATA_DRO")));
                                 result.setCODE_CONTR(isNull(rs.getString("CODE_CONTR")));
                                 result.setCODE_PS_FATT(isNull(rs.getString("CODE_PS_FATT")));
                                 result.setTIPO_FLAG_ACQ_RICH(isNull(rs.getString("TIPO_FLAG_ACQ_RICH")));
                             }
                             if (codeInvent.toUpperCase().contains("PROVI") && codeInvent.length() > 3 && codeInvent.toUpperCase().substring(codeInvent.length()-3).equalsIgnoreCase("PRO")) {
                                 result.setNOME_FILE(isNull(rs.getString("NOME_FILE")));
                                 result.setDATA_ACQ_CHIUS(isNull(rs.getString("DATA_ACQ_CHIUS")));
                                 result.setCODICE_OLO(isNull(rs.getString("CODICE_OLO")));
                                 result.setNOME_RAG_SOC_GEST(isNull(rs.getString("NOME_RAG_SOC_GEST")));
                                 result.setCODICE_ORDINE_OLO(isNull(rs.getString("CODICE_ORDINE_OLO")));
                                 result.setSTATO(isNull(rs.getString("STATO")));
                                 result.setIDRISORSA(isNull(rs.getString("IDRISORSA")));
                                 result.setCODICE_RICHULL_TI(isNull(rs.getString("CODICE_RICHULL_TI")));
                                 result.setCODICE_CAUSALE_OLO(isNull(rs.getString("CODICE_CAUSALE_OLO")));
                                 result.setDESCRIZIONE_CAUSALE_OLO(isNull(rs.getString("DESCRIZIONE_CAUSALE_OLO")));
                                 result.setDATA_ULTIMA_MODIFICA_ORDINE(isNull(rs.getString("DATA_ULTIMA_MODIFICA_ORDINE")));
                                 result.setCARATTERISTICA(isNull(rs.getString("CARATTERISTICA")));
                                 result.setUTENZA_PRIMARIA(isNull(rs.getString("UTENZA_PRIMARIA")));
                                 result.setCODICE_CAUSALE_SOSP_OLO(isNull(rs.getString("CODICE_CAUSALE_SOSP_OLO")));
                                 result.setPARTICELLAOLO(isNull(rs.getString("PARTICELLAOLO")));
                                 result.setVIA_OLO(isNull(rs.getString("VIA_OLO")));
                                 result.setLOCALITA_OLO(isNull(rs.getString("LOCALITA_OLO")));
                                 result.setPROV(isNull(rs.getString("PROV")));
                                 result.setDATA_CHIUSURA(isNull(rs.getString("DATA_CHIUSURA")));
                                 result.setFLAG_NPD(isNull(rs.getString("FLAG_NPD")));
                                 result.setFL_MOS_MOI(isNull(rs.getString("FL_MOS_MOI")));
                                 result.setDESC_IMPRESA(isNull(rs.getString("DESC_IMPRESA")));
                                 result.setMITTENTE(isNull(rs.getString("MITTENTE")));
                                 result.setTIPOLOGIA(isNull(rs.getString("TIPOLOGIA")));
                                 result.setDATA_INIZIO_SOSPENSIONE(isNull(rs.getString("DATA_INIZIO_SOSPENSIONE")));
                                 result.setDATA_FINE_SOSPENSIONE(isNull(rs.getString("DATA_FINE_SOSPENSIONE")));
                                 result.setDATA_INIZIO_SOSPENSIONE(isNull(rs.getString("DATA_INVIO_NOTIFICA_SOSP")));
                                 result.setDESCRIZIONE_CAUSALE_SOSP_OLO(isNull(rs.getString("DESCRIZIONE_CAUSALE_SOSP_OLO")));
                                 result.setCOGNOME_REF(isNull(rs.getString("COGNOME_REF")));
                                 result.setEMAIL_REF(isNull(rs.getString("EMAIL_REF")));
                                 result.setFAX_REF(isNull(rs.getString("FAX_REF")));
                                 result.setFISSO_REF(isNull(rs.getString("FISSO_REF")));
                                 result.setMOBILE_REF(isNull(rs.getString("MOBILE_REF")));
                                 result.setNOME_REF(isNull(rs.getString("NOME_REF")));
                                 result.setQUALIFICA_REFERENTE(isNull(rs.getString("QUALIFICA_REFERENTE")));
                                 result.setCODE_GEST(isNull(rs.getString("CODE_GEST")));
                                 result.setSERVIZIO_IAV(isNull(rs.getString("SERVIZIO_IAV")));
                                 result.setDATA_DRO(isNull(rs.getString("DATA_DRO")));
                                 result.setCODE_CONTR(isNull(rs.getString("CODE_CONTR")));
                                 result.setCODE_PS_FATT(isNull(rs.getString("CODE_PS_FATT")));
                                 result.setTIPO_FLAG_ACQ_RICH(isNull(rs.getString("TIPO_FLAG_ACQ_RICH")));
                                 result.setFLAG_REFERENTE(isNull(rs.getString("FLAG_REFERENTE")));
                                 result.setVERIFICA_4_REF(isNull(rs.getString("VERIFICA_4_REF")));
                                 result.setCHIAMATA_4_REF(isNull(rs.getString("CHIAMATA_4_REF")));
                                 result.setPIN_4_REF(isNull(rs.getString("PIN_4_REF")));
                                 result.setINDICATORE_4_REF(isNull(rs.getString("INDICATORE_4_REF")));
                             }

                             results.add(result);   
                              
                     } 
                     
                                         
                   
               }catch(SQLException e){
                   System.out.println (e.getMessage());
                   e.printStackTrace();
                   closeConnection();
               }  finally{
                     closeConnection();
                 }
                 
            return results;

    } 
    
    public Vector<ResultRefuseIav> getProvisioningQuery(String startDate, String endDate) throws SQLException,
                                                                            RemoteException {
        try{
          
          conn = getConnection(dsName);
          
          startDate =  startDate + " 00:00:00";
          endDate = endDate + " 00:00:00";
          
          Vector<ResultRefuseIav> resultqueryDistinctOk = new Vector<ResultRefuseIav>();
          
          Vector<ResultRefuseIav> resultqueryDistinctKo = new Vector<ResultRefuseIav>();
          
          String queryDistinctOk = "SELECT DISTINCT PROV.NOME_FILE FROM " +tableName +" PROV"
          + " WHERE TO_DATE(PROV.DATA_INIZIO_SOSPENSIONE, 'DD/MM/YYYY HH24:MI:SS') >= TO_DATE(' " + startDate + " ', 'DD/MM/YYYY HH24:MI:SS') AND "
          + "TO_DATE(PROV.DATA_FINE_SOSPENSIONE, 'DD/MM/YYYY HH24:MI:SS') <= TO_DATE(' " + endDate + " ', 'DD/MM/YYYY HH24:MI:SS')";
                    
          String queryDistinctKo = "SELECT DISTINCT PROV.NOME_FILE FROM " + tableName_err +  " PROV"
          + " WHERE TO_DATE(PROV.DATA_INIZIO_SOSPENSIONE, 'DD/MM/YYYY HH24:MI:SS') >= TO_DATE(' " + startDate + " ', 'DD/MM/YYYY HH24:MI:SS') AND "
          + "TO_DATE(PROV.DATA_FINE_SOSPENSIONE, 'DD/MM/YYYY HH24:MI:SS') <= TO_DATE(' " + endDate + " ', 'DD/MM/YYYY HH24:MI:SS')";
          
          ps = conn.prepareStatement(queryDistinctOk);
          
          rs = ps.executeQuery();
          
          while(rs.next()) {
                    ResultRefuseIav result =  new ResultRefuseIav();
                    
                    String nameFile = rs.getString("NOME_FILE");
                    String[] partsOfNameFile = null;
                    
                    if(nameFile != null){
                        partsOfNameFile = nameFile.split(".");
                    }

                    result.setNameFile(nameFile != null ? nameFile : null);
                    result.setNameFlow(nameFile.replace(".csv", " "));
                
                    resultqueryDistinctOk.add(result);
            } 
            
            
              /*ps = conn.prepareStatement(queryDistinctKo);
              
              rs = ps.executeQuery();
              
              while(rs.next()) {
                        ResultRefuseIav result =  new ResultRefuseIav();
                        
                        String nameFile = rs.getString("NOME_FILE");
                        String[] partsOfNameFile = null;
                        
                        if(nameFile != null){
                            partsOfNameFile = nameFile.split(".");
                        }

                        result.setNameFile(nameFile != null ? nameFile : null);
                        result.setNameFlow(partsOfNameFile[0] != null ? partsOfNameFile[0] : null );       
                        
                        resultqueryDistinctKo.add(result);
                } */
          
          String countQueryOk = "SELECT COUNT(*) FROM " + tableName + " PROV"
          + "  WHERE TO_DATE(PROV.DATA_INIZIO_SOSPENSIONE, 'DD/MM/YYYY HH24:MI:SS') >= TO_DATE(' " + startDate + " ', 'DD/MM/YYYY HH24:MI:SS') AND "
          + "TO_DATE(PROV.DATA_FINE_SOSPENSIONE, 'DD/MM/YYYY HH24:MI:SS') <= TO_DATE(' " + endDate + " ', 'DD/MM/YYYY HH24:MI:SS')"
          + " AND PROV.NOME_FILE = ";
          
          String countQueryKo = "SELECT COUNT(*) FROM " + tableName_err + " PROV"
          + "  WHERE TO_DATE(PROV.DATA_INIZIO_SOSPENSIONE, 'DD/MM/YYYY HH24:MI:SS') >= TO_DATE(' " + startDate + " ', 'DD/MM/YYYY HH24:MI:SS') AND "
          + "TO_DATE(PROV.DATA_FINE_SOSPENSIONE, 'DD/MM/YYYY HH24:MI:SS') <= TO_DATE(' " + endDate + " ', 'DD/MM/YYYY HH24:MI:SS')"
          + " AND PROV.NOME_FILE = ";
          
          return buildResultSet( resultqueryDistinctOk, resultqueryDistinctKo,countQueryOk,countQueryKo);
          
          
          }catch(SQLException e){
              System.out.println (e.getMessage());
              e.printStackTrace();
              closeConnection();
          }  finally{
                closeConnection();
            }
            
         return null;                                                           
    }
  
  public Vector<ResultRefuseIav> getAssuranceQuery(String startDate, String endDate) throws SQLException,
                                                                          RemoteException {
    try{
      
      conn = getConnection(dsName);
      
      startDate = startDate +  " 00:00:00";
      endDate = endDate +  " 00:00:00";
      
      Vector<ResultRefuseIav> resultqueryDistinctOk = new Vector<ResultRefuseIav>();
      
      Vector<ResultRefuseIav> resultqueryDistinctKo = new Vector<ResultRefuseIav>();
      
      String queryDistinctOk = "SELECT DISTINCT ASSM.NOME_FILE FROM " +tableName +" ASSM"
      + " WHERE TO_DATE(ASSM.DATAORAINIZIOSEGN, 'DD/MM/YYYY HH24:MI:SS') >= TO_DATE(' " + startDate + " ', 'DD/MM/YYYY HH24:MI:SS') AND "
      + "TO_DATE(ASSM.DATAORAFINEDISSERVIZIO, 'DD/MM/YYYY HH24:MI:SS') <= TO_DATE(' " + endDate + " ', 'DD/MM/YYYY HH24:MI:SS')";
            
      String queryDistinctKo = "SELECT DISTINCT ASSM.NOME_FILE FROM " + tableName_err +  " ASSM"
      + " WHERE TO_DATE(ASSM.DATAORAINIZIOSEGN, 'DD/MM/YYYY HH24:MI:SS') >= TO_DATE(' " + startDate + " ', 'DD/MM/YYYY HH24:MI:SS') AND "
      + "TO_DATE(ASSM.DATAORAFINEDISSERVIZIO, 'DD/MM/YYYY HH24:MI:SS') <= TO_DATE(' " + endDate + " ', 'DD/MM/YYYY HH24:MI:SS')";
      
      ps = conn.prepareStatement(queryDistinctOk);
      
      rs = ps.executeQuery();
      
      while(rs.next()) {
                ResultRefuseIav result =  new ResultRefuseIav();
                
                String nameFile = rs.getString("NOME_FILE");
                String[] partsOfNameFile = null;
                
                
                
                //System.out.println(partsOfNameFile[0]);

                result.setNameFile(nameFile != null ? nameFile : null);
                result.setNameFlow(nameFile.replace(".csv", " "));//partsOfNameFile[0] != null ? partsOfNameFile[0] : null );       
                
                resultqueryDistinctOk.add(result);
        } 
        
        
          /*ps = conn.prepareStatement(queryDistinctKo);
          
          rs = ps.executeQuery();
          
          while(rs.next()) {
                    ResultRefuseIav result =  new ResultRefuseIav();
                    
                    String nameFile = rs.getString("NOME_FILE");
                    String[] partsOfNameFile = null;
                    
                    if(nameFile != null){
                        partsOfNameFile = nameFile.split(".");
                    }

                    result.setNameFile(nameFile != null ? nameFile : null);
                    result.setNameFlow(partsOfNameFile[0] != null ? partsOfNameFile[0] : null );       
                    
                    resultqueryDistinctKo.add(result);
            } */
      
      String countQueryOk = "SELECT COUNT(*) FROM " + tableName + " ASSM"
      + "  WHERE TO_DATE(ASSM.DATAORAINIZIOSEGN, 'DD/MM/YYYY HH24:MI:SS') >= TO_DATE(' " + startDate + " ', 'DD/MM/YYYY HH24:MI:SS') AND "
      + "TO_DATE(ASSM.DATAORAFINEDISSERVIZIO, 'DD/MM/YYYY HH24:MI:SS') <= TO_DATE(' " + endDate + " ', 'DD/MM/YYYY HH24:MI:SS')"
      + " AND ASSM.NOME_FILE = ";
      
      String countQueryKo = "SELECT COUNT(*) FROM " + tableName_err + " ASSM"
      + "  WHERE TO_DATE(ASSM.DATAORAINIZIOSEGN, 'DD/MM/YYYY HH24:MI:SS') >= TO_DATE(' " + startDate + " ', 'DD/MM/YYYY HH24:MI:SS') AND "
      + "TO_DATE(ASSM.DATAORAFINEDISSERVIZIO, 'DD/MM/YYYY HH24:MI:SS') <= TO_DATE(' " + endDate + " ', 'DD/MM/YYYY HH24:MI:SS')"
      + " AND ASSM.NOME_FILE = ";
      
      return buildResultSet( resultqueryDistinctOk, resultqueryDistinctKo,countQueryOk,countQueryKo);
      
      
      }catch(SQLException e){
          System.out.println (e.getMessage());
          e.printStackTrace();
          closeConnection();
      }  finally{
            closeConnection();
        }
        
     return null;
  }
  
  public Vector<ResultRefuseIav> buildResultSet(Vector<ResultRefuseIav> resultsOk, Vector<ResultRefuseIav> resultsKo, String queryCountOk, String queryCountKo) throws SQLException,
                                                                              RemoteException {
      for(int i = 0; i < resultsOk.size(); i++){
          
          ResultRefuseIav tmpResult = resultsOk.get(i);
          
          queryCountOk = queryCountOk + "  '" + tmpResult.getNameFile() + "' ";
          
          queryCountKo = queryCountKo + "  '" + tmpResult.getNameFile() + "' ";
          
          tmpResult.setCountOK( getCountFromQuery(queryCountOk).toString() );
          tmpResult.setCountKO(getCountFromQuery(queryCountKo).toString());
          
      }
      
      return resultsOk;
  }
  
  public Integer getCountFromQuery(String query) throws SQLException,
                                                          RemoteException {
        Integer tot = 0;                                                  
                                                          
      try{
          
          conn = getConnection(dsName);
          
          ps = conn.prepareStatement(query);
          
          rs = ps.executeQuery();
          
          while(rs.next()) {
            tot = rs.getInt(1);
          }
                    
      }catch(SQLException e){
          System.out.println (e.getMessage());
          e.printStackTrace();
          closeConnection();
      }  finally{
            closeConnection();
        }
        
        return tot;
  }

  public Vector<TypeFlussoIav> getListaFlussi() throws CustomException,
                                                  RemoteException,
                                                  SQLException {
        
        Vector<TypeFlussoIav> eccOpeIav = new Vector<TypeFlussoIav>();

        try{
        
            conn = getConnection(dsName);
            ps = conn.prepareStatement(queryGetAllFlusso);
            rs = ps.executeQuery();
            while(rs.next()) {
                    TypeFlussoIav acquistiIav =  new TypeFlussoIav();
                    acquistiIav.setType(rs.getString("TIPO_FLUSSO"));
                    acquistiIav.setDescr(rs.getString("DESCRIPTION"));              
                    eccOpeIav.add(acquistiIav);
            } 
            
        }catch(SQLException e){
	
        System.out.println (e.getMessage());
        e.printStackTrace();
        closeConnection();
       throw new CustomException(e.toString(),"Errore Query alla tabella I5_5IAV_TIPI_FLUSSO","getListaFlussi","I5_1CONTR",StaticContext.FindExceptionType(e));    
        } finally{
            closeConnection();
        }
    
	return eccOpeIav;
  }  
  
 
  
  private void closeConnection() throws SQLException {
      try{
          if (rs != null){
                    rs.close();
                  }
            ps.close();
          conn.close();
      }catch (SQLException e){
          
      }
  }
  
    public Vector<TypeFlussoIav> getListaServizi() throws CustomException,
                                                      RemoteException,
                                                      SQLException {
            
            Vector<TypeFlussoIav> listServiziIAV = new Vector<TypeFlussoIav>();

            try{
            
                conn = getConnection(dsName);
                ps = conn.prepareStatement(queryGetAllServizi);
                rs = ps.executeQuery();
                while(rs.next()) {
                        TypeFlussoIav listServiziIAVarr =  new TypeFlussoIav();
                        listServiziIAVarr.setType(rs.getString("CODE_SERVIZIO"));
                        listServiziIAVarr.setDescr(rs.getString("DESCRIZIONE_SERVIZIO"));              
                        listServiziIAV.add(listServiziIAVarr);
                } 
                
            }catch(SQLException e){
            
            System.out.println (e.getMessage());
            e.printStackTrace();
            closeConnection();
           throw new CustomException(e.toString(),"Errore Query alla tabella I5_5IAV_SERVIZI","getListaServizi","",StaticContext.FindExceptionType(e));    
            } finally{
                closeConnection();
            }
        
            return listServiziIAV;
      }  
      
      public Vector<TypeFlussoIav> getListaOperatori() throws CustomException,
                                                        RemoteException,
                                                        SQLException {
              
              Vector<TypeFlussoIav> listOperatoriIAV = new Vector<TypeFlussoIav>();

              try{
              
                  conn = getConnection(dsName);
                  ps = conn.prepareStatement(queryGetAllOperatori);
                  rs = ps.executeQuery();
                  while(rs.next()) {
                          TypeFlussoIav listOperatoriIAVarr =  new TypeFlussoIav();
                          listOperatoriIAVarr.setType(rs.getString("CODE_GEST"));
                          listOperatoriIAVarr.setDescr(rs.getString("DESCRIZIONE_OLO"));              
                          listOperatoriIAV.add(listOperatoriIAVarr);
                  } 
                  
              }catch(SQLException e){
              
              System.out.println (e.getMessage());
              e.printStackTrace();
              closeConnection();
             throw new CustomException(e.toString(),"Errore Query alla tabella I5_5IAV_TRASCOD_OPERATORE","getListaOperatore","",StaticContext.FindExceptionType(e));    
              } finally{
                  closeConnection();
              }
          
              return listOperatoriIAV;
        }  
        
    public Vector<TypeFlussoIav> getFatrzCycle(String serviziIav, String operatoreIav) throws CustomException,
                                                      RemoteException,
                                                      SQLException {
            
            Vector<TypeFlussoIav> listFatrzIav = new Vector<TypeFlussoIav>();
                        
                     
            String queryWhere="";           
                       
            String queryGetFatrzByServizi=          
              "SELECT TO_CHAR(PV.DATA_INIZIO_PERIODO, 'dd/mm/yyyy') AS DATA_INIZIO,TO_CHAR(PV.DATA_FINE_PERIODO, 'dd/mm/yyyy') AS DATA_FINE "+
//              "FROM PARAM_VALORIZ PV "+
              "FROM I5_2PARAM_VALORIZ_SP PV "+
              "INNER JOIN I5_1ACCOUNT AC ON TO_CHAR(PV.CODE_ACCOUNT) = AC.CODE_ACCOUNT "+
              "INNER JOIN I5_5IAV_TRASCOD_OPERATORE OP ON OP.CODE_GEST = AC.CODE_GEST ";
            
            if(operatoreIav.equals("TUTTI") || operatoreIav.equals(null)){
                
                queryWhere="WHERE PV.DATA_INIZIO_PERIODO IS NOT NULL AND PV.DATA_FINE_PERIODO IS NOT NULL";
                
            }else{
                
                queryWhere="WHERE PV.DATA_INIZIO_PERIODO IS NOT NULL AND PV.DATA_FINE_PERIODO IS NOT NULL AND AC.CODE_GEST = '"+ operatoreIav +"'";
                
            }
            
            queryGetFatrzByServizi=queryGetFatrzByServizi+queryWhere;

            try{
            
                conn = getConnection(dsName);
                ps = conn.prepareStatement(queryGetFatrzByServizi);
                rs = ps.executeQuery();
                while(rs.next()) {
                        TypeFlussoIav listFatrzIavArr =  new TypeFlussoIav();
                        listFatrzIavArr.setType(rs.getString("DATA_INIZIO"));
                        listFatrzIavArr.setDescr(rs.getString("DATA_FINE"));              
                        listFatrzIav.add(listFatrzIavArr);
                } 
                
            }catch(SQLException e){
            
            System.out.println (e.getMessage());
            e.printStackTrace();
            closeConnection();
           throw new CustomException(e.toString(),"Errore Query alla tabella Fatrz","getFatrzList","",StaticContext.FindExceptionType(e));    
            } finally{
                closeConnection();
            }
        
            return listFatrzIav;
      }  
        
    public Boolean alterExceptionOpe(String SelOf, String input) throws SQLException,
                                                                                 RemoteException {
        Boolean result=true;
        tableName="I5_5IAV_ECC_VAL_OPERATORI";
        /*
        if(endDate2.equals(null))
                endDate2="";
        
        String queryInsertExceOpe="INSERT INTO "+tableName+" (ID_REGOLA, DATA_RIFERIMENTO_DA, DATA_RIFERIMENTO_A, DATA_INIZIO_VAL, DATA_FINE_VAL,  AMBITO, SERVIZIO_IAV, NOMEOLO, NOTE, DESCRIZIONE_UTENTE, DATA_INS, DATA_UPD) "+" VALUES (SEQ_REG_OPE.NEXTVAL,' "+ startDate +" ',' "+ startDate2 +" ',' "+ endDate +" ',' "+ endDate2 +" ',' "+ ambitoIav +" ',' "+ serviziIav +" ',' "+ operatoreIav +" ',' "+ note +" ',' "+ motivazioneBlocco +" ',sysdate,sysdate)";
        */
        String queryAlterOpe="UPDATE "+tableName+" SET DATA_FINE_VAL ='"+input+"',  DATA_UPD=sysdate WHERE ID_REGOLA='"+SelOf+"'";
        
        System.out.println(queryAlterOpe);
        
        try{
          
          conn = getConnection(dsName);                           
          Statement st = conn.createStatement();           
          st.executeUpdate(queryAlterOpe);         
        
            
        }catch(SQLException e){
        
                //JOptionPane.showMessageDialog(null, "Errore Generico!", "InfoWindow", JOptionPane.ERROR_MESSAGE);
                System.out.println (e.getMessage());
                e.printStackTrace();
                closeConnection();
                result=false;
                
            }  finally{
            
                  //JOptionPane.showMessageDialog(null, "Operazione eseguita con successo!", "InfoWindow", JOptionPane.INFORMATION_MESSAGE);
                  closeConnection();
                  
              }
       
        return result;
    }
    
    public String getPathJPUB2Download() throws SQLException,
                                                                            RemoteException {
        String result = "";

        String queryOpeWithInput="SELECT PATH FROM J2_DOWNLOAD_PARAM WHERE CODICE_FUNZIONE='DOWNLOAD_JPUB2'";
           
        System.out.println(queryOpeWithInput);
        
         try{
           
           conn = getConnection(dsName);               
           ps = conn.prepareStatement(queryOpeWithInput);          
           rs = ps.executeQuery();            

           while(rs.next()) {
                result = rs.getString("PATH");
           }
           
            System.out.println(result);

           }catch(SQLException e){
               System.out.println (e.getMessage());
               e.printStackTrace();
               closeConnection();
           }  finally{
                 closeConnection();
             }
        
        return result;                                                        
    }
    
    public ValorPathModel getInfoFromType(String type)throws RemoteException,
                                                      SQLException{
                                                      
        ValorPathModel result = new ValorPathModel();
        
        try{
            
            conn = getConnection(dsName);
            
            String query =queryAnagraficaBatch +  " WHERE D.TIPO_FUNZ = '" + type + "'";
            
            
            System.out.println("QUERY: " +  query);
            
            ps = conn.prepareStatement(query);
                        
            rs = ps.executeQuery();
            
            rs.next();
                        
            result.setCode( rs.getString("TIPO_FUNZ") ) ;
            result.setDescr(rs.getString("DESC_FUNZ"));
            result.setExtFile(rs.getString("ESTENSIONE_FILE"));
            result.setExtFileStorico(rs.getString("ESTENSIONE_FILE_STORICO"));
            result.setPathZip(rs.getString("PATH_FILE_ZIP"));
            result.setPathStorico(rs.getString("PATH_REPORT_STORICI"));
            
        }catch(SQLException e){
                System.out.println (e.getMessage());
                e.printStackTrace();
                closeConnection();
            }  finally{
                  closeConnection();
              }
              
              return result;
    }
    


}