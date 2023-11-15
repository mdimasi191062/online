package com.service;

import com.model.AccountModel;
import com.model.IavModel;

import com.model.PeriodModel;

import com.repository.IavRepository;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

import java.rmi.RemoteException;

import java.sql.SQLException;

import java.util.Vector;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class IavService {

    private IavRepository iavRepository;

    public IavService() {
        this.iavRepository = new IavRepository();
    }
    
    public Vector<IavModel> getAllServiceIav() throws RemoteException,
                                                      SQLException {
        Vector<IavModel> iavServices = new Vector<IavModel>();
        iavServices = this.iavRepository.getAllServiceIav();
        return iavServices;
    }
    
    public Vector<AccountModel>getAllAccount(String codeTipContr) throws RemoteException,
                                                                          SQLException {
        Vector<AccountModel> accounts = new Vector<AccountModel>();
        accounts = this.iavRepository.getAllAccount(codeTipContr);
        return accounts;
    }
    
    public Vector<PeriodModel> getAllPeriod() throws RemoteException,
                                                     SQLException {
        Vector<PeriodModel> periods = new Vector<PeriodModel>();
        periods = this.iavRepository.getAllPeriod();
        return periods;
    }
    
}
