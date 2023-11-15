package com.ejbBMP;
import javax.ejb.EJBHome;
import java.rmi.RemoteException;
import javax.ejb.CreateException;
import javax.ejb.FinderException;

import java.util.*;
import com.utl.*;

public interface AssOfPsXContrBMPHome extends EJBHome 
{
  AssOfPsXContrBMP create(String codeContr, String dataIniOfPs, String codeOf,
                          String codePs, String dataIniOf, String codeMod, String codeFreq,
                          String codeUte, int quntShift, String flgAP, String dataFineOfPs) 
                          throws RemoteException, CustomEJBException, CreateException;
  AssOfPsXContrBMP findByPrimaryKey(AssOfPsXContrBMPPK primaryKey) throws RemoteException, CustomEJBException, FinderException;
  Collection findAll(String CodTipoContr,String CodContr, boolean attivi) throws RemoteException,CustomException,FinderException;
}