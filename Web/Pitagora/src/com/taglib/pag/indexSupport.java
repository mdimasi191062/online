package com.taglib.pag;

import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.*;

public class indexSupport extends  pagerSupport
{
	protected boolean ifnull = false;

	public void setIfnull(boolean b)
  {
		ifnull = b;
	}

	public boolean getIfnull() 
  {
		return ifnull;
	}

	public void release() 
  {
		ifnull = false;
		super.release();
  }

}