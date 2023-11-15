package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import javax.ejb.EJBException;
import com.ejbSTL.I5_3GEST_TLC_ROW;
import java.util.Vector;
import java.rmi.RemoteException;
import java.sql.*;
import oracle.jdbc.OracleTypes;
import com.utl.*;

public class I5_3GEST_TLCejbBean extends com.utl.AbstractSessionCommonBean implements SessionBean 
{

  private static final String findAllNormStatement ="{? = call " + StaticContext.PACKAGE_COMMON +".I5_3GEST_TLCfindAllNorm(?) }";
  private static final String findAllNuoviStatement ="{? = call " + StaticContext.PACKAGE_COMMON +".I5_3GEST_TLCfindAllNuovi() }";
  private static final String loadGestNormStatement ="{? = call " + StaticContext.PACKAGE_COMMON +".I5_3GEST_TLCloadGestNorm(?) }";
  private static final String updateGestNormStatement ="{? = call " + StaticContext.PACKAGE_COMMON +".I5_3GEST_TLCupdateGestNorm(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }";
  private static final String associaNuovoGestStatement ="{? = call " + StaticContext.PACKAGE_COMMON +".I5_3GEST_TLCassociaNuovoGest(?,?,?) }";
  private static final String inserisciNuovoGestStatement ="{? = call " + StaticContext.PACKAGE_COMMON +".I5_3GEST_TLCinserisciNuovoGest(?,?,?) }";


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
	public Vector findAllNorm(String ragionesociale) throws RemoteException,CustomException
	{
		Connection conn=null;
    CallableStatement cs = null;
  	ResultSet rs = null;
    I5_3GEST_TLC_ROW row = null;
    Vector recs = new Vector();

		try
		{

			conn = getConnection(dsName);
      cs = conn.prepareCall(findAllNormStatement);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setString(2,ragionesociale);
      cs.execute();

			rs = (ResultSet)cs.getObject(1);
			while(rs.next())
			{
        row =  new I5_3GEST_TLC_ROW();
        row.setCODE_GEST(rs.getString("CODE_GEST"));
        row.setCODE_TIPOL_OPERATORE(rs.getString("CODE_TIPOL_OPERATORE"));
        row.setCODE_TIPO_GEST(rs.getString("CODE_TIPO_GEST"));
        row.setNOME_RAG_SOC_GEST(rs.getString("NOME_RAG_SOC_GEST"));
        row.setNOME_GEST_SIGLA(rs.getString("NOME_GEST_SIGLA"));
        row.setCODE_PARTITA_IVA(rs.getString("CODE_PARTITA_IVA"));
        row.setFLAG_CLASSIC(rs.getString("FLAG_CLASSIC"));
        row.setFLAG_SPECIAL(rs.getString("FLAG_SPECIAL"));
        recs.add(row);
			} 
		} catch(SQLException e)
		{
			System.out.println (e.getMessage());
      e.printStackTrace();
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_3GEST_TLC","findAllNorm","I5_3GEST_TLC",StaticContext.FindExceptionType(e));          
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
	public Vector findAllNuovi() throws RemoteException,CustomException
	{
		Connection conn=null;
    CallableStatement cs = null;
    ResultSet rs =null;
    I5_3GEST_TLC_ROW row = null;
    Vector recs = new Vector();

		try
		{

			conn = getConnection(dsName);
      cs = conn.prepareCall(findAllNuoviStatement);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.execute();

			rs = (ResultSet)cs.getObject(1);
			while(rs.next())
			{
        row =  new I5_3GEST_TLC_ROW();
        row.setCODE_GEST(rs.getString("CODE_GEST"));
        row.setCODE_TIPOL_OPERATORE(rs.getString("CODE_TIPOL_OPERATORE"));
        row.setNOME_RAG_SOC_GEST(rs.getString("NOME_RAG_SOC_GEST"));
        row.setCODE_TIPO_GEST(rs.getString("CODE_TIPO_GEST"));
        row.setNOME_GEST_SIGLA(rs.getString("NOME_GEST_SIGLA"));
        row.setCODE_PARTITA_IVA(rs.getString("CODE_PARTITA_IVA"));
        row.setFLAG_SYS(rs.getString(7));
        recs.add(row);
			} 
		} catch(SQLException e)
		{
			System.out.println (e.getMessage());
      e.printStackTrace();
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_3GEST_TLC","findAllNuovi","I5_3GEST_TLC",StaticContext.FindExceptionType(e));                
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

	public I5_3GEST_TLC_ROW loadGestNorm(String codice) throws RemoteException,CustomException
	{
		Connection conn=null;
    CallableStatement cs = null;
    ResultSet rs = null;
    I5_3GEST_TLC_ROW row = null;
		try
		{

			conn = getConnection(dsName);
      cs = conn.prepareCall(loadGestNormStatement);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setString(2,codice);
      cs.execute();

			rs = (ResultSet)cs.getObject(1);
			while(rs.next())
			{
        row =  new I5_3GEST_TLC_ROW();
        row.setCODE_GEST(rs.getString("CODE_GEST"));
        row.setCODE_TIPOL_OPERATORE(rs.getString("CODE_TIPOL_OPERATORE"));
        row.setCODE_TIPO_GEST(rs.getString("CODE_TIPO_GEST"));
        row.setCODE_COMUNE_SEDE_LEGALE(rs.getString("CODE_COMUNE_SEDE_LEGALE"));
        row.setCODE_COMUNE_SEDE_CENTRALE(rs.getString("CODE_COMUNE_SEDE_CENTRALE"));
        row.setNOME_RAG_SOC_GEST(rs.getString("NOME_RAG_SOC_GEST"));
        row.setCODE_TIPO_GEST(rs.getString("CODE_TIPO_GEST"));
        row.setNOME_GEST_SIGLA(rs.getString("NOME_GEST_SIGLA"));
        row.setCODE_PARTITA_IVA(rs.getString("CODE_PARTITA_IVA"));
        row.setINDR_VIA_SEDE_LEGALE(rs.getString("INDR_VIA_SEDE_LEGALE"));
        row.setINDR_CIV_SEDE_LEGALE(rs.getString("INDR_CIV_SEDE_LEGALE"));
        row.setCODE_CAP_SEDE_LEGALE(rs.getString("CODE_CAP_SEDE_LEGALE"));
        row.setINDR_TEL_SEDE_LEGALE(rs.getString("INDR_TEL_SEDE_LEGALE"));
        row.setINDR_FAX_SEDE_LEGALE(rs.getString("INDR_FAX_SEDE_LEGALE"));
        row.setINDR_CIV_SEDE_CENTRALE(rs.getString("INDR_CIV_SEDE_CENTRALE"));
        row.setINDR_VIA_SEDE_CENTRALE(rs.getString("INDR_VIA_SEDE_CENTRALE"));
        row.setCODE_CAP_SEDE_CENTRALE(rs.getString("CODE_CAP_SEDE_CENTRALE"));
        row.setINDR_TEL_SEDE_CENTRALE(rs.getString("INDR_TEL_SEDE_CENTRALE"));
        row.setINDR_FAX_SEDE_CENTRALE(rs.getString("INDR_FAX_SEDE_CENTRALE"));
        row.setINDR_INTERNET(rs.getString("INDR_INTERNET"));
        row.setTEXT_NOTE(rs.getString("TEXT_NOTE"));
        row.setQNTA_DIP(new Integer(rs.getInt("QNTA_DIP")));
        row.setTEXT_ALLEANZE(rs.getString("TEXT_ALLEANZE"));
        row.setTEXT_INFO_ESTERO(rs.getString("TEXT_INFO_ESTERO"));
        row.setTEXT_DIP(rs.getString("TEXT_DIP"));
        row.setTEXT_TIPOL_OPERATORE(rs.getString("TEXT_TIPOL_OPERATORE"));
        row.setCODE_GEST_TIRKS(rs.getString("CODE_GEST_TIRKS"));
			} 
		} catch(SQLException e)
		{
			System.out.println (e.getMessage());
      e.printStackTrace();
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_3GEST_TLC","loadGestNorm","I5_3GEST_TLC",StaticContext.FindExceptionType(e));                      
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
		return row;
	}
	public void updateGestNorm(I5_3GEST_TLC_ROW row) throws RemoteException,CustomException
	{
		Connection conn=null;
    CallableStatement cs = null;
    String ret =null;
		try
		{
			conn = getConnection(dsName);
      cs = conn.prepareCall(updateGestNormStatement);
      cs.registerOutParameter(1, OracleTypes.VARCHAR);
      cs.setString(2,row.getCODE_GEST());
      cs.setString(3,row.getCODE_TIPOL_OPERATORE());
      cs.setString(4,row.getCODE_TIPO_GEST());
      cs.setString(5,row.getCODE_COMUNE_SEDE_LEGALE());
      cs.setString(6,row.getCODE_COMUNE_SEDE_CENTRALE());
      cs.setString(7,row.getNOME_RAG_SOC_GEST());
      cs.setString(8,row.getNOME_GEST_SIGLA());
      cs.setString(9,row.getCODE_PARTITA_IVA());
      cs.setString(10,row.getINDR_VIA_SEDE_LEGALE());
      cs.setString(11,row.getINDR_CIV_SEDE_LEGALE());
      cs.setString(12,row.getCODE_CAP_SEDE_LEGALE());
      cs.setString(13,row.getINDR_TEL_SEDE_LEGALE());
      cs.setString(14,row.getINDR_FAX_SEDE_LEGALE());
      cs.setString(15,row.getINDR_VIA_SEDE_CENTRALE());
      cs.setString(16,row.getINDR_CIV_SEDE_CENTRALE());
      cs.setString(17,row.getCODE_CAP_SEDE_CENTRALE());
      cs.setString(18,row.getINDR_TEL_SEDE_CENTRALE());
      cs.setString(19,row.getINDR_FAX_SEDE_CENTRALE());
      cs.setString(20,row.getINDR_INTERNET());
      cs.setString(21,row.getTEXT_NOTE());
      if (row.getQNTA_DIP()!=null)
      {
        cs.setInt(22,row.getQNTA_DIP().intValue());
      }
      else
      {
        cs.setNull(22,OracleTypes.VARCHAR);
      }
      cs.setString(23,row.getTEXT_ALLEANZE());
      cs.setString(24,row.getTEXT_INFO_ESTERO());
      cs.setString(25,row.getTEXT_DIP());
      cs.setString(26,row.getTEXT_TIPOL_OPERATORE());
      cs.setString(27,row.getCODE_GEST_TIRKS());
      cs.execute();
      ret = cs.getString(1);
      if(!ret.equals(row.getCODE_GEST()))
      {
        throw new EJBException(ret);
      }

		} 
    catch(SQLException e)
		{
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_3GEST_TLC","updateGestNorm","I5_3GEST_TLC",StaticContext.FindExceptionType(e));                      
		} finally
		{
			try
			{
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
	} 


  public void associaNuovoGest(String CODE_GEST_ORIG, String FLAG_SYS, String CODE_GEST) throws RemoteException,CustomException
	{
		Connection conn=null;
    CallableStatement cs = null;
    String ret =null;
		try
		{
			conn = getConnection(dsName);
      cs = conn.prepareCall(associaNuovoGestStatement);
      cs.registerOutParameter(1, OracleTypes.VARCHAR);
      cs.setString(2,CODE_GEST_ORIG);
      cs.setString(3,FLAG_SYS);
      cs.setString(4,CODE_GEST);
      cs.execute();
      ret = cs.getString(1);
      if(!ret.equals(CODE_GEST_ORIG))
      {
        throw new EJBException(ret);
      }

		} 
    catch(SQLException e)
		{
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_3GEST_TLC","associaNuovoGest","I5_3GEST_TLC",StaticContext.FindExceptionType(e));                      
		} finally
		{
			try
			{
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
	}  

  public int inserisciNuovoGest(String CODE_GEST_ORIG, String FLAG_SYS, String CODE_GEST) throws RemoteException,CustomException
	{
		Connection conn=null;
    CallableStatement cs = null;
    String ret =null;
    int i = 1;
		try
		{
			conn = getConnection(dsName);
      cs = conn.prepareCall(inserisciNuovoGestStatement);
      cs.registerOutParameter(1, OracleTypes.VARCHAR);
      cs.setString(2,CODE_GEST_ORIG);
      cs.setString(3,FLAG_SYS);
      cs.setString(4,CODE_GEST);
      cs.execute();
      ret = cs.getString(1);
      if(!ret.equals(CODE_GEST_ORIG))
      {
        if(ret.equals("0"))
        {
          i=0;
        }
        else
        {
          throw new EJBException(ret);
        }
      }
		} 
    catch(SQLException e)
		{
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_3GEST_TLC","inserisciNuovoGest","I5_3GEST_TLC",StaticContext.FindExceptionType(e));                      

		} finally
		{
			try
			{
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
    return i;
	}  
}