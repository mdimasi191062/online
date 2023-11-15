package com.utl;

public class DB_ModalNoleggio  extends AbstractDataBean 
{
  private String CODE_MODAL_APPLICAB_NOLEG;
  private String DESC_MODAL_APPLICAB_NOLEG;
  
  public DB_ModalNoleggio()
  {
    CODE_MODAL_APPLICAB_NOLEG = "";
    DESC_MODAL_APPLICAB_NOLEG = "";
  }

  public String getDESC_MODAL_APPLICAB_NOLEG() {return DESC_MODAL_APPLICAB_NOLEG;}
  public String getCODE_MODAL_APPLICAB_NOLEG() {return CODE_MODAL_APPLICAB_NOLEG;}

  public void setDESC_MODAL_APPLICAB_NOLEG( String value ) { DESC_MODAL_APPLICAB_NOLEG = value;}
  public void setCODE_MODAL_APPLICAB_NOLEG( String value ) { CODE_MODAL_APPLICAB_NOLEG = value;}
}