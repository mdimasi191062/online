package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import com.ejbSTL.I5_2PARAM_VALORIZ_CL_ROW;
import java.util.Vector;
import java.rmi.RemoteException;
import java.sql.*;
import oracle.jdbc.OracleTypes;
import com.utl.*;

public class I5_2PARAM_VALORIZ_CLBean extends com.utl.AbstractSessionCommonBean implements SessionBean 
{
  private static final String findAllStatement ="{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_2PARAM_VALORIZ_CL_FindAll(?,?) }";
  private static final String I5_2PARAM_VALORIZ_CL_INSStatement ="{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_2PARAM_VALORIZ_CL_INS() }";
  private static final String I5_2PARAM_VALORIZ_CL_CHECKXINSStatement ="{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_2PARAM_VALORIZ_CL_CHECKXINS() }";
  private static final String CHECKBATCHStatement ="{? = call " + StaticContext.PACKAGE_CLASSIC + ".CHECK_BATCH() }";
  private static final String I5_2PARAM_VALORIZ_CL_CKCONGStatement ="{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_2PARAM_VALORIZ_CL_CKCONG(?,?,?) }";
  private static final String I5_2PARAM_VALORIZ_CL_CHECKVEStatement ="{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_2PARAM_VALORIZ_CL_CHECKVE(?,?,?) }";
  private static final String I5_2PARAM_VALORIZ_CL_UPDATEStatement ="{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_2PARAM_VALORIZ_CL_UPDATE(?,?,?) }";
  private static final String I5_2PARAM_VALORIZ_Cl_CICLI_FATStatement   ="{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_2PARAM_VALORIZ_Cl_CICLI_FAT(?,?,?) }";  
  private static final String I5_2PARAM_VALORIZ_Cl_C_F_CPMStatement   ="{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_2PARAM_VALORIZ_Cl_C_F_CPM(?,?,?) }";  

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
	public Vector findAll(java.util.Date DATA_INIZIO_CICLO_FATRZ,java.util.Date DATA_FINE_CICLO_FATRZ) throws RemoteException,CustomException
	{
		Connection conn=null;
    CallableStatement cs = null;
    ResultSet rs=null;
    I5_2PARAM_VALORIZ_CL_ROW row = null;
    Vector recs = new Vector();

		try
		{

			conn = getConnection(dsName);
      cs = conn.prepareCall(findAllStatement);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      if (DATA_INIZIO_CICLO_FATRZ != null)
      {
        cs.setDate(2,new java.sql.Date(DATA_INIZIO_CICLO_FATRZ.getTime()));
      }
      else
      {
        cs.setNull(2,Types.DATE);
      }
      if (DATA_FINE_CICLO_FATRZ != null)
      {
        cs.setDate(3,new java.sql.Date(DATA_FINE_CICLO_FATRZ.getTime()));
      }
      else
      {
        cs.setNull(3,Types.DATE);
      }

      
      cs.execute();

			rs = (ResultSet)cs.getObject(1);
			while(rs.next())
			{
        row =  new I5_2PARAM_VALORIZ_CL_ROW();
        row.setValo_euribor(new Float(rs.getFloat("VALO_EURIBOR")));
        row.setPeriodo_rif(rs.getString("DATA_CONCAT"));
        row.setData_inizio_ciclo_fatrz(rs.getDate("DATA_INIZIO_CICLO_FATRZ"));
        row.setData_fine_ciclo_fatrz(rs.getDate("DATA_FINE_CICLO_FATRZ"));
        recs.add(row);
			} 
		} catch(SQLException e)
		{
			System.out.println (e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2PARAM_VALORIZ_CL","FindAll","I5_2PARAM_VALORIZ_CL",StaticContext.FindExceptionType(e));
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
        System.out.println (e.getMessage());
			}
			try
			{
				conn.close();
			} catch(Exception e)
			{
        System.out.println (e.getMessage());
			}
		}
		return recs;
	}


	public I5_2PARAM_VALORIZ_CL_ROW loadObjectInsert() throws RemoteException,CustomException
	{
		Connection conn=null;
    CallableStatement cs = null;
    I5_2PARAM_VALORIZ_CL_ROW row = null;
    ResultSet rs=null;
    
		try
		{

			conn = getConnection(dsName);
      cs = conn.prepareCall(I5_2PARAM_VALORIZ_CL_INSStatement);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.execute();
			rs = (ResultSet)cs.getObject(1);
			if(rs.next())
			{
        row =  new I5_2PARAM_VALORIZ_CL_ROW();
        row.setPeriodo_rif(rs.getString("DATA_CONCAT"));
        row.setData_inizio_ciclo_fatrz(rs.getDate("DATA_INIZIO_CICLO_FATRZ"));
        row.setData_fine_ciclo_fatrz(rs.getDate("DATA_FINE_CICLO_FATRZ"));
			} 
      rs.close();
		} catch(SQLException e)
		{
			System.out.println (e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2PARAM_VALORIZ_CL","loadObjectInsert","I5_2PARAM_VALORIZ_CL",StaticContext.FindExceptionType(e));
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
        System.out.println (e.getMessage());
			}
			try
			{
				conn.close();
			} catch(Exception e)
			{
        System.out.println (e.getMessage());
			}
		}
		return row;
	}
	public int checkxInserimento() throws RemoteException,CustomException
	{
    // restituisce il num di righe che soddisfano la condizione
		Connection conn=null;
    CallableStatement cs = null;
    int ret=0;
		try
		{

			conn = getConnection(dsName);
      cs = conn.prepareCall(I5_2PARAM_VALORIZ_CL_CHECKXINSStatement);
      cs.registerOutParameter(1, Types.INTEGER);
      cs.execute();
			ret = cs.getInt(1);
		} catch(SQLException e)
		{
			System.out.println (e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2PARAM_VALORIZ_CL","checkxInserimento","I5_2PARAM_VALORIZ_CL",StaticContext.FindExceptionType(e));
		} finally
		{
			try
			{
				cs.close();
			} catch(Exception e)
			{
       System.out.println (e.getMessage());
			}
			try
			{
				conn.close();
			} catch(Exception e)
			{
        System.out.println (e.getMessage());
			}
		}
		return ret;
	}
	public int checkBatch() throws RemoteException,CustomException
	{
    
		Connection conn=null;
    CallableStatement cs = null;
    int ret=0;
		try
		{

			conn = getConnection(dsName);
      cs = conn.prepareCall(CHECKBATCHStatement);
      cs.registerOutParameter(1, Types.INTEGER);
      cs.execute();
      ret = cs.getInt(1);
		} catch(SQLException e)
		{
			System.out.println (e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2PARAM_VALORIZ_CL","checkBatch","I5_2PARAM_VALORIZ_CL",StaticContext.FindExceptionType(e));
		} finally
		{
			try
			{
				cs.close();
			} catch(Exception e)
			{
        System.out.println (e.getMessage());
			}
			try
			{
				conn.close();
			} catch(Exception e)
			{
        System.out.println (e.getMessage());
			}
		}
		return ret;
	}
	public int checkCongelamento(Float Valore, java.util.Date DATA_INIZIO,java.util.Date DATA_FINE) throws RemoteException,CustomException
	{
    
		Connection conn=null;
    CallableStatement cs = null;
    int ret=0;
		try
		{

			conn = getConnection(dsName);
      cs = conn.prepareCall(I5_2PARAM_VALORIZ_CL_CKCONGStatement);
      cs.registerOutParameter(1, Types.INTEGER);
      cs.setFloat(2,Valore.floatValue());
      cs.setDate(3,new java.sql.Date(DATA_INIZIO.getTime()));
      cs.setDate(4,new java.sql.Date(DATA_FINE.getTime()));
      cs.execute();

			ret = cs.getInt(1);
		} catch(SQLException e)
		{
			System.out.println (e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2PARAM_VALORIZ_CL","checkBatch","checkCongelamento",StaticContext.FindExceptionType(e));
		} finally
		{
			try
			{
				cs.close();
			} catch(Exception e)
			{
        System.out.println (e.getMessage());
			}
			try
			{
				conn.close();
			} catch(Exception e)
			{
        System.out.println (e.getMessage());
			}
		}
		return ret;
	}
  
	public int checkValoreEuribor(Float Valore, java.util.Date DATA_INIZIO,java.util.Date DATA_FINE) throws RemoteException,CustomException
	{
    
		Connection conn=null;
    CallableStatement cs = null;
    int ret=0;
		try
		{

			conn = getConnection(dsName);
      cs = conn.prepareCall(I5_2PARAM_VALORIZ_CL_CHECKVEStatement);
      cs.registerOutParameter(1, Types.INTEGER);
      cs.setDouble(2,Valore.doubleValue());
      cs.setDate(3,new java.sql.Date(DATA_INIZIO.getTime()));
      cs.setDate(4,new java.sql.Date(DATA_FINE.getTime()));
      cs.execute();

			ret = cs.getInt(1);
		} catch(SQLException e)
		{
			System.out.println (e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2PARAM_VALORIZ_CL","checkValoreEuribor","checkCongelamento",StaticContext.FindExceptionType(e));
		} finally
		{
			try
			{
				cs.close();
			} catch(Exception e)
			{
        System.out.println (e.getMessage());
			}
			try
			{
				conn.close();
			} catch(Exception e)
			{
        System.out.println (e.getMessage());
			}
		}
		return ret;
	}
	public int updateValoreEuribor(Float Valore, java.util.Date DATA_INIZIO,java.util.Date DATA_FINE) throws RemoteException,CustomException
	{
    
		Connection conn=null;
    CallableStatement cs = null;
    int ret=0;
		try
		{

			conn = getConnection(dsName);
      cs = conn.prepareCall(I5_2PARAM_VALORIZ_CL_UPDATEStatement);
      cs.registerOutParameter(1, Types.INTEGER);
      if (Valore!=null)
      {
        double appo=Valore.doubleValue();
        cs.setDouble(2,appo);
      }
      else
      {
        cs.setNull(2,Types.FLOAT);
      }
      cs.setDate(3,new java.sql.Date(DATA_INIZIO.getTime()));
      cs.setDate(4,new java.sql.Date(DATA_FINE.getTime()));
      cs.execute();

			ret = cs.getInt(1);
		} catch(SQLException e)
		{
			System.out.println (e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2PARAM_VALORIZ_CL","updateValoreEuribor","checkCongelamento",StaticContext.FindExceptionType(e));
		} finally
		{
			try
			{
				cs.close();
			} catch(Exception e)
			{
        System.out.println (e.getMessage());
			}
			try
			{
				conn.close();
			} catch(Exception e)
			{
        System.out.println (e.getMessage());
			}
		}
		return ret;
	}  
  
  public I5_2PARAM_VALORIZ_CL_ROW CicloDiFatturazione(String CODE_TIPO_CONTR) throws RemoteException,CustomException
	{
    I5_2PARAM_VALORIZ_CL_ROW row =null;
		Connection conn=null;
    CallableStatement cs = null;
    int ret=0;
		try
		{
			conn = getConnection(dsName);
      cs = conn.prepareCall(I5_2PARAM_VALORIZ_Cl_CICLI_FATStatement);
      cs.registerOutParameter(1, Types.INTEGER);
      cs.registerOutParameter(3, Types.DATE);
      cs.registerOutParameter(4, Types.DATE);
      cs.setString(2,CODE_TIPO_CONTR);
      cs.execute();
        //sE ABBIAMO TROVATO DATI VALORIZZO LA RIGA
      if (cs.getInt(1)==1){
        row = new  I5_2PARAM_VALORIZ_CL_ROW();
        row.setData_inizio_ciclo_fatrz(cs.getDate(3));
        row.setData_fine_ciclo_fatrz(cs.getDate(4));      
      }  
		} catch(SQLException e)
		{
			System.out.println (e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2PARAM_VALORIZ_CL","CicloDiFatturazione","checkCongelamento",StaticContext.FindExceptionType(e));
		} finally
		{
			try
			{
				cs.close();
			} catch(Exception e)
			{
        System.out.println (e.getMessage());
			}
			try
			{
				conn.close();
			} catch(Exception e)
			{
        System.out.println (e.getMessage());
			}
		}
		return row;
	}  

  public I5_2PARAM_VALORIZ_CL_ROW CicloDiFatturazione_CPM(String CODE_TIPO_CONTR) throws RemoteException,CustomException
	{
    I5_2PARAM_VALORIZ_CL_ROW row =null;
		Connection conn=null;
    CallableStatement cs = null;
    int ret=0;
		try
		{
			conn = getConnection(dsName);
      cs = conn.prepareCall(I5_2PARAM_VALORIZ_Cl_C_F_CPMStatement);
      cs.registerOutParameter(1, Types.INTEGER);
      cs.registerOutParameter(3, Types.DATE);
      cs.registerOutParameter(4, Types.DATE);
      cs.setString(2,CODE_TIPO_CONTR);
      cs.execute();
      if (cs.getInt(1)==1){
        row = new  I5_2PARAM_VALORIZ_CL_ROW();
        row.setData_inizio_ciclo_fatrz(cs.getDate(3));
        row.setData_fine_ciclo_fatrz(cs.getDate(4));      
      }              
		} catch(SQLException e)
		{
			System.out.println (e.getMessage());
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2PARAM_VALORIZ_CL","CicloDiFatturazione_CPM","checkCongelamento",StaticContext.FindExceptionType(e));
		} finally
		{
			try
			{
				cs.close();
			} catch(Exception e)
			{
        System.out.println (e.getMessage());
			}
			try
			{
				conn.close();
			} catch(Exception e)
			{
        System.out.println (e.getMessage());
			}
		}
		return row;
	}  


}