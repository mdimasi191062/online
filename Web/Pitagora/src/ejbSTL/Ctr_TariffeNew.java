package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ctr_TariffeNew extends EJBObject 
{
  public String InsUpdTariffa(Vector pvct_Tariffe, Vector pvct_Regole,Vector pvct_TariffeRif,int tipoTariffa) throws CustomException, RemoteException;
  public String DeleteTariffa(DB_TariffeNew lcls_tariffa,int tipoTariffa) throws CustomException, RemoteException;
  public boolean RunningBatch() throws CustomException, RemoteException;
}