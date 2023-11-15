package com.ejbSTL;
import javax.ejb.EJBObject;
import com.utl.I5_2ANAG_CICLI_FATRZ_ROW;
import com.utl.CustomException;
import java.rmi.*;
import java.util.Vector;

public interface I5_2ANAG_CICLI_FATRZEJB extends EJBObject 
{
  public void creaCiclo(String desc_ciclo, int giorni_ciclo) throws RemoteException,CustomException;
  public Vector findAll(java.util.Date data_ricerca_da, java.util.Date data_ricerca_a) throws RemoteException,CustomException;
  public I5_2ANAG_CICLI_FATRZ_ROW loadCiclo(String primaryKey) throws RemoteException,CustomException;
  public void removeCiclo(String primaryKey) throws RemoteException,CustomException;
  public void updateCiclo(I5_2ANAG_CICLI_FATRZ_ROW riga)  throws RemoteException,CustomException;
  public int controlloAccount(String primaryKey) throws RemoteException,CustomException;
}