package com.ejbSTL;
import javax.ejb.EJBObject;
import java.util.*;
import java.rmi.*;
import com.utl.*;

public interface ElencoAccountPsSTL extends EJBObject 
{
    public Vector getElencoAccountPs(String codiceElab, String flagSys) throws RemoteException, CustomException;
    //Agg mario per colocation 13/09/02 inizio
    public Vector getAccCol(String codTipoContr) throws RemoteException;
    //Agg mario 13/09/02 fine
    //Mario 3/10/02 inizio
    public ClassElencoAccountPsElem findDataIniValAcc(String accountSelez)throws RemoteException;
   // public String findDataIniValAcc(String accountSelez)throws RemoteException;
    //Mario 3/10/02 fine
    

    

}