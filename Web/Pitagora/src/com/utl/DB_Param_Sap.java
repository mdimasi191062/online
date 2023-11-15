package com.utl;
import com.utl.AbstractDataBean;

public class DB_Param_Sap extends AbstractDataBean {
    private String NOME_CONST;
    private String VALORE_CONST;

    public String getNOME_CONST()
    { return NOME_CONST; }
    public void setNOME_CONST(String stringa)
    {  NOME_CONST=stringa; }

    public String getVALORE_CONST()
    {  return VALORE_CONST; }
    public void setVALORE_CONST(String stringa)
    {  VALORE_CONST=stringa; }
}


