package com.ejbBMP;

import com.utl.AbstractPK;

public class I5_1Tipo_ContrPK extends AbstractPK 
{

	private String Code_Tipo_Contr;
	private String Flag_Sys;

	public I5_1Tipo_ContrPK()
	{
		Code_Tipo_Contr=null;
		Flag_Sys=null;
	}

	public I5_1Tipo_ContrPK(String newCode_Tipo_Contr, String newFlag_Sys)
	{
		Code_Tipo_Contr=newCode_Tipo_Contr;
		Flag_Sys=newFlag_Sys;
	}

	public String getCode_Tipo_Contr()
	{
		return Code_Tipo_Contr;
	}

	public void setCode_Tipo_Contr(String newCode_Tipo_Contr)
	{
		Code_Tipo_Contr = newCode_Tipo_Contr;
	}

	public String getFlag_Sys()
	{
		return Flag_Sys;
	}

	public void setFlag_Sys(String newFlag_Sys)
	{
		Flag_Sys = newFlag_Sys;
	}
}