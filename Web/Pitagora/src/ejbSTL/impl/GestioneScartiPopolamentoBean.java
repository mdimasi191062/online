package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.util.*;

import com.ejbSTL.I5_1CONTR;
import com.ejbSTL.I5_5ANAG_SCARTI;
import com.ejbSTL.I5_5SCARTI_VALORIZZAZIONE;
import com.ejbSTL.ListaScartiPopolamento_ROW;

import java.util.Vector;
import java.rmi.RemoteException;
import java.sql.*;
import oracle.jdbc.OracleTypes;
import com.utl.*;

public class GestioneScartiPopolamentoBean extends AbstractClassicEJB implements SessionBean 
{
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

  private static final String callPerListaOloConScarti = 
    "{? = call " + StaticContext.PACKAGE_SPECIAL + ".GET_RESULTSET_CONTR_CON_SCARTI( ? ) }";  

  public Vector getListaOloConScarti(String pCodeTipoContr)
    throws RemoteException,CustomException
  {
		Connection conn=null;
    CallableStatement cs = null;
    ResultSet rs=null;
    I5_1CONTR lContrRow = null;
    Vector recs = new Vector();

		try
		{

			conn = getConnection(dsName);
      cs = conn.prepareCall(callPerListaOloConScarti);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setString(2,pCodeTipoContr);
      cs.execute();
			rs = (ResultSet)cs.getObject(1);
			while(rs.next())
			{
        lContrRow =  new I5_1CONTR();
        lContrRow.setCODE_CONTR(rs.getString("CODE_CONTR"));
        lContrRow.setDESC_CONTR(rs.getString("DESC_CONTR"));              
        recs.add(lContrRow);
			} 
		} catch(SQLException e)
		{
			System.out.println (e.getMessage());
      e.printStackTrace();
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_1CONTR","getListaOloConScarti","I5_1CONTR",StaticContext.FindExceptionType(e));    
    } finally
		{
			try
			{
        if (rs != null){
          rs.close();
        }
				cs.close();
			} catch(Exception e)
			{
			}
			try
			{
				conn.close();
			} catch(Exception e)
			{
			}
		}
		return recs;    
  }


  private static final String callPerListaScartiXOlo = 
    "{? = call " + StaticContext.PACKAGE_SPECIAL + ".GET_RESULTSET_SCARTI_X_CONTR( ? , ? ) }";  

  public Vector getListaScartiXOlo(String pCodeTipoContr, String pCodeContr) 
    throws RemoteException,CustomException
  {
		Connection conn=null;
    CallableStatement cs = null;
    ResultSet rs=null;
    I5_5SCARTI_VALORIZZAZIONE lScartoRow = null;
    Vector recs = new Vector();

		try
		{

			conn = getConnection(dsName);
      cs = conn.prepareCall(callPerListaScartiXOlo);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setString(2,pCodeTipoContr);
      cs.setString(3,pCodeContr);      
      cs.execute();
			rs = (ResultSet)cs.getObject(1);
			while(rs.next())
			{
        lScartoRow =  new I5_5SCARTI_VALORIZZAZIONE();

        lScartoRow.setCODE_ITRF_FAT_XDSL_XML_RIF (rs.getString("CODE_ITRF_FAT_XDSL_XML_RIF"));          
        lScartoRow.setCODE_SCARTO                (rs.getString("CODE_SCARTO"));          
        lScartoRow.setDESC_SCARTO                (rs.getString("DESC_SCARTO"));          
        lScartoRow.setDATA_SCARTO                (rs.getDate  ("DATA_SCARTO"));          
        lScartoRow.setDATA_CHIUSURA_SCARTO       (rs.getDate  ("DATA_CHIUSURA_SCARTO"));        
        lScartoRow.setSTATO_SCARTO               (rs.getString("STATO_SCARTO"));          
        lScartoRow.setDESC_ID_RISORSA            (rs.getString("DESC_ID_RISORSA"));          
        lScartoRow.setCODE_TIPO_CONTR            (rs.getString("CODE_TIPO_CONTR"));          
        lScartoRow.setCODE_CONTR                 (rs.getString("CODE_CONTR"));          
        lScartoRow.setCODE_TRACCIATO             (rs.getString("CODE_TRACCIATO"));          
        lScartoRow.setCODE_DETT_SCARTO           (rs.getString("CODE_DETT_SCARTO"));          
        lScartoRow.setCHIAVE_PITA_JPUB           (rs.getString("CHIAVE_PITA_JPUB"));          
          
        recs.add(lScartoRow);
			} 
		} catch(SQLException e)
		{
			System.out.println (e.getMessage());
      e.printStackTrace();
      throw new CustomException(e.toString(), "Errore di accesso alle tabelle di scarto del popolamento",
                                              "getListaScartiXOlo",
                                              "I5_5SCARTI_VALORIZZAZIONE & I5_2SCARTI_POPOLAMENTO_SP",
                                              StaticContext.FindExceptionType(e));    
    } finally
		{
			try
			{
        if (rs != null){
          rs.close();
        }
				cs.close();
			} catch(Exception e)
			{
			}
			try
			{
				conn.close();
			} catch(Exception e)
			{
			}
		}
		return recs;        
  }
  
  
  ///PASSSS
  
   private static final String callGetOlo = "{? = call PKG_SCARTI.GetOlo() }";  
   private static final String callGetCausaleScarto = "{? = call PKG_SCARTI.GetCausaleScarto() }";  
   private static final String callGetServizi = "{? = call PKG_SCARTI.GetServizi() }";  
   private static final String callGetScarti = "{? = call PKG_SCARTI.GetScarti(?,?,?,?,?) }";  
   private static final String callUpdateScarti = "{ call PKG_SCARTI.RiproponiScarti(?,?,?,?,?,?) }"; 
   
   public Vector getServizi() throws RemoteException,CustomException 
     {
           
       Connection conn=null;
       CallableStatement cs = null;
       ResultSet rs=null;
       DB_TipiContratto lContrRow = null;
       Vector recs = new Vector();
       
       try
       {
       
           conn = getConnection(dsName);
           cs = conn.prepareCall(callGetServizi);
           cs.registerOutParameter(1, OracleTypes.CURSOR);
           cs.execute();
           rs = (ResultSet)cs.getObject(1);
           while(rs.next())
           {
           lContrRow =  new DB_TipiContratto();
           lContrRow.setCODE_TIPO_CONTR(rs.getString("CODE_TIPO_CONTR"));
           lContrRow.setFLAG_SYS(rs.getString("FLAG_SYS"));
           lContrRow.setDESC_TIPO_CONTR(rs.getString("DESC_TIPO_CONTR"));              
           recs.add(lContrRow);
           } 
       } catch(SQLException e)
       {
           System.out.println (e.getMessage());
           e.printStackTrace();
           throw new CustomException(e.toString(),"Errore di accesso al package PKG_SCARTI.getServizi","getServizi","I5_1TIPO_CONTR",StaticContext.FindExceptionType(e));    
       } finally
       {
           try
           {
               if (rs != null){
               rs.close();
               }
               cs.close();
           } catch(Exception e){}
           try
           {
               conn.close();
           } catch(Exception e){}
       }
       return recs;  
     }
     
   public Vector getOlo() throws RemoteException,CustomException 
   {
         
     Connection conn=null;
     CallableStatement cs = null;
     ResultSet rs=null;
     I5_1CONTR lContrRow = null;
     Vector recs = new Vector();
     
     try
     {
     
         conn = getConnection(dsName);
         cs = conn.prepareCall(callGetOlo);
         cs.registerOutParameter(1, OracleTypes.CURSOR);
         cs.execute();
         rs = (ResultSet)cs.getObject(1);
         while(rs.next())
         {
         lContrRow =  new I5_1CONTR();
         lContrRow.setCODE_CONTR(rs.getString("CODE_CONTR"));
         lContrRow.setCODE_GEST(rs.getString("CODE_GEST"));
         lContrRow.setDESC_CONTR(rs.getString("DESC_CONTR"));              
         recs.add(lContrRow);
         } 
     } catch(SQLException e)
     {
         System.out.println (e.getMessage());
         e.printStackTrace();
         throw new CustomException(e.toString(),"Errore di accesso al package PKG_SCARTI.GetOlo","getOlo","I5_1CONTR",StaticContext.FindExceptionType(e));    
     } finally
     {
         try
         {
             if (rs != null){
             rs.close();
             }
             cs.close();
         } catch(Exception e){}
         try
         {
             conn.close();
         } catch(Exception e){}
     }
     return recs;  
   }

     public Vector getCausaleScarto() throws RemoteException,CustomException
     {
           
       Connection conn=null;
       CallableStatement cs = null;
       ResultSet rs=null;
       I5_5ANAG_SCARTI lContrRow = null;
       Vector recs = new Vector();
       
       try
       {
       
           conn = getConnection(dsName);
           cs = conn.prepareCall(callGetCausaleScarto);
           cs.registerOutParameter(1, OracleTypes.CURSOR);
           cs.execute();
           rs = (ResultSet)cs.getObject(1);
           while(rs.next())
           {
           lContrRow =  new I5_5ANAG_SCARTI();
           lContrRow.setDESC_SCARTO(rs.getString("DESC_SCARTO"));
           lContrRow.setCODE_DETT_SCARTO(rs.getString("CODE_DETT_SCARTO"));
           recs.add(lContrRow);
           } 
       } catch(SQLException e)
       {
           System.out.println (e.getMessage());
           e.printStackTrace();
           throw new CustomException(e.toString(),"Errore di accesso al package PKG_SCARTI.GetCausaleScarto","getCausaleScarto","I5_5ANAG_SCARTI",StaticContext.FindExceptionType(e));    
       } finally
       {
           try
           {
               if (rs != null){
               rs.close();
               }
               cs.close();
           } catch(Exception e){}
           try
           {
               conn.close();
           } catch(Exception e){}
       }
       return recs;  
     }
     
    public Vector getScarti(String COD_SERVIZIO, String COD_CAUSALE_SCARTO, String COD_OLO, String DATA_DA, String DATA_A) throws RemoteException,CustomException {
    Connection conn=null;
    CallableStatement cs = null;
    ResultSet rs=null;
    ListaScartiPopolamento_ROW lContrRow = null;
    Vector recs = new Vector();
    
    try
    {
    
        conn = getConnection(dsName);
        cs = conn.prepareCall(callGetScarti);
        cs.registerOutParameter(1, OracleTypes.CURSOR);
        cs.setString(2, COD_SERVIZIO);
        cs.setString(3, COD_CAUSALE_SCARTO);
        cs.setString(4, COD_OLO);
        cs.setString(5, DATA_DA);
        cs.setString(6, DATA_A);
        cs.execute();
        rs = (ResultSet)cs.getObject(1);
        while(rs.next())
        {
            lContrRow =  new ListaScartiPopolamento_ROW();

            lContrRow.setCODE_ITRF_FAT(rs.getString("CODE_ITRF_FAT"));
            lContrRow.setCODE_RICH(rs.getString("CODE_RICH"));
            lContrRow.setDESC_ID_RISORSA(rs.getString("DESC_ID_RISORSA"));
            lContrRow.setCODE_TIPO_CONTR(rs.getString("CODE_TIPO_CONTR"));
            lContrRow.setCODE_CONTR(rs.getString("CODE_CONTR"));
            lContrRow.setCODE_SCARTO(rs.getString("CODE_SCARTO"));
            lContrRow.setDATA_ACQ_CHIUS(rs.getString("DATA_ACQ_CHIUS"));
            lContrRow.setDESC_SCARTO(rs.getString("DESC_SCARTO"));

            recs.add(lContrRow);
        } 
    } catch(SQLException e)
    {
        System.out.println (e.getMessage());
        e.printStackTrace();
        throw new CustomException(e.toString(),"Errore di accesso al package PKG_SCARTI.GetCausaleScarto","getCausaleScarto","I5_5ANAG_SCARTI",StaticContext.FindExceptionType(e));    
    } finally
    {
        try
        {
            if (rs != null){
            rs.close();
            }
            cs.close();
        } catch(Exception e){}
        try
        {
            conn.close();
        } catch(Exception e){}
    }
    return recs;          
    }
    
    public boolean riproponiScarti(String COD_SERVIZIO, String COD_CAUSALE_SCARTO, String COD_OLO, String DATA_DA, String DATA_A, String RICICLO_FATTURAZIONE_CORRENTE) throws RemoteException,CustomException {
        Connection conn=null;
        CallableStatement cs = null;
        ResultSet rs=null;
       
        try
        {
        
            conn = getConnection(dsName);
            cs = conn.prepareCall(callUpdateScarti);
            cs.setString(1, COD_SERVIZIO);
            cs.setString(2, COD_CAUSALE_SCARTO);
            cs.setString(3, COD_OLO);
            cs.setString(4, DATA_DA);
            cs.setString(5, DATA_A);
            cs.setString(6, RICICLO_FATTURAZIONE_CORRENTE);
            cs.execute();
            
        } catch(SQLException e)
        {
            System.out.println (e.getMessage());
            e.printStackTrace();
            throw new CustomException(e.toString(),"Errore di accesso al package PKG_SCARTI.riproponiScarti","riproponiScarti","I5_5ANAG_SCARTI",StaticContext.FindExceptionType(e));    
        } finally
        {
            try
            {
                if (rs != null){
                rs.close();
                }
                cs.close();
            } catch(Exception e){}
            try
            {
                conn.close();
            } catch(Exception e){}
        }
          
     return true;       
    }
}