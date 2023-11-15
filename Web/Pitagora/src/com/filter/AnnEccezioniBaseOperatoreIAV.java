package com.filter;

import com.ejbSTL.ResultRefuseIav;
import com.ejbSTL.ResultEccezioniIav;

import com.ejbSTL.TypeFlussoIav;
import com.ejbSTL.impl.AnnEccezioniBaseOperatoreIAVBean;

import com.utl.CustomException;

import java.rmi.RemoteException;

import java.sql.SQLException;

import java.util.Vector;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.text.ParseException;

public class AnnEccezioniBaseOperatoreIAV {

    public Vector<TypeFlussoIav> listAnnEccOpeIav = new Vector<TypeFlussoIav>();
    private AnnEccezioniBaseOperatoreIAVBean AnnEccOpe;

    public AnnEccezioniBaseOperatoreIAV() {
        AnnEccOpe = new AnnEccezioniBaseOperatoreIAVBean();
    }
    
    public Vector<TypeFlussoIav> getListaFlussi() throws CustomException,
                                                         RemoteException,
                                                         SQLException {
        listAnnEccOpeIav = AnnEccOpe.getListaFlussi();
        
        return listAnnEccOpeIav;
    }
    
    public Vector<ResultRefuseIav> getResultFromFilter(String code, String startDate, String endDate, String area) throws SQLException,
                                                                              RemoteException {
        return AnnEccOpe.getTableFromFluxCode(code, startDate, endDate, area);
    }
    
    public String getNameFluxFromCode(String code) throws SQLException,
                                                          RemoteException {
        return AnnEccOpe.getNameFluxFromCode(code);
    }
    
    public Vector<TypeFlussoIav> getListaServizi() throws CustomException,
                                                         RemoteException,
                                                         SQLException {
        listAnnEccOpeIav = AnnEccOpe.getListaServizi();
        
        return listAnnEccOpeIav;
    }
    
    public Vector<TypeFlussoIav> getListaOperatori() throws CustomException,
                                                         RemoteException,
                                                         SQLException {
        listAnnEccOpeIav = AnnEccOpe.getListaOperatori();
        
        return listAnnEccOpeIav;
    }
    
    public Vector<ResultEccezioniIav> getResultFromFilterOpe(String operatoreIav, String serviziIav, String ambitoIav, Boolean regoleCess) throws SQLException,
                                                                              RemoteException {
        return AnnEccOpe.getTableFromFluxCodeOpe(operatoreIav, serviziIav, ambitoIav,regoleCess);
    }
    
    public Boolean alterTableOpe(String[] SelOf, String input) throws SQLException,
                                                                              RemoteException {
        return AnnEccOpe.alterExceptionOpe(SelOf, input);
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
