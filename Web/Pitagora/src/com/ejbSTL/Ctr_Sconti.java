package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;

public interface Ctr_Sconti extends EJBObject 
{
    String insSconto(String pstr_VALO_PERC,
                           String pstr_VALO_LIM_MIN,
                           String pstr_VALO_LIM_MAX)
    throws CustomException, RemoteException;
}