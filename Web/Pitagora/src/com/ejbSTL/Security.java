package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import javax.ejb.FinderException;
import com.utl.CustomException;
import java.util.Vector;
import com.utl.*;


public interface Security extends EJBObject 
{

  public com.utl.I5_6anag_utenteROW findByPK(String sCodeUser) throws CustomException,RemoteException,FinderException;
  public Vector findAllOpEl(String sProfile,String sCodeFunz) throws CustomException,RemoteException;
  public String chk_param() throws CustomException,RemoteException;
  public int disabilita_utente(String sCodeUser) throws CustomException,RemoteException;
  public int aggiorna_login(String sCodeUser, String sMail, String sMobile) throws CustomException,RemoteException;
  public com.utl.ClassDatiTop findDataTop() throws CustomException,RemoteException,FinderException;
  public String findIpLdap() throws CustomException,RemoteException;
  public String findRootLdap() throws CustomException,RemoteException;
  public int aggiorna_tnt_login(int num_tnt_login, String sCodeUser) throws CustomException,RemoteException;

}