package com.ejbBMP;
import com.utl.AbstractPK;

public class I5_1ACCOUNTPK extends AbstractPK
{
  private String code_account;
  private String flag_sys;
  
  public I5_1ACCOUNTPK()
  {
    code_account=null;
    flag_sys=null;
  }

  public I5_1ACCOUNTPK(String newCode_account,String newFlag_sys)
  {
    code_account=newCode_account;
    flag_sys=newFlag_sys;
  }

	public String getCode_account()
	{
		return code_account;
	}

	public void setCode_account(String newCode_account)
	{
		code_account = newCode_account;
	}
	public String getFlag_sys()
	{
		return flag_sys;
	}

	public void setFlag_sys(String newFlag_sys)
	{
		flag_sys = newFlag_sys;
	}
}

