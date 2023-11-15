package com.ejbSTL;

import java.sql.*;
import java.io.Serializable;

public class I5_REPORT_ELAB_SCARTI implements Serializable
{

  protected String DATA_LOG;
  protected String ELAB_CRMNOWREG;
  protected String SCARTI_CRMNOWREG;
  protected String ELAB_CRMNOW;
  protected String SCARTI_CRMNOW;
  protected String ELAB_CRMREG;
  protected String SCARTI_CRMREG;
  protected String ELAB_CRM;
  protected String SCARTI_CRM;

  
  public String getDATA_LOG()
   {
     return DATA_LOG;
   }

  public void setDATA_LOG(String pValue)
   {
     DATA_LOG = pValue;
   }

  public String getELAB_CRMNOWREG()
   {
     return ELAB_CRMNOWREG;
   }

  public void setELAB_CRMNOWREG(String pValue)
   {
     ELAB_CRMNOWREG = pValue;
   }
  
  public String getSCARTI_CRMNOWREG()
   {
     return SCARTI_CRMNOWREG;
   }

  public void setSCARTI_CRMNOWREG(String pValue)
   {
     SCARTI_CRMNOWREG = pValue;
   }

  public String getELAB_CRMNOW()
   {
     return ELAB_CRMNOW;
   }

  public void setELAB_CRMNOW(String pValue)
   {
     ELAB_CRMNOW = pValue;
   }
  
  public String getSCARTI_CRMNOW()
   {
     return SCARTI_CRMNOW;
   }

  public void setSCARTI_CRMNOW(String pValue)
   {
     SCARTI_CRMNOW = pValue;
   }

  public String getELAB_CRMREG()
   {
     return ELAB_CRMREG;
   }

  public void setELAB_CRMREG(String pValue)
   {
     ELAB_CRMREG = pValue;
   }
  
  public String getSCARTI_CRMREG()
   {
     return SCARTI_CRMREG;
   }

  public void setSCARTI_CRMREG(String pValue)
   {
     SCARTI_CRMREG = pValue;
   }

  public String getELAB_CRM()
   {
     return ELAB_CRM;
   }

  public void setELAB_CRM(String pValue)
   {
     ELAB_CRM = pValue;
   }
  
  public String getSCARTI_CRM()
   {
     return SCARTI_CRM;
   }

  public void setSCARTI_CRM(String pValue)
   {
     SCARTI_CRM = pValue;
   }
}
