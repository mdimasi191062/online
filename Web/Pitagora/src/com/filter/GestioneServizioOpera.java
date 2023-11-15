package com.filter;

import com.ejbSTL.TypeVerCiclo;
import com.ejbSTL.TypeServizi;
import com.ejbSTL.TypeAccount;
import com.ejbSTL.TypeDescrizione;
import com.ejbSTL.TypeBatch;
import com.ejbSTL.TypeElaborati;
import com.ejbSTL.impl.GestioneServizioOperaBean;

import com.utl.CustomException;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import java.io.PrintWriter;

import java.net.URL;

import java.rmi.RemoteException;

import java.sql.SQLException;

import java.util.Vector;

public class GestioneServizioOpera {

    public Vector<TypeVerCiclo> listVerCiclo = new Vector<TypeVerCiclo>();
    public Vector<TypeServizi> listServizi = new Vector<TypeServizi>();
    public Vector<TypeAccount> listAccount = new Vector<TypeAccount>();
    public Vector<TypeDescrizione> listDescrizione = new Vector<TypeDescrizione>();
    public Vector<TypeBatch> listBatch = new Vector<TypeBatch>();
    public Vector<TypeElaborati> listElaborati = new Vector<TypeElaborati>();
    private GestioneServizioOperaBean gest;

    public GestioneServizioOpera() {
        gest = new GestioneServizioOperaBean();
    }
    
    public Vector<TypeVerCiclo> listVerCiclo() throws CustomException,
                                                         RemoteException,
                                                         SQLException {
        listVerCiclo = gest.queryGetVerCiclo();
        
        return listVerCiclo;
    }
    
    public Vector<TypeServizi> listServizi(String provenienza) throws CustomException,
                                                         RemoteException,
                                                         SQLException {
        listServizi = gest.queryGetServizi(provenienza);
        
        return listServizi;
    }        

    public Vector<TypeAccount> listAccount(String code_tipo_contr, String ciclo, String flag, String codetipoelab) throws CustomException,
                                                         RemoteException,
                                                         SQLException {
        listAccount = gest.queryGetAccount(code_tipo_contr, ciclo, flag, codetipoelab);
        
        return listAccount;
    }        

    public Vector<TypeDescrizione> listDescrizione(String code_tipo_contr) throws CustomException,
                                                         RemoteException,
                                                         SQLException {
        listDescrizione = gest.queryGetDescrizione(code_tipo_contr);
        
        return listDescrizione;
    }         

    public Vector<TypeBatch> listBatch(String code_funz, String ciclo, String code_tipo_contr) throws CustomException,
                                                         RemoteException,
                                                         SQLException {
        listBatch = gest.queryGetBatch(code_funz, ciclo, code_tipo_contr);
        
        return listBatch;
    }

    public Vector<TypeElaborati> listElaborati(String code_elab) throws CustomException,
                                                         RemoteException,
                                                         SQLException {
        listElaborati = gest.queryGetElaborati(code_elab);
        
        return listElaborati;
    }

}