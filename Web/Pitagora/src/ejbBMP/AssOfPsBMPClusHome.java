package com.ejbBMP;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.FinderException;
import java.util.*;
import com.utl.*;
import java.util.Collection;

public interface AssOfPsBMPClusHome extends EJBHome 
{
  AssOfPsBMPClus create() throws RemoteException, CreateException;
  AssOfPsBMPClus create(String dataIniOfPs, String codeOf,
                      String codePs, String dataIniOf, String codeMod, String codeFreq,
                      String codeUte, int quntShift, String flgAP, String dataFineOfPs,
                      String tipoCluster, String codeCluster, String codeTipoContr) 
                        throws RemoteException, CustomEJBException, CreateException;
  AssOfPsBMPClus findByPrimaryKey(AssOfPsBMPClusPK primaryKey) throws RemoteException, FinderException;
  Collection findAll(String CodTipoContr, String cod_cluster, String tipo_cluster, boolean solo_attivi ) throws FinderException, RemoteException;
  
}