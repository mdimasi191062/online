package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.util.Vector;
import java.sql.Connection;
import java.sql.CallableStatement;
import java.sql.Types;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.rmi.RemoteException;
import com.utl.CustomException;

import com.utl.StaticContext;

import oracle.jdbc.OracleTypes;

public class I5_6treeBean extends com.utl.AbstractSessionCommonBean implements SessionBean 
{

	private static final String findAllTreeByProfile = "{? = call "+StaticContext.PACKAGE_COMMON+".I5_6TREEfindAllByProfile(?) }";


	public Vector findAllTreeByProfile(String sProfile) throws CustomException,RemoteException
	{
		Connection conn=null;
    CallableStatement cs = null;

		Vector recs = new Vector();
		Vector row = null;

		try
		{

			conn = getConnection(dsName);
      cs = conn.prepareCall(findAllTreeByProfile);
      cs.registerOutParameter(1, OracleTypes.CURSOR);
      cs.setString(2,sProfile);
      cs.execute();

			ResultSet rs = (ResultSet)cs.getObject(1);

			while(rs.next())
			{
				row = new Vector();
				row.addElement(rs.getString("LIVELLO"));
				row.addElement(rs.getString("CODE_FUNZ"));
				row.addElement(rs.getString("CODE_FUNZ_FIGLIO"));
				row.addElement(rs.getString("DESC_TREE"));
				row.addElement(rs.getString("DESC_LINK"));        
				row.addElement(rs.getString("DESC_NOME_FRAME")); 
				recs.add(row);
			} 
      conn.close();
  		return recs;
		} 
    catch(Exception e)
		{ 
      try
      {
        if (conn!=null)
          conn.close();
      }
      catch(Exception ex)
      {
        System.out.println (e.getMessage());
        e.printStackTrace();
      }
      throw new CustomException(e.toString(),"Errore di accesso alla tabella dei nodi albero","findAllTreeByProfile","I5_6treeBean",StaticContext.FindExceptionType(e));
		}
	}
}