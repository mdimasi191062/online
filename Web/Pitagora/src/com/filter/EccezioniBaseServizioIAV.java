package com.filter;

import com.ejbSTL.ResultRefuseIav;
import com.ejbSTL.TypeFlussoIav;
import com.ejbSTL.impl.EccezioniBaseServizioIAVBean;

import com.utl.CustomException;

import com.utl.StaticContext;

import java.rmi.RemoteException;

import java.sql.SQLException;

import java.util.Vector;

public class EccezioniBaseServizioIAV {

    public Vector<TypeFlussoIav> listEccSerIav = new Vector<TypeFlussoIav>();
    public Vector<TypeFlussoIav> listEccClassTecIav = new Vector<TypeFlussoIav>();
    public Vector<TypeFlussoIav> listEccFonIav = new Vector<TypeFlussoIav>();
    public Vector<TypeFlussoIav> listEccOpeIav = new Vector<TypeFlussoIav>();
    
    private EccezioniBaseServizioIAVBean eccSer;


    public EccezioniBaseServizioIAV() {
        eccSer = new EccezioniBaseServizioIAVBean();
    }
    
    public Vector<TypeFlussoIav> getListaFlussi() throws CustomException,
                                                         RemoteException,
                                                         SQLException {
        listEccSerIav = eccSer.getListaFlussi();
        
        return listEccSerIav;
    }
    
    public Vector<TypeFlussoIav> getListaClassTec() throws CustomException,
                                                      RemoteException,
                                                      SQLException {
            
          listEccClassTecIav = eccSer.getListaClassTec();
          
          return listEccClassTecIav;
      }  
      
    public Vector<TypeFlussoIav> getListaFonti() throws CustomException,
                                                      RemoteException,
                                                      SQLException {
            
          listEccFonIav = eccSer.getListaFonti();
          
          return listEccFonIav;
      }  
      
    public Vector<TypeFlussoIav> getListaServizi() throws CustomException,
                                                         RemoteException,
                                                         SQLException {
        listEccSerIav = eccSer.getListaServizi();
        
        return listEccSerIav;
    }
    
    public Vector<ResultRefuseIav> getResultFromFilter(String code, String startDate, String endDate, String area) throws SQLException,
                                                                              RemoteException {
        return eccSer.getTableFromFluxCode(code, startDate, endDate, area);
    }
    
    public String getNameFluxFromCode(String code) throws SQLException,
                                                          RemoteException {
        return eccSer.getNameFluxFromCode(code);
    }
    
    public Boolean insertDataFromInput(String startDate,String endDate,String startDate2,String endDate2,String ambitoIav,String serviziIav,String fontiIav,String tipologiaIav,String classTecIav,String note,String motivazioneBlocco, String operatoreIav) throws SQLException,
                                                                              RemoteException {
        return eccSer.insertExceptionSer(startDate,endDate,startDate2,endDate2,ambitoIav,serviziIav,fontiIav,tipologiaIav,classTecIav,note,motivazioneBlocco,operatoreIav);
    }
    
    public Vector<TypeFlussoIav> getListaOperatori() throws CustomException,
                                                         RemoteException,
                                                         SQLException {
        listEccOpeIav = eccSer.getListaOperatori();
        
        return listEccOpeIav;
    }
    
}

