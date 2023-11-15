package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import com.ejbSTL.I5_2CONFR_INVENT_ROW;
import java.util.Vector;
import java.rmi.RemoteException;
import java.sql.*;
import oracle.jdbc.OracleTypes;
import com.utl.*;

public class I5_2CONFR_INVENTBean extends com.utl.AbstractSessionCommonBean implements SessionBean 
{
  private static final String findAllByCode_elab ="{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_2CONFR_INVENTFindAll(?,?) }";
  
  
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
	public Vector findAllByCode_elab(String Code_elab,String Flag_sys) throws RemoteException,CustomException
	{
		Connection conn=null;
    CallableStatement cs = null;
    ResultSet rs=null;
    I5_2CONFR_INVENT_ROW row = null;
    Vector recs = new Vector();

		try
		{

			conn = getConnection(dsName);
      cs = conn.prepareCall(findAllByCode_elab);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setString(2,Code_elab);    
      cs.setString(3,Flag_sys);          
      cs.execute();

			rs = (ResultSet)cs.getObject(1);
			while(rs.next())
			{
        row =  new I5_2CONFR_INVENT_ROW();        
        row.setCode_confr_invent(rs.getString("Code_confr_invent"));        
        row.setCode_Account(rs.getString("Code_Account"));                        
        row.setDesc_account(rs.getString("Desc_account"));
        row.setNome_rag_soc_gest(rs.getString("Nome_rag_soc_gest"));
        row.setQnta_ps_invent(new Integer(rs.getInt("Qnta_ps_invent")));
        row.setNum_ps_reg(new Integer(rs.getInt("Num_ps_reg")));
        row.setQnta_ps_atvti_invent(new Integer(rs.getInt("Qnta_ps_atvti_invent")));
        row.setQnta_ps_dis_st(new Integer(rs.getInt("Qnta_ps_dis_st")));
        row.setQnta_scarti(new Integer(rs.getInt("Qnta_scarti")));
        recs.add(row);
			} 
		} catch(SQLException e)
		{
			System.out.println (e.getMessage());
      e.printStackTrace();    
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2CONFR_INVENT","findAllByCode_elab","I5_2CONFR_INVENT",StaticContext.FindExceptionType(e));    
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
