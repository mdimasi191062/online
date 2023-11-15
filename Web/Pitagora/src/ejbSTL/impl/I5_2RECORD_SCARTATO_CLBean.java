package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import com.ejbSTL.I5_2RECORD_SCARTATO_CL_ROW;
import java.util.Vector;
import java.rmi.RemoteException;
import java.sql.*;
import oracle.jdbc.OracleTypes;
import com.utl.*;

public class I5_2RECORD_SCARTATO_CLBean extends com.utl.AbstractSessionCommonBean implements SessionBean 
{
  private static final String findAllStatement ="{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_2RECORD_SCARTATO_CLfindAll(?,?,?) }";

  private static final String findAllStatement_CPM ="{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_2RCRD_SCRTT_CL_CPMfindAll(?,?,?) }";
  
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
  public Vector findAll(String Code_Account,String Flag_sys,String Code_elab) throws RemoteException,CustomException
	{
		Connection conn=null;
    CallableStatement cs = null;
    ResultSet rs=null;
    I5_2RECORD_SCARTATO_CL_ROW row = null;
    Vector recs = new Vector();

		try
		{

			conn = getConnection(dsName);
      cs = conn.prepareCall(findAllStatement);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setString(2,Code_Account);
      cs.setString(3,Flag_sys);
      cs.setString(4,Code_elab);      
      cs.execute();
			rs = (ResultSet)cs.getObject(1);
			while(rs.next())
			{
        row =  new I5_2RECORD_SCARTATO_CL_ROW();
        row.setCode_Scarto(rs.getString("Code_Scarto"));
        row.setDesc_Motivo_Scarto(rs.getString("Desc_Motivo_Scarto"));
        row.setCode_Istanza_Ps(rs.getString("Code_Istanza_Ps"));
        row.setDesc_Valo_Attuale(rs.getString("Desc_Valo_Attuale"));        
        row.setDesc_Valo_St(rs.getString("Desc_Valo_St"));                
        recs.add(row);
			} 
		} catch(SQLException e)
		{
			System.out.println (e.getMessage());
      e.printStackTrace();
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2RECORD_SCARTATO_CL","findAll","I5_2RECORD_SCARTATO_CL",StaticContext.FindExceptionType(e));    
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
  
  public Vector findAll_CPM(String Code_Account,String Flag_sys,String Code_elab) throws RemoteException,CustomException
	{
		Connection conn=null;
    CallableStatement cs = null;
    ResultSet rs=null;
    I5_2RECORD_SCARTATO_CL_ROW row = null;
    Vector recs = new Vector();

		try
		{

			conn = getConnection(dsName);
      cs = conn.prepareCall(findAllStatement_CPM);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setString(2,Code_Account);
      cs.setString(3,Flag_sys);
      cs.setString(4,Code_elab);      
      cs.execute();

			rs = (ResultSet)cs.getObject(1);
			while(rs.next())
			{
        row =  new I5_2RECORD_SCARTATO_CL_ROW();
        row.setCode_Scarto(rs.getString("Code_Scarto"));
        row.setDesc_Motivo_Scarto(rs.getString("Desc_Motivo_Scarto"));
        row.setCode_Istanza_Ps(rs.getString("Code_Istanza_Ps"));
        row.setTipo_Scarto(rs.getString("Tipo_Scarto"));                      
        recs.add(row);
			} 
		} catch(SQLException e)
		{
			System.out.println (e.getMessage());
      e.printStackTrace();
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2RECORD_SCARTATO_CL","findAll_CPM","I5_2RECORD_SCARTATO_CL",StaticContext.FindExceptionType(e));          
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
  
}