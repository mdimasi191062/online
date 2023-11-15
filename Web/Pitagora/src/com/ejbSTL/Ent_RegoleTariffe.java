package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import com.utl.*;
import java.util.Vector;

public interface Ent_RegoleTariffe extends EJBObject 
{
  public Vector getAnagraficaRegoleTariffe()throws CustomException, RemoteException;
  public Vector getRegoleTariffa(int Code_Tariffa,int tipoTariffa)throws CustomException, RemoteException;
  public void insertRegoleTariffa(int Code_Regola,int Code_Tariffa,int Code_Pr_Tariffa,String Param,int tipoTariffa)throws CustomException, RemoteException;
  public DB_RegolaTariffa getDescRegolaTariffa(int Code_Regola)throws CustomException, RemoteException;
  public Vector getStoricoRegoleTariffa(int CodeTariffa,String DataCreazione)throws CustomException, RemoteException;

 
}
