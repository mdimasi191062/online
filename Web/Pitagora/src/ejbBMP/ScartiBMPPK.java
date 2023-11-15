package com.ejbBMP;

import com.utl.*;

public class ScartiBMPPK extends AbstractPK  
{
  private String codice; 
  private String tipo;
  private String motivo;
  private String oggetto;

  public ScartiBMPPK()
  {
  
  }

  public ScartiBMPPK(String codice, String motivo,String tipo,String oggetto)
  {
   this.codice=codice;
   this.motivo=motivo;
   this.tipo=tipo;
   this.oggetto=oggetto;
   
  }
   public void setCodice(String code)
  {
    
    this.codice=code;
   
  }
  public String getCodice()
  {
 
    return this.codice;
  }
  public void setOggetto(String oggetto)
  {
    this.oggetto=oggetto;
  }
  public String getOggetto()
  {
    return this.oggetto;
  }
    public void setMotivo(String motivo)
  {
    this.motivo=motivo;
  }
  public String getMotivo()
  {
    return this.motivo;
  }
  public void setTipo(String tipo)
  {
    this.tipo=tipo;
  }
  public String getTipo()
  {
    return this.tipo;
  }
}