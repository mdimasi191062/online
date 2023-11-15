package com.ejbSTL;
import javax.ejb.EJBObject;
import java.rmi.RemoteException;
import com.ds.chart.*;

public interface ChartEJB extends EJBObject  {
  public void setProperties(java.util.Properties pr) throws RemoteException;

  public void generateBarChart(BarDiagramDataset d) throws RemoteException;

  public void generateBarChart(PieDiagramDataset d, String title) throws RemoteException;
  
  public void generatePieChart(PieDiagramDataset d) throws RemoteException;

  public byte[] getImageChart() throws RemoteException;

  public String getImageMap() throws RemoteException;

  public java.util.Properties getDefaultProperties() throws RemoteException;

  public void saveToFile(String f, byte[] b) throws RemoteException;

  public PieDiagramDataset getPieDiagramDataset(String datasource, String codeTipoContratto, String groupId, String anno, String mese, String listaPS, java.awt.Color c, String flagSysTipoContratto) throws RemoteException;

  public BarDiagramDataset getBarDiagramDataset(String datasource, String codeTipoContratto, String ids, String meseInizio, String annoInizio, String meseFine, String annoFine, String flagSysContratto) throws RemoteException;

  public java.util.Vector getListaGestori(String datasource, String codeAccount, String flagSys) throws RemoteException;
  
  public java.util.Vector getListaTipoContratto(String datasource, String flagSys) throws RemoteException;

  public java.util.Vector getListaPS(String datasource, String tipoContratto, String groupID, String anno, String mese, String flagSysTipoContratto) throws RemoteException;

}