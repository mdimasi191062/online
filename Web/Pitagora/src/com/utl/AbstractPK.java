package com.utl;

import java.io.Serializable;

public abstract class AbstractPK implements Serializable 
{

	public boolean equals(Object other)
	{
		// Add custom equals() impl here
		return super.equals(other);
	}

	public int hashCode()
	{
		// Add custom hashCode() impl here
		return super.hashCode();
	}


}