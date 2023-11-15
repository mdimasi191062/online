package com.ejbSTL.impl;
import com.utl.*;
import javax.sql.*;
import javax.naming.*;
import javax.ejb.*;
import java.util.*;
import java.rmi.*;
import oracle.jdbc.OracleTypes;
import java.sql.*;
import com.ejbSTL.DatiAcc;
import com.ejbSTL.DatiClass;
import com.ejbSTL.DatiOgg;
import com.ejbSTL.DatiOcc;


public class FILTRO_MOV_NON_RICEJBBean extends AbstractSessionCommonBean implements SessionBean 
{

  private String LeggiFornitori = "{? = call PKG_BILL_CLA.FILTRO_MOV_NON_RICEJBFindall(?) }";
  private String LeggiAccount = "{? = call PKG_BILL_CLA.FILTRO_MOV_NON_RICEJBFindAcc(?,?,?) }";
  private String LeggiClassi = "{? = call PKG_BILL_CLA.FILTRO_MOV_NON_RICEJBFindClass() }";
  private String LeggiOggetti = "{? = call PKG_BILL_CLA.FILTRO_MOV_NON_RICEJBFindOgg(?) }";
  private String LeggiIstanze = "{? = call PKG_BILL_CLA.FILTRO_MOV_NON_RICEJBFindIst(?,?) }";
  private String LeggiDate = "{? = call PKG_BILL_CLA.FILTRO_MOV_NON_RICEJBFindTemp(?,?,?) }";
  private String LeggiOccorrenza = "{? = call PKG_BILL_CLA.FILTRO_MOV_NON_RICEJBOccorr(?) }";
  
  public void ejbCreate()
  {
  }

  public Vector FindAll(String FiltroCODE_TIPO_CONTR) throws RemoteException,CustomException
  {
    CallableStatement cs = null;
    Vector Vectorpk = new Vector();
    ResultSet rs = null;
    try
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(LeggiFornitori);
      cs.registerOutParameter(1,OracleTypes.CURSOR);
      cs.setString(2,FiltroCODE_TIPO_CONTR);
      cs.execute();
      rs = (ResultSet) cs.getObject(1);
      while (rs.next()) 
      {   
         DatiForn datiforn= new DatiForn();
         datiforn.set_descrizione(rs.getString(2));
         datiforn.set_codice(rs.getString(1));
         Vectorpk.addElement(datiforn);
      } 
    } 
    catch (Exception e) {
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_3GEST_TLC","FindAll","I5_3GEST_TLC",StaticContext.FindExceptionType(e));    
    } finally {
      try {
         if (rs != null){
          rs.close();
         }
	       cs.close();
      } catch (Exception e) {}
      try {
	       conn.close();
      } catch (Exception e) {}
    }
    return Vectorpk;
  }

  public Vector FindAcc(String Codefornitore, String Provenienza, String TipoContratto) throws RemoteException,CustomException
  {
    CallableStatement cs = null;
    Vector Vectorpk = new Vector();
    ResultSet rs = null;    
    try
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(LeggiAccount);
      cs.registerOutParameter(1,OracleTypes.CURSOR);
      cs.setString(2,Codefornitore);
      cs.setString(3,Provenienza);
      cs.setString(4,TipoContratto);
      cs.execute();
      rs = (ResultSet) cs.getObject(1);
      while (rs.next()) 
      {   
         DatiAcc datiacc= new DatiAcc();
         datiacc.set_descrizione(rs.getString(2));
         datiacc.set_codice(rs.getString(1));
         Vectorpk.addElement(datiacc);
      } 
    } 
    catch (Exception e) {
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_1ACCOUNT","FindAcc","I5_1ACCOUNT",StaticContext.FindExceptionType(e));        
    } finally {
      try {
         if (rs != null){
          rs.close();
         }      
	       cs.close();
      } catch (Exception e) {}
      try {
	       conn.close();
      } catch (Exception e) {}
    }
    return Vectorpk;
  }

  public Vector FindClass() throws RemoteException,CustomException
  {
    CallableStatement cs = null;
    Vector Vectorpk = new Vector();
    ResultSet rs = null;    
    try
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(LeggiClassi);
      cs.registerOutParameter(1,OracleTypes.CURSOR);
      cs.execute();
      rs = (ResultSet) cs.getObject(1);
      while (rs.next()) 
      {   
         DatiClass daticlass = new DatiClass();
         daticlass.set_descrizione(rs.getString(2));
         daticlass.set_codice(rs.getString(1));
         Vectorpk.addElement(daticlass);
      } 
    } 
    catch (Exception e) {
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2CLAS_OGG_DI_FATRZ_CL","FindClass","I5_2CLAS_OGG_DI_FATRZ_CL",StaticContext.FindExceptionType(e));            
    } finally {
      try {
         if (rs != null){
          rs.close();
         }      
	       cs.close();
      } catch (Exception e) {}
      try {
	       conn.close();
      } catch (Exception e) {}
    }
    return Vectorpk;
  }

  public String FindIst(String Codeistanza, String Codeaccount) throws RemoteException,CustomException
  {
    CallableStatement cs = null;
    String codice_invent = null;
    try
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(LeggiIstanze);
      cs.registerOutParameter(1,OracleTypes.VARCHAR);
      cs.setString(2,Codeistanza);
      cs.setString(3,Codeaccount);      
      cs.execute();
      codice_invent = cs.getString(1);
    } 
    catch (Exception e) {
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_1INVENT_PS_CL","FindIst","I5_1INVENT_PS_CL",StaticContext.FindExceptionType(e));            
    } finally {
      try {
	       cs.close();
      } catch (Exception e) {}
      try {
	       conn.close();
      } catch (Exception e) {}
    }
    return codice_invent;
  }

  public Vector FindOgg(String Codeclasse) throws RemoteException,CustomException
  {
    CallableStatement cs = null;
    Vector Vectorpk = new Vector();
    ResultSet rs = null;
    try
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(LeggiOggetti);
      cs.registerOutParameter(1,OracleTypes.CURSOR);
      cs.setString(2,Codeclasse);
      cs.execute();
      rs = (ResultSet) cs.getObject(1);
      while (rs.next()) 
      {   
         DatiOgg datiogg= new DatiOgg();
         datiogg.set_descrizione(rs.getString(2));
         datiogg.set_codice(rs.getString(1));
         datiogg.set_data_inizio(rs.getDate(3));
         Vectorpk.addElement(datiogg);
      } 
    } 
    catch (Exception e) {
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2OGG_DI_FATRZ_CL","FindOgg","I5_2OGG_DI_FATRZ_CL",StaticContext.FindExceptionType(e));                
    } finally {
      try {
         if (rs != null){
          rs.close();
         }

	       cs.close();
      } catch (Exception e) {}
      try {
	       conn.close();
      } catch (Exception e) {}
    }
    return Vectorpk;
  }

  public int FindTemp(int Mese, int Anno, String Codeaccount) throws RemoteException,CustomException
  {
    CallableStatement cs = null;
    int occorrenze = 0;
    try
    {
      conn = getConnection(dsName);
      cs = conn.prepareCall(LeggiDate);
      cs.registerOutParameter(1,OracleTypes.NUMBER);
      cs.setInt(2,Mese);
      cs.setInt(3,Anno);
      cs.setString(4,Codeaccount);      
      cs.execute();
      occorrenze = cs.getInt(1);
    } 
    catch (Exception e) {
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2PARAM_VALORIZ_CL","FindTemp","I5_2PARAM_VALORIZ_CL",StaticContext.FindExceptionType(e));                    
    } finally {
      try {
	       cs.close();
      } catch (Exception e) {}
      try {
	       conn.close();
      } catch (Exception e) {}
    }
    return occorrenze;
  }

  public Vector FindOcc(String Codemovimento) throws RemoteException,CustomException
  {
    CallableStatement cs = null;
    Vector Vectorpk = new Vector();
    ResultSet rs = null;
    try
    {
      System.out.println("codice movimento: "+Codemovimento);
      conn = getConnection(dsName);
      cs = conn.prepareCall(LeggiOccorrenza);
      cs.registerOutParameter(1,OracleTypes.CURSOR);
      cs.setString(2,Codemovimento);
      cs.execute();
      rs = (ResultSet) cs.getObject(1);
      while (rs.next()) 
      {   
         DatiOcc datiocc= new DatiOcc();
         datiocc.set_codice(rs.getString(1));
         datiocc.set_desc_account(rs.getString(2));
         datiocc.set_desc_forn(rs.getString(3));
         datiocc.set_desc_mov(rs.getString(4));
         datiocc.set_data_fatrb(rs.getDate(5));
         datiocc.set_data_transaz(rs.getDate(6));
         datiocc.set_importo(rs.getBigDecimal(7).toString().replace('.',','));        
         datiocc.set_flag_fatt(rs.getString(8));
         datiocc.set_flag_d_a(rs.getString(9));
         datiocc.set_mese(rs.getString(10));
         datiocc.set_anno(rs.getString(11));
         datiocc.set_desc_oggetto(rs.getString(12));
         datiocc.set_desc_classe(rs.getString(13));
         datiocc.set_code_istanza(rs.getString(14));
         Vectorpk.addElement(datiocc);
      } 
    } 
    catch (Exception e) {
      e.printStackTrace();
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2MOV_NON_RIC","FindOcc","I5_2MOV_NON_RIC",StaticContext.FindExceptionType(e));                    
    } finally {
      try {
         if (rs != null){
          rs.close();
         }
	       cs.close();
      } catch (Exception e) {}
      try {
	       conn.close();
      } catch (Exception e) {}
    }
    return Vectorpk;
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
}