package com.utl;

import java.util.*;
import java.rmi.*;
import java.sql.*;
import javax.sql.*;
import javax.naming.*;
import javax.ejb.*;

import com.utl.CreateSequenceException;

public abstract class AbstractSequenceBean  extends com.utl.AbstractEntityCommonBean
{

	private String sequenceStatement = "{ ?= call "+StaticContext.PACKAGE_COMMON+".GETNEXTFROMSEQUENCE(?,?) }";


	/**
	 * Protected methods
	 */

	protected String getSequenceValue(String sequenceName) throws CreateSequenceException,RemoteException
	{
		int iReturnValue=0;
		String sSequenceValue=null;
		CallableStatement cs=null;
		try
		{
			conn = getConnection(StaticContext.DSNAME);
			cs = conn.prepareCall(sequenceStatement);  // FOR FUNCTION

			// Register the OUT parameter
			cs.registerOutParameter(1,Types.NUMERIC);
			// Set the IN parameter
			cs.setString(2,sequenceName);
			// Register the OUT parameter
			cs.registerOutParameter(3,Types.VARCHAR);

			cs.execute(); // Execute the callable statement

			iReturnValue = cs.getInt(1); // Gets the value of OUT parameter
			sSequenceValue = cs.getString(3); // Gets the value of OUT parameter        

		} catch(Exception ex)
		{ // Trap SQL Errors
			throw new CreateSequenceException("Non e' stato possibile creare la Sequence: "+sequenceName);
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
		return sSequenceValue; // return the status
	}

}

