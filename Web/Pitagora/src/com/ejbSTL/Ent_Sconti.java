package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import java.util.Vector;
import com.utl.*;
public interface Ent_Sconti extends EJBObject 
{
   Vector getSconti (String pstrVALO_PERC)
   throws CustomException, RemoteException;


  Vector getSconti
      (int pint_funzionalita
      ,int pint_operazioneRichiesta)
      throws CustomException, RemoteException;


   Integer updSconto(String pstr_VALO_PERC,
                           String pstr_VALO_LIM_MIN,
                           String pstr_VALO_LIM_MAX)
   throws CustomException, RemoteException;

   Integer insSconto(String pstr_VALO_PERC,
                           String pstr_VALO_LIM_MIN,
                           String pstr_VALO_LIM_MAX)
   throws CustomException, RemoteException;

   Integer delSconto(String pstr_VALO_PERC)
   throws CustomException, RemoteException;

   Integer countScontoTnValMinMax(String pstr_VALO_PERC,
                           String pstr_VALO_LIM_MIN_MAX)
   throws CustomException, RemoteException;

   Integer countScontoTnGiaPresente(String pstr_VALO_PERC)
   throws CustomException, RemoteException;
   
}