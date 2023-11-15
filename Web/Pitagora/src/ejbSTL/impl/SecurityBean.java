package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import javax.ejb.FinderException;
import java.sql.Connection;
import java.sql.CallableStatement;
import java.sql.Types;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.rmi.RemoteException;
import java.util.Vector;
import java.lang.*;
import com.utl.StaticContext;
import com.utl.SecurityInfoTransf;
import com.utl.CustomException;

import com.utl.I5_6anag_utenteROW;
import com.utl.ClassDatiTop;
import oracle.jdbc.OracleTypes;

public class SecurityBean extends com.utl.AbstractSessionCommonBean implements SessionBean 
{

    private static final String findByPK = "{? = call "+StaticContext.PACKAGE_COMMON+".I5_6ANAG_UTENTEfindByPk(?) }";
    private static final String findAllI5_6MEM_FUNZ_PROF_OP_EL = "{? = call "+StaticContext.PACKAGE_COMMON+".I5_6MEM_FUNZ_PROF_OP_ELfindAll(?,?) }";
    private static final String I5_6CHK_SCAD_PWD = "{? = call "+StaticContext.PACKAGE_COMMON+".I5_6CHK_SCAD_PWD(?,?)}";
    private static final String I5_6CHK_PARAM = "{? = call "+StaticContext.PACKAGE_COMMON+".I5_6CHK_PARAM()}";
    private static final String aggiornaTNTLogin = "{? = call " + StaticContext.PACKAGE_COMMON +".I5_6ANAG_UTENTEaggiornaTNT(?,?) }";
    private static final String disabilitaUtente = "{? = call " + StaticContext.PACKAGE_COMMON +".I5_6ANAG_UTENTEdisabilita(?) }";
    private static final String aggiornaLogin = "{? = call " + StaticContext.PACKAGE_COMMON +".I5_6ANAG_UTENTEaggiornaLogin(?,?,?) }";
    private static final String findDataTop = "{? = call "+StaticContext.PACKAGE_COMMON+".datiIntestazione_instance_host(?,?)}";
    private static final String findLdapIP = "{? = call " + StaticContext.PACKAGE_COMMON +".LDAP_PARAMETER_IP() }";
    private static final String findLdapRO = "{? = call " + StaticContext.PACKAGE_COMMON +".LDAP_PARAMETER_ROOT() }";    
    
    public Vector findAllOpEl(String sProfile,String sCodeFunz) throws CustomException,RemoteException

  {
      Connection conn=null;
      CallableStatement cs = null;

      Vector recs = new Vector();

      try
      {
        conn = getConnection(StaticContext.DSNAME);
        cs = conn.prepareCall(findAllI5_6MEM_FUNZ_PROF_OP_EL);
        cs.registerOutParameter(1, OracleTypes.CURSOR);
        cs.setString(2,sProfile);
        cs.setString(3,sCodeFunz);

        cs.execute();
        ResultSet rs = (ResultSet)cs.getObject(1);

        if (rs.next()==false)
          recs=null; // faccio puntare a null il vettore .... Questo mi ridirige il client sulla maschera di login. 
        else 
        {
          do
          {
              SecurityInfoTransf mySecInfo=new SecurityInfoTransf();
              mySecInfo.setCode_op_elem(rs.getString("DESC_OP_ELEM"));
              mySecInfo.setDesc_label(rs.getString("DESC_LABEL"));
              mySecInfo.setCode_op_exec(rs.getString("CODE_OP_EXEC"));
              recs.add(mySecInfo);
          } 
          while (rs.next());
        }
        cs.close();
        conn.close();
        return recs;
      } 
      catch(Exception e)
      { 
        try
        {
          
          if (cs != null)
            cs.close();
          if (conn!=null)
            conn.close();
        }
        catch(Exception ex)
        {
          System.out.println (e.getMessage());
          e.printStackTrace();
        }
        throw new CustomException(e.toString(),"Errore di accesso alla tabella della sicurezza","findAllOpEl","SecurityBean",StaticContext.FindExceptionType(e));
      }
  }

	public I5_6anag_utenteROW findByPK(String sCodeUser) throws CustomException,RemoteException,FinderException {
        Connection conn=null;
        CallableStatement cs = null;
        I5_6anag_utenteROW row = null;

        try {
            conn = getConnection(dsName);

            cs = conn.prepareCall(findByPK);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2,sCodeUser);
            cs.execute();

            ResultSet rs = (ResultSet)cs.getObject(1);         

            if(rs.next()) {
                row = new I5_6anag_utenteROW();
                row.setCode_utente(rs.getString("CODE_UTENTE"));
                row.setCode_prof_utente(rs.getString("CODE_PROF_UTENTE"));
                row.setCode_unita_organiz(rs.getString("CODE_UNITA_ORGANIZ"));
                row.setNome_cogn_utente(rs.getString("NOME_COGN_UTENTE"));
                row.setDate_end(rs.getDate("DATE_END"));
                row.setData_login(rs.getString("DATA_LOGIN"));
                row.setFlag_admin_ind(rs.getString("FLAG_ADMIN_IND"));        
                row.setflag_disabled(rs.getString("FLAG_DISABLED"));                
                row.setFlag_logged_in(rs.getString("FLAG_LOGGED_IN"));                
                row.setUniversal_number(rs.getString("UNIVERSAL_NUMBER"));
                row.setCode_unita_organiz(rs.getString("CODE_UNITA_ORGANIZ"));
                row.setCode_prof_abil(rs.getString("CODE_PROF_ABIL"));
                row.setBaseIDN_LDAP(rs.getString("DESC_BASE_IDN_LDAP"));
                row.setSearchIDN_LDAP(rs.getString("DESC_SEARCH_IDN_LDAP"));
                row.setDateStart(rs.getDate("DATE_START"));
                row.setNum_months_disabled(rs.getInt("NUM_MONTHS_DISABLE"));
                row.setDt_disable_not_access(rs.getDate("DT_DISABLE_NOT_ACCESS"));
                row.setNum_tnt_login(rs.getInt("NUM_LOGIN"));
                row.setflag_disabled_pwd_err(rs.getString("FLAG_DISABLED_PWD_ERR"));
            }
            cs.close();
            conn.close();
            return row;
        } catch(Exception e) {
            try {
                if (cs != null)
                  cs.close();
                if (conn!=null)
                    conn.close();
            } catch(Exception ex) {
                System.out.println (e.getMessage());
                e.printStackTrace();
            }
            throw new CustomException(e.toString(),
                                                       "Errore di accesso alla tabella degli utenti",
                                                       "findByPK",
                                                       "SecurityBean", 
                                                       StaticContext.FindExceptionType(e));
        }   
	}

  public int disabilita_utente(String sCodeUser) throws CustomException,RemoteException
  {
    Connection conn=null;
    CallableStatement cs = null;
    int esito =0;
    
    try
    {
      conn = getConnection(StaticContext.DSNAME);
      cs = conn.prepareCall(disabilitaUtente);
      cs.registerOutParameter(1, OracleTypes.NUMBER);
      cs.setString(2,sCodeUser);

      cs.execute();
      esito = cs.getInt(1);

      cs.close();
      conn.close();
    } 
    catch(Exception e)
    { 
      try
      {
        if (cs != null)
          cs.close();
        if (conn!=null)
          conn.close();
      }
      catch(Exception ex)
      {
        System.out.println (e.getMessage());
        e.printStackTrace();
      }
      throw new CustomException(e.toString(),"Errore di accesso alla tabella della sicurezza","disabilita_utente","SecurityBean",StaticContext.FindExceptionType(e));
    }
    return esito;
  }
  
  public String chk_param() throws CustomException,RemoteException
  {
      Connection conn=null;
      CallableStatement cs = null;
      String my_chk_param="";
      
      try
      {
        conn = getConnection(StaticContext.DSNAME);
        cs = conn.prepareCall(I5_6CHK_PARAM);
        cs.registerOutParameter(1, OracleTypes.VARCHAR);

        cs.execute();
        my_chk_param =(String) cs.getString(1);
        cs.close();
        conn.close();
        
      } 
      catch(Exception e)
      { 
        try
        {
          if (cs != null)
            cs.close();
          if (conn!=null)
            conn.close();
        }
        catch(Exception ex)
        {
          System.out.println (e.getMessage());
          e.printStackTrace();
        }
        throw new CustomException(e.toString(),"Errore di accesso alla tabella della sicurezza","chk_param","SecurityBean",StaticContext.FindExceptionType(e));
      }
      return my_chk_param;
  }

  public int aggiorna_login(String sCodeUser, String sMail, String sMobile) throws CustomException,RemoteException {
        Connection conn=null;
        CallableStatement cs = null;
        int esito =0;
        int app = 0;
        String carattere = "";
        String replaceMobile = "";
        if(sMobile != null){
          for (int app2 = 1; app<sMobile.length(); app2++){
            carattere = sMobile.substring(app,app2);
            if(carattere.equalsIgnoreCase("/") || 
               carattere.equalsIgnoreCase("-") ||
               carattere.equalsIgnoreCase(" ")){
                  //carattere da eliminare  
               }else{
                  replaceMobile = replaceMobile + carattere;
               }
            app = app2;
          }
        }
    
        try {
            conn = getConnection(StaticContext.DSNAME);

            cs = conn.prepareCall(aggiornaLogin);
            cs.registerOutParameter(1, OracleTypes.NUMBER);
            cs.setString(2,sCodeUser);
            cs.setString(3,sMail);
            cs.setString(4,replaceMobile);

            cs.execute();
            esito = cs.getInt(1);

            cs.close();
            conn.close();
            
        } catch(Exception e) { 
            try {
                if (cs != null)
                  cs.close();
                if (conn!=null)
                  conn.close();
            } catch(Exception ex) {
                System.out.println (e.getMessage());
                e.printStackTrace();
            }
            throw new CustomException(e.toString(),
                                                     "Errore di accesso alla tabella della sicurezza",
                                                     "aggiorna_data_login",
                                                     "SecurityBean",
                                                     StaticContext.FindExceptionType(e));
        }
        return esito;
  }

  public ClassDatiTop findDataTop() throws CustomException,RemoteException,FinderException {
        Connection conn=null;
        CallableStatement cs = null;
        ClassDatiTop row = null;
    
        try {
            conn = getConnection(StaticContext.DSNAME);

            cs = conn.prepareCall(findDataTop);
            cs.registerOutParameter(1, OracleTypes.NUMBER);
            cs.registerOutParameter(2, OracleTypes.VARCHAR);
            cs.registerOutParameter(3, OracleTypes.VARCHAR);

            cs.execute();

            int rs = cs.getInt(1);
            /*ResultSet rs = (ResultSet)cs.getString(2);
            ResultSet rs = (ResultSet)cs.getString(2);*/

      			//if(rs.next()) {
                row = new ClassDatiTop();
                row.setDB_instance(cs.getString(2));
                row.setServer(cs.getString(3));
            //}
            cs.close();
            conn.close();
            return row;
        } catch(Exception e) { 
            try {
                if (cs != null)
                  cs.close();
                if (conn!=null)
                  conn.close();
            } catch(Exception ex) {
                System.out.println (e.getMessage());
                e.printStackTrace();
            }
            throw new CustomException(e.toString(),
                                                     "Errore di accesso alla tabella della sicurezza",
                                                     "datiIntestazione_instance_host",
                                                     "SecurityBean",
                                                     StaticContext.FindExceptionType(e));
        }
  }

  public String findIpLdap() throws CustomException,RemoteException
  {
      Connection conn=null;
      CallableStatement cs = null;
      String my_ip_ldap = "";
      
      try
      {
        conn = getConnection(StaticContext.DSNAME);
        
        cs = conn.prepareCall(findLdapIP);
        cs.registerOutParameter(1, OracleTypes.VARCHAR);

        cs.execute();
        
        my_ip_ldap = cs.getString(1);
        
        cs.close();
        conn.close();
      } 
      catch(Exception e)
      { 
        try
        {
          if (cs != null)
            cs.close();
          if (conn!=null)
            conn.close();
        }
        catch(Exception ex)
        {
          System.out.println (e.getMessage());
          e.printStackTrace();
        }
        throw new CustomException(e.toString(),"Errore di accesso alla tabella della sicurezza","findIpLdap","SecurityBean",StaticContext.FindExceptionType(e));
      }
      return my_ip_ldap;
  }

  public String findRootLdap() throws CustomException,RemoteException
  {
      Connection conn=null;
      CallableStatement cs = null;
      String my_ro_ldap="";
      String l_ro = "L_RO";
      
      try
      {
        conn = getConnection(StaticContext.DSNAME);
        
        cs = conn.prepareCall(findLdapRO);
        cs.registerOutParameter(1, OracleTypes.VARCHAR);

        cs.execute();
        
        my_ro_ldap = cs.getString(1);
        
        if (my_ro_ldap!=null)
          System.out.println("valore non nullo ROOT_LDAP nel DB");
        else
          System.out.println("valore nullo ROOT_LDAP nel DB");
        cs.close();
        conn.close();
      } 
      catch(Exception e)
      { 
        try
        {
          if (cs != null)
            cs.close();
          if (conn!=null)
            conn.close();
        }
        catch(Exception ex)
        {
          System.out.println (e.getMessage());
          e.printStackTrace();
        }
        throw new CustomException(e.toString(),"Errore di accesso alla tabella della sicurezza","findRootLdap","SecurityBean",StaticContext.FindExceptionType(e));
      }
      return my_ro_ldap;
  }

  public int aggiorna_tnt_login(int num_tnt_login, String sCodeUser) throws CustomException,RemoteException {
      Connection conn=null;
      CallableStatement cs = null;
      int esito =0;    
      try {
          conn = getConnection(StaticContext.DSNAME);
          cs = conn.prepareCall(aggiornaTNTLogin);
          cs.registerOutParameter(1, OracleTypes.NUMBER);
          cs.setInt(2,num_tnt_login);
          cs.setString(3,sCodeUser);
          cs.execute();
          esito = cs.getInt(1);
          conn.close();          
      } catch(Exception e) { 
          try {
              if (conn!=null)
                conn.close();
          } catch(Exception ex) {
              System.out.println (e.getMessage());
              e.printStackTrace();
          }
          throw new CustomException(e.toString(),
                                      "Errore di accesso alla tabella della sicurezza",
                                      "aggiorna_tnt_login",
                                      "SecurityBean",
                                      StaticContext.FindExceptionType(e));
      }
      return esito;
  }

}