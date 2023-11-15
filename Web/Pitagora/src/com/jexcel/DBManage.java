package com.jexcel;

import java.sql.*;
import java.util.*;
import com.utl.*;

import java.sql.*;
import javax.naming.*;
import javax.sql.DataSource;

public class DBManage
{
  public DBManage(){}
    
/*
  public static Connection openCon(Properties pr){
        Connection con=null;
        try {
          //Class.forName(pr.getProperty("DBDRIVER"));
          Class.forName(StaticContext.JEXCEL_DBDRIVER);
          con = java.sql.DriverManager.getConnection(StaticContext.JEXCEL_DBURL,StaticContext.JEXCEL_DBUSR,StaticContext.JEXCEL_DBPWD);
          //con = java.sql.DriverManager.getConnection(pr.getProperty("DBURL"),pr.getProperty("DBUSR"),pr.getProperty("DBPWD"));
        }catch(Exception ex){
          System.out.println("DBManage.openCon: "+ex.toString());
        }
        return con;
    }
*/
  public static void closeCon(Connection con) {
        try {
          if (con!=null) con.close();
        }catch(Exception ex){
          System.out.println("Exception DBManage.openCon: "+ex.toString());
        }
  }

  // key: userID, value: User Object
 public static Hashtable getUsers(Connection con, String tipo_tracciamento){
  Statement st = null;
  ResultSet rs = null;
  Hashtable h = new Hashtable();
  Vector v = new Vector();
  String whereCondition = "";
  if(tipo_tracciamento.equals("DEL_152_02_CONS")){
    whereCondition = " AND CODE_PROF_UTENTE <> 'UTE' ";
  }
  
  try {
    st = con.createStatement();
    //rs = st.executeQuery("SELECT code_utente userID, nome_cogn_utente cogn_nome, code_prof_abil profilo, code_unita_organiz funzione, NULL dataDisabilitazione, to_char(date_pwd_upd ,'dd/mm/yyyy') dataAbilitazione FROM i5_6anag_utente where FLAG_DISABLED='N' order by userID");
    rs = st.executeQuery("SELECT * FROM (SELECT code_utente userID, nome_cogn_utente cogn_nome, code_prof_abil profilo, code_unita_organiz funzione, "+
                                               "to_char(date_end ,'dd/mm/yyyy') dataDisabilitazione, to_char(date_start ,'dd/mm/yyyy') dataAbilitazione, "+
                                               "nome_utente, cogn_utente "+
                                          "FROM i5_6anag_utente "+
                                         "WHERE FLAG_DISABLED = 'S' "+
                                           "AND DATE_END BETWEEN ADD_MONTHS(SYSDATE,-6) AND SYSDATE "+
                                           whereCondition+
                                        "UNION "+
                                        "SELECT code_utente userID, nome_cogn_utente cogn_nome, code_prof_abil profilo, code_unita_organiz funzione, "+
                                               "NULL dataDisabilitazione, to_char(date_start ,'dd/mm/yyyy') dataAbilitazione, "+
                                               "nome_utente, cogn_utente "+
                                          "FROM i5_6anag_utente "+
                                         "WHERE FLAG_DISABLED='N' "+
                                           whereCondition +") "+ 
                                     "UT_ABIL_DISABIL "+
                                "ORDER BY USERID");
    User u = null;
    String cogn_app = null;
    while(rs.next()){
      u = new User();
      u.setUserID(rs.getString("userID"));
      /*
      u.setCognome("????");
      u.setNome("????");
      */
      u.setCognome(rs.getString("cogn_utente"));
      u.setNome(rs.getString("nome_utente"));
          
      /*
      try {
        StringTokenizer stz = new StringTokenizer(rs.getString("cogn_nome"), " ");
        u.setCognome(stz.nextToken());
        u.setNome(stz.nextToken());
        if(stz.hasMoreTokens()){
          cogn_app = u.getCognome();
          cogn_app = cogn_app + " " + u.getNome();
          u.setCognome(cogn_app);
          u.setNome(stz.nextToken());
        }
      }catch(Exception ex){} 
      */
      u.setDataAbilitazione(rs.getString("dataAbilitazione"));
      u.setDataDisabilitazione(rs.getString("dataDisabilitazione"));
      u.setProfilo(rs.getString("profilo"));
      u.setFunzione(rs.getString("funzione"));
      h.put(u.getUserID(), u);
    }
  }catch(Exception ex){
          System.out.println("Exception DBManage.getUsers: "+ex.toString());
  }finally {
    try {
      if (rs!=null) rs.close();
      if (st!=null) st.close();
    }catch(Exception ex){}
  }
  return h;     
 }

 public static String getDate(Connection con){
  Statement st = null;
  ResultSet rs = null;
  String dataServer = null;
  try {
    st = con.createStatement();
    //rs = st.executeQuery("SELECT code_utente userID, nome_cogn_utente cogn_nome, code_prof_abil profilo, code_unita_organiz funzione, NULL dataDisabilitazione, to_char(date_pwd_upd ,'dd/mm/yyyy') dataAbilitazione FROM i5_6anag_utente where FLAG_DISABLED='N' order by userID");
    rs = st.executeQuery("SELECT TO_CHAR(SYSDATE,'dd/mm/yyyy hh:mi:ss') AS DATA_SISTEMA FROM DUAL");
    while(rs.next()){
      dataServer = rs.getString("DATA_SISTEMA");
      //System.out.println("rs.getString ["+rs.getString("DATA_SISTEMA")+"]");
      //System.out.println("dataServer DB ["+dataServer+"]");      
    }
  }catch(Exception ex){
          System.out.println("Exception DBManage.getDate: "+ex.toString());
  }finally {
    try {
      if (rs!=null) rs.close();
      if (st!=null) st.close();
    }catch(Exception ex){}
  }
  return dataServer;     
 }

 public static String getDateMinusOrPlusMonth(Connection con, int month){
  Statement st = null;
  ResultSet rs = null;
  String dataServer = null;
  try {
    st = con.createStatement();
    //rs = st.executeQuery("SELECT code_utente userID, nome_cogn_utente cogn_nome, code_prof_abil profilo, code_unita_organiz funzione, NULL dataDisabilitazione, to_char(date_pwd_upd ,'dd/mm/yyyy') dataAbilitazione FROM i5_6anag_utente where FLAG_DISABLED='N' order by userID");
    rs = st.executeQuery("SELECT TO_CHAR(add_months(SYSDATE,"+month+"),'dd/mm/yyyy hh:mi:ss') AS DATA_SISTEMA FROM DUAL");
    while(rs.next()){
      dataServer = rs.getString("DATA_SISTEMA");
      //System.out.println("rs.getString ["+rs.getString("DATA_SISTEMA")+"]");
      //System.out.println("dataServer DB ["+dataServer+"]");      
    }
  }catch(Exception ex){
          System.out.println("Exception DBManage.getDate: "+ex.toString());
  }finally {
    try {
      if (rs!=null) rs.close();
      if (st!=null) st.close();
    }catch(Exception ex){}
  }
  return dataServer;     
 }

 public static Connection getConnection(String DataSourceName) throws Exception {
    try {
      return ((DataSource)new InitialContext().lookup(DataSourceName)).getConnection();
    }
    catch (SQLException e) {
      throw e;
    }
    catch (NamingException e) {      
      throw e;
    }
  }

  // key: userID, value: User Object
 public static Hashtable getUsersProfileBackup(Connection con, String code_utente, String data_inizio_accesso, String data_fine_accesso){
  Statement st = null;
  ResultSet rs = null;
  Hashtable h = new Hashtable();
  Vector v = new Vector();

  if(data_inizio_accesso == null || data_inizio_accesso.equals("")){
    data_fine_accesso = DBManage.getDate(con);
  }
  
  try {
    st = con.createStatement();
    /*
    rs = st.executeQuery("SELECT CODE_PROF_ABIL "+
                         "FROM i5_6anag_prof_utente "+
                         "WHERE code_utente = '"+code_utente+"' "+
                         "AND to_date('"+data_inizio_accesso+"','dd/mm/yyyy hh24:mi:ss') <= data_update "+ 
                         "and to_date('"+data_fine_accesso+"','dd/mm/yyyy hh24:mi:ss') <= data_update "+
                         "and rownum < 2");
    */

    rs = st.executeQuery("SELECT CODE_PROF_ABIL FROM I5_6ANAG_PROF_UTENTE "+
                          "WHERE CODE_UTENTE = '"+code_utente+"' "+
                          "AND data_update = (SELECT MIN(DATA_UPDATE) "+
                          "FROM i5_6anag_prof_utente "+
                          "WHERE code_utente = '"+code_utente+"' "+
                          "AND TO_DATE ('"+data_fine_accesso+"', 'dd/mm/yyyy hh24:mi:ss') <= DATA_UPDATE)");
    User u = null;
    String cogn_app = null;
    while(rs.next()){
      u = new User();
      u.setUserID(code_utente);    
      u.setProfilo(rs.getString("CODE_PROF_ABIL"));
      /*data_fine_accesso utilizzata come data_update profilo utente */
      h.put(u.getUserID(), u);
    }
  }catch(Exception ex){
          System.out.println("Exception DBManage.getUsersProfileBackup: "+ex.toString());
  }finally {
    try {
      if (rs!=null) rs.close();
      if (st!=null) st.close();
    }catch(Exception ex){}
  }
  return h;     
 }

 
}
