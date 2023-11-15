package com.ejbBMP;
import com.utl.AbstractPK;

public class I5_2Elab_BatchPK extends AbstractPK
{
  private String code_elab;
  private String flag_sys;
  
  public I5_2Elab_BatchPK()
  {
    code_elab=null;
    flag_sys=null;
  }

  public I5_2Elab_BatchPK(String newcode_elab,String newFlag_sys)
  {
    code_elab=newcode_elab;
    flag_sys=newFlag_sys;
  }

	public String getcode_elab()
	{
		return code_elab;
	}

	public void setcode_elab(String newcode_elab)
	{
		code_elab = newcode_elab;
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

