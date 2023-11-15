package com.ejbBMP;
import javax.ejb.EJBObject;
import java.rmi.*;

public interface I5_2Elab_Batch extends EJBObject 
{
  public String getData_ora_inizio_elab_batch()  throws RemoteException;
  public void setData_ora_inizio_elab_batch(String newData_ora_inizio_elab_batch)  throws RemoteException;
  public String getData_ora_fine_elab_batch()  throws RemoteException;
  public void setData_ora_fine_elab_batch(String newData_ora_fine_elab_batch)  throws RemoteException;
  public String getValo_nr_ps_elab()  throws RemoteException;
  public void setValo_nr_ps_elab(String newValo_nr_ps_elab)  throws RemoteException;
  public String getDesc_Stato_Batch()  throws RemoteException;
  public void setDesc_Stato_Batch(String newDesc_Stato_Batch)  throws RemoteException;  
}
