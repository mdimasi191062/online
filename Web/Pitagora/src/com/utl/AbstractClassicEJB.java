package com.utl;
import java.lang.reflect.Method;
import javax.ejb.*;
import javax.naming.*;
import javax.rmi.PortableRemoteObject;
import java.rmi.*;
import java.util.Vector;
import com.ejbSTL.Ent_AnagraficaMessaggi;
import com.ejbSTL.Ent_AnagraficaMessaggiHome;
import com.ejbSTL.Ent_Batch;
import com.ejbSTL.Ent_BatchHome;
import com.ejbSTL.Ent_BatchNew;
import com.ejbSTL.Ent_BatchNewHome;


public abstract class AbstractClassicEJB extends AbstractEJB 
{

  protected final Vector getErrorMessages (Context pctx_Contesto, Vector parr_Input)
    throws Exception
    {
      try
      {
        return (private_getErrorMessages(pctx_Contesto,parr_Input));
      }
      catch (Exception lexc_Exception)
      {
        throw new Exception (this.getClass().getName() + ".getErrorMessages --> " + lexc_Exception.toString());
      }
    }
    
  protected final String getErrorMessage(Context pctx_Contesto, String parr_Input)
    throws Exception
    {
      String lstr_ReturnValue = null;
      DB_AnagraficaMessaggi lDB_AnagraficaMessaggi = null;
      try
      {
        Vector lvct_ErrorMessages = new Vector();
        lvct_ErrorMessages.addElement(parr_Input);
        lvct_ErrorMessages = private_getErrorMessages(pctx_Contesto,lvct_ErrorMessages);
        if ((lvct_ErrorMessages != null) && (lvct_ErrorMessages.size() > 0))
        {
          lDB_AnagraficaMessaggi = (DB_AnagraficaMessaggi)lvct_ErrorMessages.get(0);
          lstr_ReturnValue = lDB_AnagraficaMessaggi.getDESC_ERR();
        }
        return lstr_ReturnValue;
      }
      catch (Exception lexc_Exception)
      {
        throw new Exception (this.getClass().getName() + ".getErrorMessage --> " + lexc_Exception.toString());
      }
    }

  private Vector private_getErrorMessages(Context pctx_Contesto, Vector pvct_Messages)
  throws Exception
    {
      Ent_AnagraficaMessaggi lEnt_AnagraficaMessaggi = null;
      Ent_AnagraficaMessaggiHome lEnt_AnagraficaMessaggiHome = null;
      Object homeObject = null;
      try
      {
        // Istanzio una classe Ent_AnagraficaMessaggi
        // lEnt_AnagraficaMessaggiHome = (Ent_AnagraficaMessaggiHome) this.newEJBHomeInstance (pctx_Contesto, "Ent_AnagraficaMessaggi", Ent_AnagraficaMessaggiHome.class);
        homeObject = pctx_Contesto.lookup("Ent_AnagraficaMessaggi");
        lEnt_AnagraficaMessaggiHome = (Ent_AnagraficaMessaggiHome)PortableRemoteObject.narrow(homeObject, Ent_AnagraficaMessaggiHome.class);
        lEnt_AnagraficaMessaggi = lEnt_AnagraficaMessaggiHome.create();
        if ( lEnt_AnagraficaMessaggi != null )
        {
          return(lEnt_AnagraficaMessaggi.getAnagraficaMessaggi(StaticContext.INSERT,pvct_Messages));
        }
        return null;
      }
      catch (Exception lexc_Exception)
      {
        throw new Exception (this.getClass().getName() + ".getErrorMessages--> " + lexc_Exception.toString());
      }
    } 

  protected final String isRunningBatch(Context pctx_Contesto,int pint_CodOperazione)
    throws Exception
    {
      Object homeObject = null;
      Ent_Batch lent_Batch = null;
      Ent_BatchHome lent_BatchHome = null;
      String lstr_ReturnValue = null;
      try
      {
        // Istanzio una classe Ent_Batch
        homeObject = pctx_Contesto.lookup("Ent_Batch");
        lent_BatchHome = (Ent_BatchHome)PortableRemoteObject.narrow(homeObject, Ent_BatchHome.class);
        lent_Batch = lent_BatchHome.create();

        if (lent_Batch == null)
        {
          lstr_ReturnValue = "Errore : Elaborazione Batch in corso.";
        }
        else if (lent_Batch.chkElabBatch(pint_CodOperazione).intValue() != 0)
        {
          Vector lvct_ErrorMessages = null;
          lstr_ReturnValue = this.getErrorMessage(pctx_Contesto, StaticContext.RUNNING_BATCH);
          if ( lstr_ReturnValue == null ) 
          {
            lstr_ReturnValue = "Errore : Elaborazione Batch in corso.";
          }
        }
      }
      catch (Exception lexc_Exception)
      {
        throw new Exception (this.getClass().getName() + ".isRunningBatch --> " + lexc_Exception.toString());
      }
      return lstr_ReturnValue;
    }

  protected final String isRunningBatchNew(Context pctx_Contesto,String strParCodeFunz)
    throws Exception
    {
      Object homeObject = null;
      Ent_BatchNew lent_BatchNew = null;
      Ent_BatchNewHome lent_BatchNewHome = null;
      String lstr_ReturnValue = null;
      try
      {
        // Istanzio una classe Ent_Batch
        homeObject = pctx_Contesto.lookup("Ent_BatchNew");
        lent_BatchNewHome = (Ent_BatchNewHome)PortableRemoteObject.narrow(homeObject, Ent_BatchNewHome.class);
        lent_BatchNew = lent_BatchNewHome.create();

        if (lent_BatchNew == null)
        {
          lstr_ReturnValue = "Errore : Elaborazione Batch in corso.";
        }
        else if (lent_BatchNew.chkElabBatch(strParCodeFunz))
        {
          Vector lvct_ErrorMessages = null;
          lstr_ReturnValue = this.getErrorMessage(pctx_Contesto, StaticContext.RUNNING_BATCH);
          if ( lstr_ReturnValue == null ) 
          {
            lstr_ReturnValue = "Errore : Elaborazione Batch in corso.";
          }
        }
      }
      catch (Exception lexc_Exception)
      {
        throw new Exception (this.getClass().getName() + ".isRunningBatchNew --> " + lexc_Exception.toString());
      }
      return lstr_ReturnValue;
    }

  /*****Il metodo utilizza la JNDI per risolvere il nome ed instanziare un oggetto 
  // dato il suo naming context ed il suo nome
  protected final Object newEJBHomeInstance (Context pctx_Contesto, String pstr_EjbName, Class pent_EjbHome)
    throws Exception
    {
      Object homeObject = null;
      try
      {
          homeObject = pctx_Contesto.lookup(pstr_EjbName);
          return((EJBHome)PortableRemoteObject.narrow(homeObject, pent_EjbHome));
      }
      catch (Exception lexc_Exception)
      {
        throw new Exception (this.getClass().getName() + ".newEJBObjectInstance --> " + lexc_Exception.toString());
      }
    }
  *******/
}