package com.ejbBMP;
import javax.ejb.EJBObject;
import java.rmi.*;

public interface I5_2MOV_NON_RICEJB extends EJBObject 
{
  public void setCode_Ogg_Fatrz(String code_ogg_fatrz) throws RemoteException;
  public void setCode_utente(String code_utente) throws RemoteException;
  public void setCode_invent(String code_invent) throws RemoteException;
  public void setDesc_mov(String desc_mov) throws RemoteException;
  public void setImpt_Mov_Non_Ric(java.math.BigDecimal newImpt_Mov_Non_Ric) throws RemoteException;
  public void setData_fatrb(java.util.Date data_fatrb) throws RemoteException;
  public void setData_mm(String data_mm) throws RemoteException;
  public void setData_aa(String data_aa) throws RemoteException;
  public void setTipo_Flag_Nota_Cred_Fattura(String tipo_flag_ncf) throws RemoteException;
  public void setTipo_Flag_Dare_Avere(String tipo_flag_da) throws RemoteException;
  public void setCode_Clas_Ogg_Fatrz(String newCode_Clas_Ogg_Fatrz) throws RemoteException;  
  public void setDATA_INIZIO_VALID_OF(java.util.Date newDATA_INIZIO_VALID_OF) throws RemoteException;  
  public void setCode_Istanza_Ps(String newCode_Istanza_Ps) throws RemoteException;
  public String getId_movim() throws RemoteException;
  public String getDesc_acc() throws RemoteException;  
  public String getCode_gest() throws RemoteException;
  public String getNome_Rag_Soc_Gest() throws RemoteException;
  public String getCode_account() throws RemoteException;
  public String getDesc_mov() throws RemoteException;
  public java.util.Date getData_fatrb() throws RemoteException;
  public java.util.Date getData_eff_fatrz() throws RemoteException;
  public java.util.Date getData_transaz() throws RemoteException;
  public String getCode_Ogg_Fatrz() throws RemoteException;
  public String getDesc_Ogg_Fatrz() throws RemoteException;
  public String getCode_Clas_Ogg_Fatrz()  throws RemoteException;
  public String getDesc_Clas_Ogg_Fatrz()   throws RemoteException;
  public java.math.BigDecimal getImpt_Mov_Non_Ric() throws RemoteException;
  public String getCode_invent() throws RemoteException;
  public String getData_mm() throws RemoteException;
  public String getData_aa() throws RemoteException;
  public String getTipo_Flag_Nota_Cred_Fattura() throws RemoteException;
  public String getTipo_Flag_Dare_Avere() throws RemoteException;
  public java.util.Date getDATA_INIZIO_VALID_OF() throws RemoteException;
  public void setEseguiStore(boolean  newEseguiStore) throws RemoteException;
  public String getCode_Istanza_Ps() throws RemoteException;    
}
