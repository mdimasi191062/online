package com.ejbBMP;
import javax.ejb.EJBObject;
import java.rmi.*;
import com.utl.CustomException;

public interface I5_2CLAS_SCONTOEJB extends EJBObject 
{
  public int AssociazioneTariffe()  throws RemoteException,CustomException;
  public void setDesc_Cls_Sconto(String desc_clas_sconto) throws RemoteException;
  public void setMin_Spesa(java.math.BigDecimal impt_min_spesa) throws RemoteException;
  public void setMax_Spesa(java.math.BigDecimal impt_max_spesa) throws RemoteException;
  public void setIn_Valid(java.util.Date data_inizio_valid) throws RemoteException;
  public void setFi_Valid(java.util.Date data_fine_valid) throws RemoteException;


  public String getDesc_Cls_Sconto() throws RemoteException;
  public java.math.BigDecimal getMin_Spesa() throws RemoteException;
  public java.math.BigDecimal getMax_Spesa() throws RemoteException;
  public java.util.Date  getIn_Valid() throws RemoteException;
  public java.util.Date  getFi_Valid() throws RemoteException;


}