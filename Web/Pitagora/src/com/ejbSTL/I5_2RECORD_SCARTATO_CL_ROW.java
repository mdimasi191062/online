package com.ejbSTL;
import java.io.Serializable;

public class I5_2RECORD_SCARTATO_CL_ROW implements Serializable 
{

  private String Code_Scarto;
  private String Desc_Motivo_Scarto;
  private String Code_Istanza_Ps;
  private String Desc_Valo_Attuale;
  private String Desc_Valo_St;  
  private String Tipo_Scarto;  
   

  public I5_2RECORD_SCARTATO_CL_ROW()
  {
    Code_Scarto=null;
    Desc_Motivo_Scarto=null;
    Code_Istanza_Ps=null;
    Desc_Valo_Attuale=null;
    Desc_Valo_St=null;
    Tipo_Scarto=null;
  }

  public String getCode_Scarto()
  {
    return Code_Scarto;
  }

  public void setCode_Scarto(String newCode_Scarto)
  {
    Code_Scarto = newCode_Scarto;
  }

  public String getDesc_Motivo_Scarto()
  {
    return Desc_Motivo_Scarto;
  }

  public void setDesc_Motivo_Scarto(String newDesc_Motivo_Scarto)
  {
    Desc_Motivo_Scarto = newDesc_Motivo_Scarto;
  }
  
  public String getCode_Istanza_Ps()
  {
    return Code_Istanza_Ps;
  }

  public void setCode_Istanza_Ps(String newCode_Istanza_Ps)
  {
    Code_Istanza_Ps = newCode_Istanza_Ps;
  }

  public String getDesc_Valo_Attuale()
  {
    return Desc_Valo_Attuale;
  }

  public void setDesc_Valo_Attuale(String newDesc_Valo_Attuale)
  {
    Desc_Valo_Attuale = newDesc_Valo_Attuale;
  }

  public String getDesc_Valo_St()
  {
    return Desc_Valo_St;
  }

  public void setDesc_Valo_St(String newDesc_Valo_St)
  {
    Desc_Valo_St = newDesc_Valo_St;
  }

  public String getTipo_Scarto()
  {
    return Tipo_Scarto;
  }

  public void setTipo_Scarto(String newTipo_Scarto)
  {
    Tipo_Scarto = newTipo_Scarto;
  }

}
