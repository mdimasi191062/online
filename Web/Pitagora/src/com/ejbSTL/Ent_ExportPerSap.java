package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ent_ExportPerSap extends EJBObject 
{
// getDateCicloFattSap
  Vector getDateCicloFattSap ()
        throws CustomException, RemoteException;
// getDataFinePeriodoSap
  Vector getDataFinePeriodoSap ()
        throws CustomException, RemoteException;
// getClientiValidiSap
   Vector getClientiValidiSap()
        throws CustomException, RemoteException;

// getElabBatchVerificaSpAccorp
  Vector getElabBatchVerificaSpAccorp (String pstr_CodeFunz,String pstr_CodeFunzPkg)
     throws CustomException, RemoteException;

// getElabBatchVerificaImport
  Vector getElabBatchVerificaImport (String pstr_CodeFunz,String pstr_CodeFunzPkg)
     throws CustomException, RemoteException;

// countTestCsvSap
  Integer countTestCsvSap()
     throws CustomException, RemoteException;
        
}

