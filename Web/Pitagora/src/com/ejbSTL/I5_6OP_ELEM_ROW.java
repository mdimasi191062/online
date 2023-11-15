package com.ejbSTL;
import java.io.Serializable;

public class I5_6OP_ELEM_ROW implements Serializable 
{
  private String CODE_OP_ELEM;
  private String DESC_OP_ELEM;  

  public I5_6OP_ELEM_ROW()
  {
    CODE_OP_ELEM = null; 
    DESC_OP_ELEM = null;
  }

  public String getCODE_OP_ELEM()
  {
    return CODE_OP_ELEM;
  }

  public void setCODE_OP_ELEM(String new_CODE_OP_ELEM)
  {
    CODE_OP_ELEM = new_CODE_OP_ELEM;
  }
  
  public String getDESC_OP_ELEM()
  {
    return DESC_OP_ELEM;
  }

  public void setDESC_OP_ELEM(String new_DESC_OP_ELEM)
  {
    DESC_OP_ELEM = new_DESC_OP_ELEM;
  }

}