package com.utl;

import java.rmi.RemoteException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.naming.InitialContext;
import javax.naming.Context;



import javax.sql.DataSource;

import com.utl.StaticContext;

public abstract class AbstractDataSource 
{

	protected Connection conn = null;
	protected PreparedStatement ps = null;

	protected String jdbcURL = StaticContext.JDBC_URL;
	protected String dsName  = StaticContext.DSNAME;

/** USING ONLY FOR DIRECT CONNECTION ******************************************/
/**  static {new oracle.jdbc.driver.OracleDriver();}                         **/  
/**  private Connection getConnection() throws SQLException, RemoteException **/
/**  {                                                                       **/
/**    DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());  **/
/**    return DriverManager.getConnection(jdbcURL);                          **/
/**  }                                                                       **/
/******************************************************************************/

	protected Connection getConnection(String dsName)
	throws SQLException, RemoteException
	{
		DataSource ds = getDataSource(dsName);
		return ds.getConnection();
	}

	protected Object getEnvironment(String envName) throws RemoteException
	{
		Object returnedObject=null;
		try
		{
			Context ic = new InitialContext();
			returnedObject = ic.lookup("java:comp/env/"+envName);
		} catch(NamingException e)
		{
			e.printStackTrace();
			throw new RemoteException(e.getMessage());
		}
		return returnedObject;
	}

	protected DataSource getDataSource(String dsName)
	throws RemoteException
	{
		DataSource ds = null;
		try
		{
			Context ic = new InitialContext();
			ds = (DataSource) ic.lookup(dsName);
		} catch(NamingException e)
		{
			e.printStackTrace();
			throw new RemoteException(e.getMessage());
		}
		return ds;
	}


}