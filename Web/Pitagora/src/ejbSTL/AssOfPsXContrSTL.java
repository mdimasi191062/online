package com.ejbSTL;
import javax.ejb.EJBObject;
import com.utl.*;
import java.rmi.*;

public interface AssOfPsXContrSTL extends EJBObject 
{
public CanoneElem check_canone_exist(String tipoContr, String codeContr, String classeOf, String codePs) 
       throws RemoteException, CustomException;
public int check_esiste(String tipoContr, String codeContr, String codeOf, String codePs)
       throws RemoteException, CustomException;
public int check_aperte(String tipoContr, String codeContr, String codeOf, String codePs)
       throws RemoteException, CustomException;
public String getMaxDataFine(String tipoContr, String codeContr, String codeOf, String codePs)
       throws RemoteException, CustomException;
public String getMinDataIni(String tipoContr, String codeContr, String codeOf, String codePs)
       throws RemoteException, CustomException;       
public String getMinDataIniCorr(String tipoContr, String codeContr,String dataCorr, String codeOf, String codePs)
       throws RemoteException, CustomException;
public int esiste_tariffa_x_contr(String codeContr,String codePs, String codeOf, String dataIniOfPs)
       throws RemoteException, CustomException;       

    public int check_esiste_clus(String tipoContr, String codeContr, String codeOf, String codePs, String codeClus, String tipoClus, String codeTipoContr)
           throws RemoteException, CustomException;

    public int check_aperte_clus(String tipoContr, String codeContr, String codeOf, String codePs, String codeClus, String tipoClus, String codeTipoContr)
           throws RemoteException, CustomException;

    public String getMaxDataFineCluster(String tipoContr, String codeContr, String codeOf, String codePs, String codeClus, String tipoClus, String codeTipoContr)
           throws RemoteException, CustomException;

    public CanoneElem check_canone_exist_cluster(String tipoContr, String codeContr, String classeOf, String codePs, String codeClus, String tipoClus)
            throws RemoteException, CustomException;

    public String getMinDataIniCorrClus(String tipoContr, String codeContr,String dataCorr, String codeOf, String codePs, String codeClus, String tipoClus)
            throws RemoteException, CustomException;
    
    public String getMinDataIniClus(String tipoContr, String codeContr, String codeOf, String codePs,String cod_cluster,String tipo_cluster)
           throws RemoteException, CustomException;       

}