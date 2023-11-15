package com.ejbBMP;

import com.utl.AbstractPK;
import java.sql.Date;

public class I5_2CLAS_SCONTOPK extends AbstractPK 
{

	private String code_clas_sconto;
	private String code_pr_clas_sconto;

	public I5_2CLAS_SCONTOPK()
	{
		this.code_clas_sconto=null;
		this.code_pr_clas_sconto=null;
	}

	public I5_2CLAS_SCONTOPK(String code_clas_sconto, String code_pr_clas_sconto)
	{
		this.code_clas_sconto=code_clas_sconto;
		this.code_pr_clas_sconto=code_pr_clas_sconto;
	}

	public String getId_Cls_Sconto()
	{
		return code_clas_sconto;
	}

	public void setId_Cls_Sconto(String newCode_clas_sconto)
	{
		code_clas_sconto = newCode_clas_sconto;
	}

	public String getCode_Pr_Cls_Sconto()
	{
		return code_pr_clas_sconto;
	}

	public void setCode_Pr_Cls_Sconto(String newCode_pr_clas_sconto)
	{
		code_pr_clas_sconto = newCode_pr_clas_sconto;
	}
}