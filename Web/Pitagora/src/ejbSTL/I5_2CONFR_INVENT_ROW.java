package com.ejbSTL;
import java.io.Serializable;

public class I5_2CONFR_INVENT_ROW implements Serializable 
{

  private String Code_confr_invent;
  private String Code_Account;
  private String Nome_rag_soc_gest;
  private String Desc_account;
  private Integer Qnta_ps_invent;
  private Integer Num_ps_reg;
  private Integer Qnta_ps_atvti_invent;
  private Integer Qnta_ps_dis_st;
  private Integer Qnta_scarti;  

  public I5_2CONFR_INVENT_ROW()
  {
    Code_confr_invent=null;
    Code_Account=null;
    Nome_rag_soc_gest=null;
    Desc_account=null;
    Qnta_ps_invent=null;
    Num_ps_reg=null;
    Qnta_ps_atvti_invent=null;
    Qnta_ps_dis_st=null;
    Qnta_scarti=null;  

  }

  public String getCode_confr_invent()
  {
    return Code_confr_invent;
  }

  public void setCode_confr_invent(String newCode_confr_invent)
  {
    Code_confr_invent = newCode_confr_invent;
  }
  
  public String getCode_Account()
  {
    return Code_Account;
  }

  public void setCode_Account(String newCode_Account)
  {
    Code_Account = newCode_Account;
  }
  public String getNome_rag_soc_gest()
  {
    return Nome_rag_soc_gest;
  }

  public void setNome_rag_soc_gest(String newNome_rag_soc_gest)
  {
    Nome_rag_soc_gest = newNome_rag_soc_gest;
  }
  
  public String getDesc_account()
  {
    return Desc_account;
  }

  public void setDesc_account(String newDesc_account)
  {
    Desc_account = newDesc_account;
  }

  public Integer getQnta_ps_invent()
  {
    return Qnta_ps_invent;
  }

  public void setQnta_ps_invent(Integer newQnta_ps_invent)
  {
    Qnta_ps_invent = newQnta_ps_invent;
  }
  
  public Integer getNum_ps_reg()
  {
    return Num_ps_reg;
  }

  public void setNum_ps_reg(Integer newNum_ps_reg)
  {
    Num_ps_reg = newNum_ps_reg;
  }  

  public Integer getQnta_ps_atvti_invent()
  {
    return Qnta_ps_atvti_invent;
  }

  public void setQnta_ps_atvti_invent(Integer newQnta_ps_atvti_invent)
  {
    Qnta_ps_atvti_invent = newQnta_ps_atvti_invent;
  }  

  public Integer getQnta_ps_dis_st()
  {
    return Qnta_ps_dis_st;
  }

  public void setQnta_ps_dis_st(Integer newQnta_ps_dis_st)
  {
    Qnta_ps_dis_st = newQnta_ps_dis_st;
  }  
  
  public Integer getQnta_scarti()
  {
    return Qnta_scarti;
  }

  public void setQnta_scarti(Integer newQnta_scarti)
  {
    Qnta_scarti = newQnta_scarti;
  } 
}
