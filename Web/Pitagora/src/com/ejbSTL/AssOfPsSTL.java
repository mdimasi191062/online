package com.ejbSTL;
import javax.ejb.EJBObject;
import com.utl.*;
import java.rmi.*;

public interface AssOfPsSTL extends EJBObject 
{
//nicola
public CanoneElem check_canone_exist(String tipoContr,String classeOf, String codePs) 
       throws RemoteException, CustomException;
public int check_esiste(String tipoContr, String codeOf, String codePs)
       throws RemoteException, CustomException;
public int check_aperte(String tipoContr, String codeOf, String codePs)
       throws RemoteException, CustomException;
public String getMaxDataFine(String tipoContr, String codeOf, String codePs)
       throws RemoteException, CustomException;
public String getMinDataIni(String tipoContr,String codeOf, String codePs)
       throws RemoteException, CustomException;       
//nicola

public String getMinDataIniCorr(String tipoContr, String dataCorr, String codeOf, String codePs)
       throws RemoteException, CustomException;
public int esiste_tariffa_x_contr(String codeContr,String codePs, String codeOf, String dataIniOfPs)
       throws RemoteException, CustomException;       

    public int check_esiste_clus(String tipoContr, String codeOf, String codePs, String codeClus, String tipoCLus)
           throws RemoteException, CustomException;

    public int check_aperte_clus(String tipoContr, String codeOf, String codePs, String codeClus, String tipoClus)
           throws RemoteException, CustomException;

    public String getMinDataIniClus(String tipoContr,String codeOf, String codePs, String codeClus, String tipoClus)
           throws RemoteException, CustomException; 

    public String getMaxDataFineClus(String tipoContr, String codeOf, String codePs,String cod_cluster, String tipo_cluster)
           throws RemoteException, CustomException;

    public CanoneElem check_canone_exist_cluster(String tipoContr,String classeOf, String codePs,String cod_cluster, String tipo_cluster) 
           throws RemoteException, CustomException;
}