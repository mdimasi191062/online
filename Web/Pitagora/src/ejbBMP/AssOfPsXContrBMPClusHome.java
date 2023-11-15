package com.ejbBMP;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.FinderException;

import java.util.*;
import com.utl.*;

public interface AssOfPsXContrBMPClusHome extends EJBHome 
{
  AssOfPsXContrBMPClus create(String codeContr, String dataIniOfPs, String codeOf,
                          String codePs, String dataIniOf, String codeMod, String codeFreq,
                          String codeUte, int quntShift, String flgAP, String dataFineOfPs, String codeCluster, String tipoCluster, String codeTipoContr) 
                          throws RemoteException, CustomEJBException, CreateException;
  AssOfPsXContrBMPClus findByPrimaryKey(AssOfPsXContrBMPClusPK primaryKey) throws RemoteException, CustomEJBException, FinderException;
  Collection findAll(String CodTipoContr,String CodContr, boolean attivi) throws RemoteException,CustomException,FinderException;

    Collection findAll(String CodTipoContr,String CodContr, String codCluster, String tipoCluster, boolean attivi) throws RemoteException,CustomException,FinderException;
  
}