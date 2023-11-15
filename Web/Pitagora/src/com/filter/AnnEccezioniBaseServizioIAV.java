package com.filter;

import com.ejbSTL.ResultEccezioniIav;
import com.ejbSTL.ResultRefuseIav;
import com.ejbSTL.TypeFlussoIav;
import com.ejbSTL.impl.AnnEccezioniBaseServizioIAVBean;

import com.utl.CustomException;

import java.rmi.RemoteException;

import java.sql.SQLException;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import java.util.Vector;

public class AnnEccezioniBaseServizioIAV {

    public Vector<TypeFlussoIav> listannEccSerIav = new Vector<TypeFlussoIav>();
    private AnnEccezioniBaseServizioIAVBean annEccSer;

    public AnnEccezioniBaseServizioIAV() {
        annEccSer = new AnnEccezioniBaseServizioIAVBean();
    }
    
    public Vector<TypeFlussoIav> getListaFlussi() throws CustomException,
                                                         RemoteException,
                                                         SQLException {
        listannEccSerIav = annEccSer.getListaFlussi();
        
        return listannEccSerIav;
    }
    
    public Vector<ResultRefuseIav> getResultFromFilter(String code, String startDate, String endDate, String area) throws SQLException,
                                                                              RemoteException {
        return annEccSer.getTableFromFluxCode(code, startDate, endDate, area);
    }
    
    public String getNameFluxFromCode(String code) throws SQLException,
                                                          RemoteException {
        return annEccSer.getNameFluxFromCode(code);
    }
    
    public Vector<ResultEccezioniIav> getResultFromFilterSer(String ambitoIav, String serviziIav, String classTecIav, String fontiIav, String tipologiaIav, Boolean regoleCess, String nomeOlo) throws SQLException,
                                                                              RemoteException {
        return annEccSer.getTableFromFluxCodeSer(ambitoIav, serviziIav, classTecIav, fontiIav, tipologiaIav,regoleCess,nomeOlo);
    }
    
    public Vector<TypeFlussoIav> getListaClassTec() throws CustomException,
                                                      RemoteException,
                                                      SQLException {
            
          listannEccSerIav = annEccSer.getListaClassTec();
          
          return listannEccSerIav;
      }  
      
    public Vector<TypeFlussoIav> getListaOperatori() throws CustomException,
                                                      RemoteException,
                                                      SQLException {
            
          listannEccSerIav = annEccSer.getListaOperatori();
          
          return listannEccSerIav;
      } 
      
    public Vector<TypeFlussoIav> getListaFonti() throws CustomException,
                                                      RemoteException,
                                                      SQLException {
            
          listannEccSerIav = annEccSer.getListaFonti();
          
          return listannEccSerIav;
      }  
      
    public Vector<TypeFlussoIav> getListaServizi() throws CustomException,
                                                         RemoteException,
                                                         SQLException {
        listannEccSerIav = annEccSer.getListaServizi();
        
        return listannEccSerIav;
    }
    
    public Boolean alterTableSer(String[] SelOf, String input) throws SQLException,
                                                                              RemoteException {
        return annEccSer.alterExceptionSer(SelOf, input);
    }
    
    public boolean isValid(String dateStr) {
            DateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            sdf.setLenient(false);
            try {
                sdf.parse(dateStr);
            } catch (ParseException e) {
                return false;
            }
            return true;
        }
    
}
