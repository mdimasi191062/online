
package com.ejbSTL.impl;
import java.rmi.RemoteException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.Vector;

import javax.ejb.SessionBean;
import javax.ejb.SessionContext;

import com.utl.AbstractSessionCommonBean;
import com.utl.CustomException;
import com.utl.I5_6anag_utenteROW;
import com.utl.StaticContext;

public class I5_6ANAG_UTENTEejbBean extends AbstractSessionCommonBean  implements SessionBean
{
    private String createStatement = "{? = call PKG_BILL_COM.I5_6ANAG_UTENTEcreate(?,?,?,?,?,?,?,?,?,?,?) }";
    private String storeStatement	= "{? = call PKG_BILL_COM.I5_6ANAG_UTENTEstore(?,?,?,?,?,?,?,?,?,?) }";
    private String removeStatement	= "{? = call PKG_BILL_COM.I5_6ANAG_UTENTEremove(?) }";
    private String loadStatement = "{? = call PKG_BILL_COM.I5_6ANAG_UTENTEload(?) }";
    private String findAllStatement	= "{? = call PKG_BILL_COM.I5_6ANAG_UTENTEfindAll(?) }";
    private String findAllStatement_disabled	= "{? = call PKG_BILL_COM.I5_6ANAG_UTENTEfindAllDisabled(?) }";
    private String riabilitaStatement	= "{? = call PKG_BILL_COM.I5_6ANAG_UTENTEriabilita(?) }";
    private String insParamProfUte = "{? = call PKG_BILL_COM.I5_6CONF_USER_UTEinsert(?,?,?,?) }";
    private String loadParamProfUte	= "{? = call PKG_BILL_COM.I5_6CONF_USER_UTEload() }";
    
    public void ejbCreate() {
	/* empty */
    }
    
    public void ejbActivate() {
	/* empty */
    }
    
    public void ejbPassivate() {
	/* empty */
    }
    
    public void ejbRemove() {
	/* empty */
    }
    
    public void setSessionContext(SessionContext ctx) {
	/* empty */
    }
    
  public Vector find(String codice, String tipoUser) throws CustomException, RemoteException {
    I5_6anag_utenteROW row = null;
    Connection conn = null;
    CallableStatement cs = null;
    ResultSet rs = null;
    Vector recs = new Vector();
    try {
        conn = getConnection(dsName);
        if (tipoUser.equals("0"))
          cs = conn.prepareCall(findAllStatement);
        else
          cs = conn.prepareCall(findAllStatement_disabled);
        cs.registerOutParameter(1, -10);
        if (codice == null)
          cs.setNull(2, 12);
        else
          cs.setString(2, codice);
        cs.execute();
        rs = (ResultSet) cs.getObject(1);
        while (rs.next()) {
      row = new I5_6anag_utenteROW();
      row.setCode_utente(rs.getString("CODE_UTENTE"));
      row.setCode_prof_utente(rs.getString("CODE_PROF_UTENTE"));
      row.setNome_cogn_utente(rs.getString("NOME_COGN_UTENTE"));
      row.setData_login(rs.getString("DATA_LOGIN_CHAR"));
      row.setData_end_char(rs.getString("DATE_END_CHAR"));
      row.setData_start_char(rs.getString("DATA_START_CHAR"));
      row.setFlag_admin_ind(rs.getString("FLAG_ADMIN_IND"));
      recs.add(row);
        }
        rs.close();
    } catch (Exception e) {
        System.out.println(e.getMessage());
        throw new CustomException
            (e.toString(),
             "Errore di accesso alla tabella degli utenti", "find",
             "I5_6ANAG_UTENTEejbBean",
             StaticContext.FindExceptionType(e));
    } finally {
        try {
      cs.close();
        } catch (Exception e) {
      System.out.println(e.getMessage());
      throw new CustomException
          (e.toString(),
           "Errore di accesso alla tabella degli utenti",
           "ejbFindAll", "I5_6ANAG_UTENTEejbBean",
           StaticContext.FindExceptionType(e));
        }
        try {
      conn.close();
        } catch (Exception e) {
      System.out.println(e.getMessage());
      throw new CustomException
          (e.toString(),
           "Errore di accesso alla tabella degli utenti",
           "ejbFindAll", "I5_6ANAG_UTENTEejbBean",
           StaticContext.FindExceptionType(e));
        }
    }
    return recs;
  }
    
    public String creaNuovo(I5_6anag_utenteROW riga)
	throws CustomException, RemoteException {
	CallableStatement cs = null;
	String ret = null;
	try {
	    conn = getConnection(dsName);
	    cs = conn.prepareCall(createStatement);
	    cs.registerOutParameter(1, 12);
	    cs.setString(2, riga.getCode_utente());
	    cs.setString(3, riga.getNome_cogn_utente());
	    cs.setString(4, riga.getCode_prof_utente());
	    cs.setString(5, riga.getCode_prof_abil());
	    cs.setString(6, riga.getCode_unita_organiz());
	    cs.setInt(7, riga.getNum_months_disabled());
	    cs.setString(8, riga.getBaseIDN_LDAP());
	    cs.setString(9, riga.getSearchIDN_LDAP());
	    cs.setString(10, riga.getFlag_admin_ind());
	    cs.setString(11, riga.getCogn_utente());
      cs.setString(12, riga.getNome_utente());
	    cs.execute();
	    ret = cs.getString(1);
	    if (ret.equals(riga.getCode_utente()))
        ret = null;
	} catch (Exception e) {
	    System.out.println(e.getMessage());
	    throw new CustomException
		      (e.toString(),
		       "Errore di accesso alle tabelle degli utenti e/o password utenti",
		       "creaNuovo", "I5_6ANAG_UTENTEejbBean",
		       StaticContext.FindExceptionType(e));
	} finally {
	    try {
		cs.close();
	    } catch (Exception e) {
		System.out.println(e.getMessage());
	    }
	    try {
		conn.close();
	    } catch (Exception e) {
		System.out.println(e.getMessage());
	    }
	}
	return ret;
    }
    
  public I5_6anag_utenteROW loadUtente(String codice) throws CustomException, RemoteException {
    CallableStatement cs = null;
    I5_6anag_utenteROW row = null;
    try {
        conn = getConnection(dsName);
        cs = conn.prepareCall(loadStatement);
        cs.registerOutParameter(1, -10);
        cs.setString(2, codice);
        cs.execute();
        ResultSet rs = (ResultSet) cs.getObject(1);
        while (rs.next()) {
          row = new I5_6anag_utenteROW();
          row.setCode_utente(rs.getString("CODE_UTENTE"));
          row.setCode_prof_utente(rs.getString("CODE_PROF_UTENTE"));
          row.setNome_cogn_utente(rs.getString("NOME_COGN_UTENTE"));
          row.setDate_end(rs.getDate("DATE_END"));
          row.setFlag_admin_ind(rs.getString("FLAG_ADMIN_IND"));
          row.setCode_prof_abil(rs.getString("CODE_PROF_ABIL"));
          row.setCode_unita_organiz(rs.getString("CODE_UNITA_ORGANIZ"));
          row.setBaseIDN_LDAP(rs.getString("DESC_BASE_IDN_LDAP"));
          row.setSearchIDN_LDAP(rs.getString("DESC_SEARCH_IDN_LDAP"));
          row.setDateStart(rs.getDate("DATE_START"));
          row.setNum_months_disabled(rs.getInt("NUM_MONTHS_DISABLE"));
          row.setData_login(rs.getString("DATA_LOGIN_CHAR"));
          row.setDt_disable_not_access(rs.getDate("DT_DISABLE_NOT_ACCESS"));
          row.setflag_disabled_pwd_err(rs.getString("FLAG_DISABLED_PWD_ERR"));
          row.setCogn_utente(rs.getString("COGN_UTENTE"));
          row.setNome_utente(rs.getString("NOME_UTENTE"));          
        }
        rs.close();
    } catch (Exception e) {
        System.out.println(e.getMessage());
        throw new CustomException
            (e.toString(),
             "Errore di accesso alla tabella degli utenti",
             "loadUtente", "I5_6ANAG_UTENTEejbBean",
             StaticContext.FindExceptionType(e));
    } finally {
        try {
      cs.close();
        } catch (Exception e) {
      System.out.println(e.getMessage());
        }
        try {
      conn.close();
        } catch (Exception e) {
      System.out.println(e.getMessage());
        }
    }
    return row;
  }
    
    public String deleteUtente(String codice)
	throws CustomException, RemoteException {
	CallableStatement cs = null;
	String ret = null;
	try {
	    conn = getConnection(dsName);
	    cs = conn.prepareCall(removeStatement);
	    cs.registerOutParameter(1, 12);
	    cs.setString(2, codice);
	    cs.execute();
	    ret = cs.getString(1);
	    if (ret.equals(codice))
		ret = null;
	} catch (Exception e) {
	    System.out.println(e.getMessage());
	    throw new CustomException
		      (e.toString(),
		       "Errore di accesso alle tabelle degli utenti e/o password utenti",
		       "deleteUtente", "I5_6ANAG_UTENTEejbBean",
		       StaticContext.FindExceptionType(e));
	} finally {
	    try {
		cs.close();
	    } catch (Exception e) {
		System.out.println(e.getMessage());
	    }
	    try {
		conn.close();
	    } catch (Exception e) {
		System.out.println(e.getMessage());
	    }
	}
	return ret;
    }
    
    public String updateUtente(I5_6anag_utenteROW riga) throws CustomException, RemoteException {
      CallableStatement cs = null;
      String ret = null;
      try {
          conn = getConnection(dsName);
          cs = conn.prepareCall(storeStatement);
          cs.registerOutParameter(1, 12);
          cs.setString(2, riga.getCode_utente());
          cs.setString(3, riga.getNome_cogn_utente());
          cs.setString(4, riga.getCode_prof_utente());
          cs.setString(5, riga.getCode_prof_abil());
          cs.setString(6, riga.getCode_unita_organiz());
          cs.setString(7, riga.getFlag_admin_ind());
          cs.setString(8, riga.getBaseIDN_LDAP());
          cs.setString(9, riga.getSearchIDN_LDAP());
          cs.setString(10, riga.getCogn_utente());
          cs.setString(11, riga.getNome_utente());
          cs.execute();
          ret = cs.getString(1);
      } catch (Exception e) {
          System.out.println(e.getMessage());
          throw new CustomException
              (e.toString(),
               "Errore di accesso alla tabella degli utenti",
               "updateUtente", "I5_6ANAG_UTENTEejbBean",
               StaticContext.FindExceptionType(e));
      } finally {
        try {
          cs.close();
        } catch (Exception e) {
          System.out.println(e.getMessage());
        }
        try {
          conn.close();
        } catch (Exception e) {
          System.out.println(e.getMessage());
        }
      }
      return null;
    }
    
    public String riabilitaUtente(String codice) throws CustomException, RemoteException {
      CallableStatement cs = null;
      String ret = null;
      try {
          conn = getConnection(dsName);
          cs = conn.prepareCall(riabilitaStatement);
          cs.registerOutParameter(1, 12);
          cs.setString(2, codice);
          cs.execute();
          ret = cs.getString(1);
          if (ret.equals(codice))
        ret = null;
      } catch (Exception e) {
          System.out.println(e.getMessage());
          throw new CustomException
              (e.toString(),
               "Errore di accesso alla tabella degli utenti",
               "riabilitaUtente", "I5_6ANAG_UTENTEejbBean",
               StaticContext.FindExceptionType(e));
      } finally {
          try {
        cs.close();
          } catch (Exception e) {
        System.out.println(e.getMessage());
          }
          try {
        conn.close();
          } catch (Exception e) {
        System.out.println(e.getMessage());
          }
      }
      return null;
    }
    
  public String insParamProfUte (String codice, String pwd, String nome_cognome, String email) throws CustomException, RemoteException {
    CallableStatement cs = null;
    String ret = null;
    try {
        conn = getConnection(dsName);
        cs = conn.prepareCall(insParamProfUte);
        cs.registerOutParameter(1, 12);
        cs.setString(2, codice);
        cs.setString(3, pwd);
        cs.setString(4, nome_cognome);
        cs.setString(5, email);
        cs.execute();
        ret = cs.getString(1);
    } catch (Exception e) {
        System.out.println(e.getMessage());
        throw new CustomException
            (e.toString(),
             "Errore di accesso alle tabelle parametri configurazione invio email gestione utenze",
             "insParamProfUte", "I5_6ANAG_UTENTEejbBean",
             StaticContext.FindExceptionType(e));
    } finally {
        try {
      cs.close();
        } catch (Exception e) {
      System.out.println(e.getMessage());
        }
        try {
      conn.close();
        } catch (Exception e) {
      System.out.println(e.getMessage());
        }
    }
    return ret;
  }
    
    public I5_6anag_utenteROW loadParamProfUte()
	throws CustomException, RemoteException {
	CallableStatement cs = null;
	I5_6anag_utenteROW row = null;
	try {
	    conn = getConnection(dsName);
	    cs = conn.prepareCall(loadParamProfUte);
	    cs.registerOutParameter(1, -10);
	    cs.execute();
	    ResultSet rs = (ResultSet) cs.getObject(1);
	    while (rs.next()) {
		row = new I5_6anag_utenteROW();
		row.setCode_utente(rs.getString("CODE_UTENTE"));
		row.setCode_prof_utente(rs.getString("CODE_PWD"));
		row.setNome_cogn_utente(rs.getString("NOME_COGN_UTENTE"));
		row.setMail_manager(rs.getString("DESC_EMAIL"));
	    }
	    rs.close();
	} catch (Exception e) {
	    System.out.println(e.getMessage());
	    throw new CustomException
		      (e.toString(),
		       "Errore di accesso alle tabelle parametri configurazione invio email gestione utenze",
		       "insParamProfUte", "I5_6ANAG_UTENTEejbBean",
		       StaticContext.FindExceptionType(e));
	} finally {
	    try {
		cs.close();
	    } catch (Exception e) {
		System.out.println(e.getMessage());
	    }
	    try {
		conn.close();
	    } catch (Exception e) {
		System.out.println(e.getMessage());
	    }
	}
	return row;
    }
}