package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ctr_Tariffe extends EJBObject 
{
  String insTariffa ( Vector pvct_Tariffe )
                      throws CustomException, RemoteException;

  String updTariffa ( Vector pvct_Tariffe )
                      throws CustomException, RemoteException;

    String delTariffa (Vector pvct_Tariffe)
        throws CustomException, RemoteException;
                      
  String insTariffaXTipoContr ( String pstr_CodeAccountDaEliminare,
				Vector pvct_Tariffe )
                              throws CustomException, RemoteException;
  String updTariffaXTipoContr (Vector pvct_Tariffe)
                              throws CustomException, RemoteException;
  String delTariffaXTipoContr ( DB_Tariffe pDB_Tariffa )
                              throws CustomException, RemoteException;
 }