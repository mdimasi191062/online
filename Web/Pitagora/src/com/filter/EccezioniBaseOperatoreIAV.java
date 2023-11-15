package com.filter;

import com.ejbSTL.ResultRefuseIav;
import com.ejbSTL.TypeFlussoIav;
import com.ejbSTL.impl.EccezioniBaseOperatoreIAVBean;

import com.utl.CustomException;

import java.rmi.RemoteException;

import java.sql.SQLException;

import java.util.Vector;

public class EccezioniBaseOperatoreIAV {

    public Vector<TypeFlussoIav> listServiziIav = new Vector<TypeFlussoIav>();
    public Vector<TypeFlussoIav> listOperatoriIav = new Vector<TypeFlussoIav>();
    
    public Vector<TypeFlussoIav> listEccOpeIav = new Vector<TypeFlussoIav>();
    
    private EccezioniBaseOperatoreIAVBean eccOpe;

    public EccezioniBaseOperatoreIAV() {
        eccOpe = new EccezioniBaseOperatoreIAVBean();
    }
    
    public Vector<TypeFlussoIav> getListaFlussi() throws CustomException,
                                                         RemoteException,
                                                         SQLException {
        listEccOpeIav = eccOpe.getListaFlussi();
        
        return listEccOpeIav;
    }
    
    
    public Vector<ResultRefuseIav> getResultFromFilter(String code, String startDate, String endDate, String area) throws SQLException,
                                                                              RemoteException {
        return eccOpe.getTableFromFluxCode(code, startDate, endDate, area);
    }
    
    public Boolean insertDataFromInput(String startDate, String endDate, String startDate2, String endDate2, String ambitoIav, String serviziIav, String operatoreIav, String note, String motivazioneBlocco) throws SQLException,
                                                                              RemoteException {
        return eccOpe.insertExceptionOpe(startDate, endDate, startDate2, endDate2, ambitoIav, serviziIav, operatoreIav, note, motivazioneBlocco);
    }
    
    public String getNameFluxFromCode(String code) throws SQLException,
                                                          RemoteException {
        return eccOpe.getNameFluxFromCode(code);
    }
    
    public Vector<TypeFlussoIav> getListaServizi() throws CustomException,
                                                         RemoteException,
                                                         SQLException {
        listServiziIav = eccOpe.getListaServizi();
        
        return listServiziIav;
    }
    
    public Vector<TypeFlussoIav> getListaOperatori() throws CustomException,
                                                         RemoteException,
                                                         SQLException {
        listOperatoriIav = eccOpe.getListaOperatori();
        
        return listOperatoriIav;
    }
    
    
}

