package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.sql.*;
import java.text.*;
import java.util.*;
import java.rmi.RemoteException;
import oracle.jdbc.OracleTypes;
import com.ejbSTL.I5_2TEST_AVANZ_COSTI_RICAVI_ROW;
import com.utl.StaticContext;

public class I5_2TEST_AVANZ_COSTI_RICAVIBean extends com.utl.AbstractSessionCommonBean  implements SessionBean 
{

  private static final String findAllPCStatement ="{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_2TEST_AVANZ_C_R_findAllPC(?) }";
  private static final String findAllStatement ="{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_2TEST_AVANZ_C_R_findAll(?,?) }";
  private static final String PresenzaAccountStatement ="{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_2TEST_AVANZ_C_R_PrAcc(?,?,?,?) }";
  private static final String UpdateDateStatement ="{? = call " + StaticContext.PACKAGE_CLASSIC + ".I5_2TEST_AVANZ_C_R_UpdateDate(?) }";  

  Connection conn=null;
  CallableStatement cs = null;

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

  public void UpdateDate(String code_stato_avanz_ricavi_update) throws RemoteException
	{

		try
		{

			conn = getConnection(dsName);
      cs = conn.prepareCall(UpdateDateStatement);
      cs.registerOutParameter(1, OracleTypes.NUMBER);
      cs.setString(2,code_stato_avanz_ricavi_update);
      cs.execute();
		} catch(Exception e)
		{
			System.out.println (e.getMessage());
      e.printStackTrace();
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
  
  public String PresenzaAccount(String Code_account,String Flag_Sys,String Mese,String Anno) throws RemoteException
	{
    String CodiceRitorno=null;
		try
		{

			conn = getConnection(dsName);
      cs = conn.prepareCall(PresenzaAccountStatement);
      cs.registerOutParameter(1, OracleTypes.VARCHAR);
      cs.setString(2,Code_account);
      cs.setString(3,Flag_Sys);
      cs.setString(4,Mese);      
      cs.setString(5,Anno);            
      cs.execute();
      CodiceRitorno=cs.getString(1);

		} catch(Exception e)
		{
			System.out.println (e.getMessage());
      e.printStackTrace();
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
		return CodiceRitorno;
	}
  
  public Vector findAllPC(String CODE_TIPO_CONTR) throws RemoteException
	{
    I5_2TEST_AVANZ_COSTI_RICAVI_ROW row = null;
    Vector recs = new Vector();    
    String AnnoMese = null;
    SimpleDateFormat df = new SimpleDateFormat ("dd/MM/yyyy");
    java.util.Date app = null;
		try
		{

			conn = getConnection(dsName);
      cs = conn.prepareCall(findAllPCStatement);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setString(2,CODE_TIPO_CONTR);
      cs.execute();

			ResultSet rs = (ResultSet)cs.getObject(1);
			while(rs.next())
			{
        row =  new I5_2TEST_AVANZ_COSTI_RICAVI_ROW();
        AnnoMese = Integer.toString(rs.getInt("DataPeriodoCompetenza"));
        row.setAnno(AnnoMese.substring(0,4));
        row.setMese(AnnoMese.substring(4));
        df = new SimpleDateFormat ("dd/MM/yyyy");
        app = df.parse("01/" + row.getMese() + "/" + row.getAnno());
        df = new SimpleDateFormat("MMMM",Locale.ITALIAN);
        row.setPeriodoCompetenza(df.format(app) + " " + row.getAnno());
        recs.add(row);
			} 
		} catch(Exception e)
		{
			System.out.println (e.getMessage());
      e.printStackTrace();
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
		return recs;
	}

  public Vector findAll(String CODE_ELAB,String Flag_Sys) throws RemoteException
	{
    SimpleDateFormat df = new SimpleDateFormat ("dd/MM/yyyy");
    java.util.Date app = null;
    I5_2TEST_AVANZ_COSTI_RICAVI_ROW row = null;
    Vector recs = new Vector();    
    String AnnoMese = null;

		try
		{

			conn = getConnection(dsName);
      cs = conn.prepareCall(findAllStatement);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setString(2,CODE_ELAB);
      cs.setString(3,Flag_Sys);      
      cs.execute();

			ResultSet rs = (ResultSet)cs.getObject(1);
			while(rs.next())
			{
        row =  new I5_2TEST_AVANZ_COSTI_RICAVI_ROW();
        row.setCode_Stato_Avanz_Ricavi(rs.getString("Code_Stato_Avanz_Ricavi"));
        row.setCode_Stato_Batch(rs.getString("Code_Stato_Batch"));  
        row.setCode_Account(rs.getString("Code_Account"));
        row.setFlag_Sys(rs.getString("Flag_Sys"));         
        row.setDesc_Account(rs.getString("Desc_Account"));
        row.setNome_Rag_Soc_Gest(rs.getString("Nome_Rag_Soc_Gest"));
        row.setAnno(rs.getString("data_aa_comptz"));
        row.setMese(rs.getString("data_mm_comptz"));
        df = new SimpleDateFormat ("dd/MM/yyyy");
        app = df.parse("01/" + row.getMese() + "/" + row.getAnno());
        df = new SimpleDateFormat("MMMM",Locale.ITALIAN);
        row.setMese(df.format(app) );
        recs.add(row);
			} 
		} catch(Exception e)
		{
			System.out.println (e.getMessage());
      e.printStackTrace();
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
		return recs;
	}
}