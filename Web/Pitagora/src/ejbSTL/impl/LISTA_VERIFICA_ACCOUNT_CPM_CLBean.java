package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import com.ejbSTL.LISTA_VERIFICA_ACCOUNT_CPM_CL_ROW;
import java.util.*;
import java.rmi.RemoteException;
import java.sql.*;
import oracle.jdbc.OracleTypes;
import java.text.SimpleDateFormat;
import com.utl.*;

public class LISTA_VERIFICA_ACCOUNT_CPM_CLBean extends com.utl.AbstractSessionCommonBean implements SessionBean 
{
  private static final String findAllStatement ="{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_2TEST_CSV_PENALI_FindAll(?,?) }";
  private static final String CPM_ErroreBloccanteStatement ="{? = call " + StaticContext.PACKAGE_CLASSIC + ".CPM_ErroreBloccante(?,?,?,?) }";
  private static final String CPM_CARICASCARTINBStatement ="{? = call " + StaticContext.PACKAGE_CLASSIC + ".CPM_CARICASCARTINB(?,?,?,?) }";

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
  public java.util.Vector findAll(String Code_elab,String Flag_sys,java.util.Date DataInizio,java.util.Date DataFine) throws RemoteException,CustomException{

		Connection conn=null;
    CallableStatement cs = null;
    CallableStatement cs1 = null;
    ResultSet rs =null;
    java.util.Date DATA_INIZIO_CICLO_FATRZ =null;
    LISTA_VERIFICA_ACCOUNT_CPM_CL_ROW row = null;
    Vector recs = new Vector();
    SimpleDateFormat df=null;
    
		try
		{
			conn = getConnection(dsName);
      cs = conn.prepareCall(findAllStatement);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setString(2,Code_elab);
      cs.setString(3,Flag_sys);
      cs.execute();

			rs = (ResultSet)cs.getObject(1);
			while(rs.next())
			{  
        row =  new LISTA_VERIFICA_ACCOUNT_CPM_CL_ROW();
        row.setNome_rag_soc_gest(rs.getString("Nome_rag_soc_gest"));
        row.setCode_account(rs.getString("Code_account"));
        row.setFlag_sys(rs.getString("Flag_sys"));
        row.setDesc_account(rs.getString("Desc_account"));        
        DATA_INIZIO_CICLO_FATRZ=rs.getDate("DATA_INIZIO_CICLO_FATRZ");
        df = new SimpleDateFormat("MMMM",Locale.ITALIAN);
        row.setMese(df.format(DATA_INIZIO_CICLO_FATRZ));
        df = new SimpleDateFormat("yyyy");
        row.setAnno(df.format(DATA_INIZIO_CICLO_FATRZ));        

        cs1 = conn.prepareCall(CPM_CARICASCARTINBStatement);
        cs1.registerOutParameter(1, OracleTypes.NUMBER);
        cs1.setString(2,row.getCode_account());
        cs1.setString(3,row.getFlag_sys());
        cs1.setDate(4,new java.sql.Date(DataInizio.getTime()));      
        cs1.setDate(5,new java.sql.Date(DataFine.getTime()));              
        cs1.execute();
        row.setScartiNB(cs1.getInt(1));      

        cs1 = conn.prepareCall(CPM_ErroreBloccanteStatement);
        cs1.registerOutParameter(1, OracleTypes.NUMBER);
        cs1.setString(2,row.getCode_account());
        cs1.setString(3,row.getFlag_sys());
        cs1.setDate(4,new java.sql.Date(DataInizio.getTime()));      
        cs1.setDate(5,new java.sql.Date(DataFine.getTime()));              
        cs1.execute();
        if (cs1.getInt(1)==0){
          row.setErroriBloccanti("N");    
        } else  {
          row.setErroriBloccanti("S");    
        }
        recs.add(row);
			} 
		} catch(SQLException e)
		{    
			System.out.println (e.getMessage());
      e.printStackTrace();
      throw new CustomException(e.toString(),"Errore di accesso alla tabella I5_2TEST_CSV_PENALI","findAll","I5_2TEST_CSV_PENALI",StaticContext.FindExceptionType(e));          
		} finally
		{
    try {
         if (rs != null){
          rs.close();
         }
	       cs.close();
         if (cs1 != null){
          cs1.close();
         }         
      } catch (Exception e) {}
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