package com.ejbSTL;
import java.io.Serializable;

public class ListaScartiPopolamento_ROW implements Serializable 
{

  private String CODE_ITRF_FAT;
  private String CODE_RICH;
  private String DESC_ID_RISORSA;
  private String CODE_TIPO_CONTR;
  private String CODE_CONTR;
  private String CODE_SCARTO;
  private String DATA_ACQ_CHIUS;
  private String DESC_SCARTO;

  public ListaScartiPopolamento_ROW()
  {

	CODE_ITRF_FAT = null;
	CODE_RICH = null;
	DESC_ID_RISORSA = null;
	CODE_TIPO_CONTR = null;
	CODE_CONTR = null;
	CODE_SCARTO = null;
	DATA_ACQ_CHIUS = null;
	DESC_SCARTO = null;  
  }

  public String getCODE_ITRF_FAT()
  {
    return CODE_ITRF_FAT;
  }

  public void setCODE_ITRF_FAT(String new_CODE_ITRF_FAT)
  {
    CODE_ITRF_FAT = new_CODE_ITRF_FAT;
  }
  
  public String getCODE_RICH()
  {
    return CODE_RICH;
  }

  public void setCODE_RICH(String new_CODE_RICH)
  {
    CODE_RICH = new_CODE_RICH;
  }
  
  public String getDESC_ID_RISORSA()
  {
    return DESC_ID_RISORSA;
  }

  public void setDESC_ID_RISORSA(String new_DESC_ID_RISORSA)
  {
    DESC_ID_RISORSA = new_DESC_ID_RISORSA;
  }  
  
  public String getCODE_TIPO_CONTR()
  {
    return CODE_TIPO_CONTR;
  }

  public void setCODE_TIPO_CONTR(String new_CODE_TIPO_CONTR)
  {
    CODE_TIPO_CONTR = new_CODE_TIPO_CONTR;
  }
  
  public String getCODE_CONTR()
  {
    return CODE_CONTR;
  }

  public void setCODE_CONTR(String new_CODE_CONTR)
  {
    CODE_CONTR = new_CODE_CONTR;
  }

  public String getCODE_SCARTO()
  {
    return CODE_SCARTO;
  }

  public void setCODE_SCARTO(String new_CODE_SCARTO)
  {
    CODE_SCARTO = new_CODE_SCARTO;
  }

  public String getDATA_ACQ_CHIUS()
  {
    return DATA_ACQ_CHIUS;
  }

  public void setDATA_ACQ_CHIUS(String new_DATA_ACQ_CHIUS)
  {
    DATA_ACQ_CHIUS = new_DATA_ACQ_CHIUS;
  }

  public String getDESC_SCARTO()
  {
    return DESC_SCARTO;
  }

  public void setDESC_SCARTO(String new_DESC_SCARTO)
  {
    DESC_SCARTO = new_DESC_SCARTO;
  }

}