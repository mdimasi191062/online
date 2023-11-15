package com.ejbSTL.impl;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import java.rmi.RemoteException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.rmi.PortableRemoteObject;
import java.util.Vector;
import java.util.GregorianCalendar;
import com.utl.*;
import com.ejbSTL.*;
import java.sql.*;
import com.ds.chart.*;

public class ChartEJBBean implements SessionBean  {
  private Control ctr;

  public void ejbCreate()
  {
    ctr=new Control();
  }

  public void ejbActivate()
  {
  }

  public void ejbPassivate()
  {
        ctr=null;
  }

  public void ejbRemove()
  {
        ctr=null;
  }

  public void setSessionContext(SessionContext ctx)
  {
  }


  public void setProperties(java.util.Properties pr) throws RemoteException{
    try {
      ctr.setProperties(pr);
    }catch(Exception ex){
      StaticContext.writeLog(StaticMessages.getMessage(5002,"Exception ChartEJBBean.init: "+ex.toString()));
    }
  }

  public void generateBarChart(BarDiagramDataset d) throws RemoteException{
    try {
      ctr.generateBarChart(d);
    }catch(Exception ex){
      StaticContext.writeLog(StaticMessages.getMessage(5002,"Exception ChartEJBBean.generateBarChart: "+ex.toString()));
    }
  }

  public void generateBarChart(PieDiagramDataset d, String title) throws RemoteException{
    try {
      ctr.generateBarChart(d, title);
    }catch(Exception ex){
      StaticContext.writeLog(StaticMessages.getMessage(5002,"Exception ChartEJBBean.generateBarChart: "+ex.toString()));
    }
  }
  
  public void generatePieChart(PieDiagramDataset d) throws RemoteException{
    try {
      ctr.generatePieChart(d);
    }catch(Exception ex){
      StaticContext.writeLog(StaticMessages.getMessage(5002,"Exception ChartEJBBean.generatePieChart: "+ex.toString()+"\n"));
    }
  }

  public byte[] getImageChart() throws RemoteException{
      return ctr.getImageChart();
  }

  public String getImageMap() throws RemoteException{
      return ctr.getImageMap();
  }

  public java.util.Properties getDefaultProperties() throws RemoteException{
    return Control.getDefaultProperties();
  }

  public void saveToFile(String f, byte[] b) throws RemoteException{
    try {
      Control.saveToFile(f, b);
    }catch(Exception ex){
      StaticContext.writeLog(StaticMessages.getMessage(5002,"Exception ChartEJBBean.saveToFile: "+ex.toString()));
    }
  }

  public PieDiagramDataset getPieDiagramDataset(String datasource, String codeTipoContratto, String groupId, String anno, String mese, String listaPS, java.awt.Color c, String flagSysTipoContratto) throws RemoteException{
    java.sql.Connection con=null;
    PieDiagramDataset d=null;
    try {
      con=DBManage.openCon(datasource);
      d=DBManage.getPieDiagramDataset(con, codeTipoContratto, groupId, anno,mese, listaPS, c, flagSysTipoContratto);
    }catch(Exception ex){
      StaticContext.writeLog(StaticMessages.getMessage(5002,"Exception ChartEJBBean.getPieDiagramDataset: "+ex.toString()));
    }finally{
      try {
        DBManage.closeCon(con);
      }catch(Exception ex){
        StaticContext.writeLog(StaticMessages.getMessage(5002,"Exception ChartEJBBean.getPieDiagramDataset: "+ex.toString()));
      }
    }
    return d;
  }

  public BarDiagramDataset getBarDiagramDataset(String datasource, String codeTipoContratto, String ids, String meseInizio, String annoInizio, String meseFine, String annoFine, String flagSysContratto) throws RemoteException{
    java.sql.Connection con=null;
    BarDiagramDataset d=null;
    try {
      con=DBManage.openCon(datasource);
      d=DBManage.getBarDiagramDataset(con, codeTipoContratto, ids, meseInizio, annoInizio, meseFine, annoFine, flagSysContratto);
    }catch(Exception ex){
      StaticContext.writeLog(StaticMessages.getMessage(5002,"Exception ChartEJBBean.getBarDiagramDataset: "+ex.toString()));
    }finally{
      try {
        DBManage.closeCon(con);
      }catch(Exception ex){
        StaticContext.writeLog(StaticMessages.getMessage(5002,"Exception ChartEJBBean.getBarDiagramDataset: "+ex.toString()));
      }
    }
    return d;
  }

  public java.util.Vector getListaGestori(String datasource, String codeAccount, String flagSys) throws RemoteException{
    java.sql.Connection con=null;
    java.util.Vector v =null;
    try {
      con=DBManage.openCon(datasource);
      v=DBManage.getListaGestori(con, codeAccount, flagSys);
    }catch(Exception ex){
      StaticContext.writeLog(StaticMessages.getMessage(5002,"Exception ChartEJBBean.getListaGestori: "+ex.toString()));
    }finally{
      try {
        DBManage.closeCon(con);
      }catch(Exception ex){
        StaticContext.writeLog(StaticMessages.getMessage(5002,"Exception ChartEJBBean.getListaGestori: "+ex.toString()));
      }
    }
    return v;
  }

  public java.util.Vector getListaPS(String datasource, String tipoContratto, String groupID, String anno, String mese, String flagSysTipoContratto) throws RemoteException{
    java.sql.Connection con=null;
    java.util.Vector v =null;
    try {
      con=DBManage.openCon(datasource);
      v=DBManage.getListaPS(con, tipoContratto, groupID, anno, mese, flagSysTipoContratto);
    }catch(Exception ex){
      StaticContext.writeLog(StaticMessages.getMessage(5002,"Exception ChartEJBBean.getListaPS: "+ex.toString()));
    }finally{
      try {
        DBManage.closeCon(con);
      }catch(Exception ex){
        StaticContext.writeLog(StaticMessages.getMessage(5002,"Exception ChartEJBBean.getListaPS: "+ex.toString()));
      }
    }
    return v;
  }
    
  public java.util.Vector getListaTipoContratto(String datasource, String flagSys) throws RemoteException{
    java.sql.Connection con=null;
    java.util.Vector v =null;
    try {
      con=DBManage.openCon(datasource);
      v=DBManage.getListaTipoContratto(con, flagSys);
    }catch(Exception ex){
      StaticContext.writeLog(StaticMessages.getMessage(5002,"Exception ChartEJBBean.getListaTipoContratto: "+ex.toString()));
    }finally{
      try {
        DBManage.closeCon(con);
      }catch(Exception ex){
        StaticContext.writeLog(StaticMessages.getMessage(5002,"Exception ChartEJBBean.getListaTipoContratto: "+ex.toString()));
      }
    }
    return v;
  }
}