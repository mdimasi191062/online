package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ent_TipiContratto extends EJBObject 
{
  Vector getTipiContratto(String pstr_NoCodeTipoContrCL,
                          String pstr_NoCodeTipoContrSP) 
  throws CustomException, RemoteException;

  Vector getTipiContrattoFilter(String strLocFilter, String strTipo)
          throws CustomException, RemoteException;

  Vector getTipiContrattoPS() throws CustomException, RemoteException;
}