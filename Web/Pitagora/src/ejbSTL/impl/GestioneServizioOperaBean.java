package com.ejbSTL.impl;

import com.ejbBMP.DatiCliBMPPK;

import com.ejbSTL.TypeVerCiclo;
import com.ejbSTL.TypeServizi;
import com.ejbSTL.TypeAccount;
import com.ejbSTL.TypeDescrizione;
import com.ejbSTL.TypeBatch;
import com.ejbSTL.TypeElaborati;

import com.model.ValorPathModel;

import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.util.*;

import java.util.Vector;
import java.rmi.RemoteException;
import java.sql.*;
import oracle.jdbc.OracleTypes;
import com.utl.*;

import javax.ejb.FinderException;

import oracle.jdbc.OracleCallableStatement;

import oracle.sql.ARRAY;
import oracle.sql.ArrayDescriptor;
import oracle.sql.Datum;
import oracle.sql.STRUCT;

public class GestioneServizioOperaBean extends AbstractClassicEJB implements SessionBean 
{

    private Connection conn=null;
    private CallableStatement cs = null;
    private PreparedStatement ps = null;
    private ResultSet rs=null;
    
//    private static final String queryGetVerCiclo = "select to_char(data_da,'mmyyyy')  as CICLO from I5_2DETT_DOCUM_FATT_XDSL union select to_char(data_da,'mmyyyy')  as CICLO from I5_2DETT_DOCUM_FATT_XDSL order by CICLO desc ";  
//    private static final String queryGetVerCiclo = "select to_char(ciclo_fatrz,'mmyyyy') as CICLO from I5_2OPERA_FT union select to_char(ciclo_fatrz,'mmyyyy') as CICLO from I5_2OPERA_NC order by CICLO desc ";  

    private String tableName = null;
    private String tableName_err = null;
    private String stagingProvisioningHEaders = null;

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
  
  public Vector<TypeVerCiclo> queryGetVerCiclo() throws CustomException,
                                                  RemoteException,
                                                  SQLException {
        
        Vector<TypeVerCiclo> listVerCiclo = new Vector<TypeVerCiclo>();

        try{
        
            conn = getConnection(dsName);

            String queryGetVerCiclo = "select distinct to_char(c.data_inizio_ciclo_fatrz,'mmyyyy') as CICLO " +
            " from i5_2elab_batch a, I5_2PARAM_PROCESSI b, I5_2PARAM_VALORIZ_SP c, i5_1account_x_contr d, i5_1contr e, i5_1tipo_contr f " +
            " where a.code_funz in ('PV_OPERA','PR_OPERA','FV_OPERA','FR_OPERA') " + 
            " and a.code_elab = b.code_elab " +
            " and b.code_param = c.code_param " +
            " and b.code_account = d.code_account " +
            " and d.code_contr = e.code_contr " +
            " and E.FLAG_SYS = 'S' " + 
            " and e.code_tipo_contr = f.code_tipo_contr " + 
            " ORDER BY CICLO desc "; 
            
            ps = conn.prepareStatement(queryGetVerCiclo);
            rs = ps.executeQuery();
            while(rs.next()) {
                    TypeVerCiclo VerCiclo =  new TypeVerCiclo();
                    VerCiclo.setCiclo(rs.getString("CICLO"));
                    listVerCiclo.add(VerCiclo);
            } 
            
        }catch(SQLException e){
	
        System.out.println (e.getMessage());
        e.printStackTrace();
        closeConnection();
       throw new CustomException(e.toString(),"Errore Query alla tabella i5_2elab_batch","queryGetVerCiclo","i5_2elab_batch",StaticContext.FindExceptionType(e));    
        } finally{
            closeConnection();
        }
    
	return listVerCiclo;
  }  

    public Vector<TypeServizi> queryGetServizi(String provenienza) throws CustomException,
                                                    RemoteException,
                                                    SQLException {
          
          Vector<TypeServizi> listServizi = new Vector<TypeServizi>();

          try{
          
              conn = getConnection(dsName);
              String queryGetServizi = "";
              if (provenienza.equals("lancio")){
                    //R1I-21-0101 54,55,56
                  queryGetServizi = "select code_tipo_contr, desc_tipo_contr from I5_1TIPO_CONTR where code_tipo_contr in (8,9,37,17,41,23,52,1,13,21,38,42,44,48,47,50,51,53,60,61,54,55,56) and flag_sys = 'S' ";  
              } else {
                  queryGetServizi = "select distinct f.code_tipo_contr as code_tipo_contr, F.DESC_TIPO_CONTR as desc_tipo_contr " +
                  " from i5_2elab_batch a, I5_2PARAM_PROCESSI b, I5_2PARAM_VALORIZ_SP c, i5_1account_x_contr d, i5_1contr e, i5_1tipo_contr f " +
                  " where a.code_funz in ('PV_OPERA','PR_OPERA','FV_OPERA','FR_OPERA') " + 
                  " and a.code_elab = b.code_elab " +
                  " and b.code_param = c.code_param " +
                  " and b.code_account = d.code_account " +
                  " and d.code_contr = e.code_contr " +
                  " and E.FLAG_SYS = 'S' " + 
                  " and e.flag_sys = f.flag_sys " + 
                  " and e.code_tipo_contr = f.code_tipo_contr " + 
                  " ORDER BY f.desc_tipo_contr "; 
             }

              ps = conn.prepareStatement(queryGetServizi);
              rs = ps.executeQuery();
              while(rs.next()) {
                      TypeServizi VerServizi =  new TypeServizi();
                      VerServizi.setCode(rs.getString("code_tipo_contr"));
                      VerServizi.setDesc(rs.getString("desc_tipo_contr"));
                      listServizi.add(VerServizi);
              } 
              
          }catch(SQLException e){
          
          System.out.println (e.getMessage());
          e.printStackTrace();
          closeConnection();
         throw new CustomException(e.toString(),"Errore Query alla tabella I5_2OPERA_FT","queryGetVerCiclo","I5_2OPERA_FT",StaticContext.FindExceptionType(e));    
          } finally{
              closeConnection();
          }
      
          return listServizi;
    }  
    
    public Vector<TypeAccount> queryGetAccount(String code_tipo_contr, String ciclo, String flag, String codetipoelab) throws CustomException,
                                                    RemoteException,
                                                    SQLException {
          
          Vector<TypeAccount> listAccount = new Vector<TypeAccount>();

          try{
          
              conn = getConnection(dsName);

//              String queryGetAccount = "SELECT B.CODE_ACCOUNT as code_account, DESC_ACCOUNT " +
/*              String queryGetAccount = "SELECT A.CODE_PARAM as code_account, DESC_ACCOUNT " +
              " FROM I5_2PARAM_VALORIZ_SP A, I5_1ACCOUNT B, I5_1ACCOUNT_X_CONTR C, I5_1CONTR D " +
              " WHERE CODE_ELAB IS NOT NULL " + 
              " AND A.CODE_ACCOUNT = B.CODE_ACCOUNT " +
              " AND B.FLAG_SYS = 'S' " +
              " AND B.CODE_ACCOUNT = C.CODE_ACCOUNT " +
              " AND C.CODE_CONTR = D.CODE_CONTR " +
              " AND D.CODE_TIPO_CONTR = " + code_tipo_contr +
              " AND C.FLAG_SYS = 'S' " +
              " AND D.FLAG_SYS = 'S' " +
              " AND to_char(a.data_inizio_ciclo_fatrz,'mmyyyy') = '" + ciclo + "' " + 
              " ORDER BY B.DESC_ACCOUNT";  
*/
              String queryGetAccount = "";
              String codetipoelaborazione = "";
              if (codetipoelab.equals("valorizzazione")) {
                 codetipoelaborazione = "V";
              } else {
                     codetipoelaborazione = "R";
              }

              if (flag.equals("0")) {
                  queryGetAccount = "SELECT distinct A.CODE_PARAM as code_account, DESC_ACCOUNT " +
                  " FROM I5_2PARAM_VALORIZ_SP A, I5_1ACCOUNT B, I5_1ACCOUNT_X_CONTR C, I5_1CONTR D, i5_2param_processi p " +
                  " WHERE a.code_param = p.code_param  " + 
                  " AND p.code_elab is not null " +
                  " AND p.code_funz in ('21','26') " +
                  " AND A.CODE_ACCOUNT = B.CODE_ACCOUNT " +
                  " AND B.FLAG_SYS = 'S' " +
                  " AND B.CODE_ACCOUNT = C.CODE_ACCOUNT " +
                  " AND C.CODE_CONTR = D.CODE_CONTR " +
                  " AND D.CODE_TIPO_CONTR = " + code_tipo_contr +
                  " AND C.FLAG_SYS = 'S' " +
                  " AND D.FLAG_SYS = 'S' " +
                  " AND to_char(a.data_inizio_ciclo_fatrz,'mmyyyy') = '" + ciclo + "' " + 
                  " ORDER BY B.DESC_ACCOUNT";  
              } else {
                  queryGetAccount = "SELECT distinct A.CODE_PARAM as code_account, DESC_ACCOUNT " +
                  " FROM I5_1CONTR D, I5_2PARAM_VALORIZ_SP A, I5_1ACCOUNT B, I5_1ACCOUNT_X_CONTR C, i5_2param_processi p " +
                  " WHERE  " + 
                  "     D.CODE_TIPO_CONTR = " + code_tipo_contr +
                  " AND a.code_param = p.code_param " +
                  " AND p.code_elab is not null " +
                  " AND p.code_funz in ('21','26') " +
                  " AND A.CODE_ACCOUNT = B.CODE_ACCOUNT " +
                  " AND B.FLAG_SYS = 'S' " +
                  " AND B.CODE_ACCOUNT = C.CODE_ACCOUNT " +
                  " AND C.CODE_CONTR = D.CODE_CONTR " +
                  " AND C.FLAG_SYS = 'S' " +
                  " AND D.FLAG_SYS = 'S' " +
                  " AND a.data_inizio_ciclo_fatrz = to_date('01" + ciclo + "','ddmmyyyy') " + 
                  " and ((exists (select o.account from i5_2opera_ft o " +
                  "             where a.code_account = o.account " +
                  "               and d.code_tipo_contr = o.code_tipo_contr " +
                  "               and o.tipo_pricing = '" + codetipoelaborazione + "' " +
                  "               and a.data_inizio_ciclo_fatrz = o.ciclo_fatrz)) " +
                  "     or " +
                  "     (exists (select o.account from i5_2opera_nc o " + 
                  "             where a.code_account = o.account " +
                  "               and d.code_tipo_contr = o.code_tipo_contr " +
                  "               and o.tipo_pricing = '" + codetipoelaborazione + "' " +
                  "               and a.data_inizio_ciclo_fatrz = o.ciclo_fatrz)) " +                    
                  "     ) " +
                  " ORDER BY B.DESC_ACCOUNT";  
              }
              
              ps = conn.prepareStatement(queryGetAccount);
              rs = ps.executeQuery();
              while(rs.next()) {
                      TypeAccount VerAccount =  new TypeAccount();
                      VerAccount.setCode(rs.getString("code_account"));
                      VerAccount.setDesc(rs.getString("desc_account"));
                      listAccount.add(VerAccount);
              } 
              
          }catch(SQLException e){
          
          System.out.println (e.getMessage());
          e.printStackTrace();
          closeConnection();
         throw new CustomException(e.toString(),"Errore Query alla tabella I5_1ACCOUNT","queryGetAccount","I5_1ACCOUNT",StaticContext.FindExceptionType(e));    
          } finally{
              closeConnection();
          }
      
          return listAccount;
  }    
 
    public Vector<TypeDescrizione> queryGetDescrizione(String code_tipo_contr) throws CustomException,
                                                    RemoteException,
                                                    SQLException {
          
          Vector<TypeDescrizione> listDescrizione = new Vector<TypeDescrizione>();

          try{
          
              conn = getConnection(dsName);

              String queryGetDescrizione = "SELECT DESC_TIPO_CONTR " +
              " FROM I5_1TIPO_CONTR " +
              " where CODE_TIPO_CONTR = " + code_tipo_contr     ;          
              ps = conn.prepareStatement(queryGetDescrizione);
              rs = ps.executeQuery();
              while(rs.next()) {
                      TypeDescrizione VerDescrizione =  new TypeDescrizione();
                      VerDescrizione.setDesc(rs.getString("DESC_TIPO_CONTR"));
                      listDescrizione.add(VerDescrizione);
              } 
              
          }catch(SQLException e){
          
          System.out.println (e.getMessage());
          e.printStackTrace();
          closeConnection();
         throw new CustomException(e.toString(),"Errore Query alla tabella I5_1TIPO_CONTR","queryGetAccount","I5_1TIPO_CONTR",StaticContext.FindExceptionType(e));    
          } finally{
              closeConnection();
          }
      
          return listDescrizione;
    }

    public Vector<TypeBatch> queryGetBatch(String code_funz, String ciclo, String code_tipo_contr) throws CustomException,
                                                    RemoteException,
                                                    SQLException {
          
          Vector<TypeBatch> listBatch = new Vector<TypeBatch>();

          try{
          
              conn = getConnection(dsName);
/*
              String queryGetBatch = "select a.code_elab as codice, to_char(a.data_ora_inizio_elab_batch,'dd/mm/yyyy hh:mm:ss') as inizio, to_char(a.data_ora_fine_elab_batch,'dd/mm/yyyy hh:mm:ss') as fine, code_stato_batch as stato, count(*) as valore " +
              " from i5_2elab_batch a, i5_2param_processi b, I5_2PARAM_VALORIZ_SP c, i5_1account_x_contr d, i5_1contr e, i5_1tipo_contr f " +
              " where a.code_funz in ('" + code_funz + "') " +
              " and a.code_elab = b.code_elab " +
              " and b.code_param = c.code_param " +
              " and b.code_account = d.code_account " +
              " and d.code_contr = e.code_contr " +
              " and E.FLAG_SYS = 'S' " +
              " and e.code_tipo_contr = '" + code_tipo_contr + "' " +
              " and to_char(c.data_inizio_ciclo_fatrz,'mmyyyy') = '" + ciclo + "' " +
              " group by  a.code_elab, a.data_ora_inizio_elab_batch, a.data_ora_fine_elab_batch, code_stato_batch, to_char(c.data_inizio_ciclo_fatrz,'mmyyyy') " +
              " order by a.data_ora_inizio_elab_batch desc ";
*/
                String queryGetBatch = " select a.code_elab as codice, to_char(a.data_ora_inizio_elab_batch,'dd/mm/yyyy hh24:mm:ss') as inizio, to_char(a.data_ora_fine_elab_batch,'dd/mm/yyyy hh24:mm:ss') as fine, code_stato_batch as stato, " +
                "  ( " +
                "      select count(*) from i5_2param_processi b, I5_2PARAM_VALORIZ_SP c  " +
                "                      where b.code_elab in (select code_elab from  i5_2elab_batch " +
                "                                           where code_funz in ('" + code_funz + "')) " +
                "                        and b.code_param = c.code_param " +
                "                        and to_char(c.data_inizio_ciclo_fatrz,'mmyyyy') = '" + ciclo + "' " +
                "                        and b.code_elab = a.code_elab " +
                "  ) as valore  " +
                "  from i5_2elab_batch a, i5_2param_processi b, I5_2PARAM_VALORIZ_SP c, i5_1account_x_contr d, i5_1contr e, i5_1tipo_contr f " +
                "  where a.code_funz in ('" + code_funz + "') " +
                "  and a.code_elab = b.code_elab " +
                "  and b.code_param = c.code_param " +
                "  and b.code_account = d.code_account " +
                "  and d.code_contr = e.code_contr " +
                "  and E.FLAG_SYS = 'S' " +
                "  and e.code_tipo_contr = '" + code_tipo_contr + "' " +
                "  and to_char(c.data_inizio_ciclo_fatrz,'mmyyyy') = '" + ciclo + "' " +
                "  group by  a.code_elab, to_char(a.data_ora_inizio_elab_batch,'dd/mm/yyyy hh24:mm:ss'), to_char(a.data_ora_fine_elab_batch,'dd/mm/yyyy hh24:mm:ss'), code_stato_batch " +
                "  order by inizio desc " ;
             
//              System.out.println (queryGetBatch);

              ps = conn.prepareStatement(queryGetBatch);
              rs = ps.executeQuery();
              while(rs.next()) {
                      TypeBatch VerBatch =  new TypeBatch();
                      VerBatch.setCodice(rs.getString("codice"));
                      VerBatch.setInizio(rs.getString("inizio"));
                      VerBatch.setFine(rs.getString("fine"));
                      VerBatch.setStato(rs.getString("stato"));
                      VerBatch.setValore(rs.getString("valore"));
                      listBatch.add(VerBatch);
              } 
              
          }catch(SQLException e){
          
          System.out.println (e.getMessage());
          e.printStackTrace();
          closeConnection();
         throw new CustomException(e.toString(),"Errore Query alla tabella I5_1TIPO_CONTR","queryGetAccount","I5_1TIPO_CONTR",StaticContext.FindExceptionType(e));    
          } finally{
              closeConnection();
          }
      
          return listBatch;
    }
    
    public Vector<TypeElaborati> queryGetElaborati(String code_elab) throws CustomException,
                                                    RemoteException,
                                                    SQLException {
          
          Vector<TypeElaborati> listElaborati = new Vector<TypeElaborati>();

          try{
          
              conn = getConnection(dsName);

              String queryGetElaborati = "select A.CODE_PARAM_PROC as codice, a.code_stato_proc as stato, B.DESC_ACCOUNT as account, to_char(a.data_inizio,'dd/mm/yyyy hh24:mm:ss') as inizio, to_char(a.data_fine,'dd/mm/yyyy hh24:mm:ss') as fine " +
              " from i5_2param_processi a, i5_1account b " +
              " where code_elab = '" + code_elab + "' " +
              " and a.code_account = b.code_account ";

             
              ps = conn.prepareStatement(queryGetElaborati);
              rs = ps.executeQuery();
              while(rs.next()) {
                      TypeElaborati VerElaborati =  new TypeElaborati();
                      VerElaborati.setCodice(rs.getString("codice"));
                      VerElaborati.setInizio(rs.getString("inizio"));
                      VerElaborati.setFine(rs.getString("fine"));
                      VerElaborati.setStato(rs.getString("stato"));
                      VerElaborati.setAccount(rs.getString("account"));
                      listElaborati.add(VerElaborati);
              } 
              
          }catch(SQLException e){
          
          System.out.println (e.getMessage());
          e.printStackTrace();
          closeConnection();
         throw new CustomException(e.toString(),"Errore Query alla tabella i5_2param_processi","queryGetElaborati","i5_2param_processi",StaticContext.FindExceptionType(e));    
          } finally{
              closeConnection();
          }
      
          return listElaborati;
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

}
