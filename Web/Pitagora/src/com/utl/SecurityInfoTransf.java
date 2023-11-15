package com.utl;

import java.io.Serializable;

public class SecurityInfoTransf implements Serializable
{
  private String code_op_elem;
  private String desc_label;
  private String code_op_exec;

  public SecurityInfoTransf(String code_op_elem,String desc_label,String code_op_exec)
  {
    this.code_op_elem=code_op_elem;
    this.desc_label=desc_label;
    this.code_op_exec=code_op_exec;
  }
   public SecurityInfoTransf()
  {
    code_op_elem=null;
    desc_label=null;
    code_op_exec=null;
  }

  public String getCode_op_elem()
  {
    return code_op_elem;
  }

  public void setCode_op_elem(String newCode_op_elem)
  {
    code_op_elem = newCode_op_elem;
  }

  public String getDesc_label()
  {
    return desc_label;
  }

  public void setDesc_label(String newDesc_label)
  {
    desc_label = newDesc_label;
  }

  public String getCode_op_exec()
  {
    return code_op_exec;
  }

  public void setCode_op_exec(String newCode_op_exec)
  {
    code_op_exec = newCode_op_exec;
  }
}