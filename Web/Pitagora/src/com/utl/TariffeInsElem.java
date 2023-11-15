package com.utl;

public class TariffeInsElem implements java.io.Serializable
{
  private String codOf;
  private String codPs;
  private String codTipoCaus;
  private String codTipoOpz; //030224

//030224-inizio
    public String getCodTipoOpz()
    { return codTipoOpz; }
    public void setCodTipoOpz(String stringa)
    {  codTipoOpz=stringa; }
//030224-fine

    public String getCodOf()
    { return codOf; }
    public void setCodOf(String stringa)
    {  codOf=stringa; }

    public String getCodPs()
    {  return codPs; }
    public void setCodPs(String stringa)
    {  codPs=stringa; }

    public String getCodTipoCaus()
    {  return codTipoCaus; }
    public void setCodTipoCaus(String stringa)
    {  codTipoCaus=stringa; }
}