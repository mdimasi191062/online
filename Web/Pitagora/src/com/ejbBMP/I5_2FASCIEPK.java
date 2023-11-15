package com.ejbBMP;

import com.utl.AbstractPK;
import java.sql.Date;

public class I5_2FASCIEPK extends AbstractPK 
{

	private String code_fascia;
	private String code_pr_fascia;

	public I5_2FASCIEPK()
	{
		this.code_fascia=null;
		this.code_pr_fascia=null;
	}

	public I5_2FASCIEPK(String code_fascia, String code_pr_fascia)
	{
		this.code_fascia=code_fascia;
		this.code_pr_fascia=code_pr_fascia;
	}

	public String getCode_fascia()
	{
		return code_fascia;
	}

	public void setCode_fascia(String newCode_fascia)
	{
		code_fascia = newCode_fascia;
	}

	public String getCode_pr_fascia()
	{
		return code_pr_fascia;
	}

	public void setCode_pr_fascia(String newCode_pr_fascia)
	{
		code_pr_fascia = newCode_pr_fascia;
	}
}