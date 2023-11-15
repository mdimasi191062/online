package com.ejbBMP.impl;

import java.util.*;
import java.rmi.*;
import java.sql.*;
import javax.ejb.*;
import javax.naming.*;
import oracle.jdbc.*;
import oracle.sql.*;
import com.ejbBMP.PeriodoRifBMPPK;
import com.utl.*;


public class PeriodoRifBMPBean extends AbstractEntityCommonBean implements EntityBean
{
  public EntityContext entityContext;
  private PeriodoRifBMPPK pk;
  private boolean enableStore=false;
  public PeriodoRifBMPPK ejbCreate()
  throws CreateException, RemoteException
  {
    pk = new PeriodoRifBMPPK();
    return pk;
  }

  public void ejbPostCreate()
  {
  }

  public PeriodoRifBMPPK ejbFindByPrimaryKey(PeriodoRifBMPPK primaryKey) throws RemoteException, FinderException
  {
    Connection conn=null;
    return pk;
  }

  public Collection ejbFindValAttSpec1(String CodTipoContr) throws FinderException, RemoteException
	{
    Vector recs = new Vector();
 		try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PARAM_VALO_SP_PER_RIFR_VA_ULL (?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,CodTipoContr);
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_PERIODO_RIFR");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();
      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
          throw new EJBException("DB:"+cs.getInt(3)+":"+cs.getString(4)+"NOME STORED: PARAM_VALO_SP_PER_RIFR_VA_ULL");

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_PERIODO_RIFR",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new PeriodoRifBMPPK();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              pk.setCode(attr[1].stringValue());
              pk.setDescOf(attr[0].stringValue());
              recs.add(pk);
          }
      cs.close();
      // Chiudo la connessione
      conn.close();
    }

    catch(Exception lexc_Exception)
      {
       throw new CustomEJBException(lexc_Exception.toString(),
       "",
       "ejbFindValAttSpec1",
       this.getClass().getName(),
       StaticContext.FindExceptionType(lexc_Exception));
      }
    finally
      {
        try
        {
          conn.close();
        } catch(Exception lexc_Exception)
        {
          throw new CustomEJBException(lexc_Exception.toString(),
       "",
       "ejbFindValAttSpec1",
       this.getClass().getName(),
       StaticContext.FindExceptionType(lexc_Exception));
        }
      }
/*		catch(SQLException e)
		{
			throw new FinderException(e.getMessage());
		} finally
		{
			try
			{
				conn.close();
			} catch(Exception e)
			{
        throw new RemoteException(e.getMessage());
			}
		}*/
    return recs;
  }

  public  PeriodoRifBMPPK ejbFindPerCicloFat(String CodTipoContr,String CodCicloFat) throws FinderException, RemoteException
  {
   PeriodoRifBMPPK pk = new PeriodoRifBMPPK();
   Connection conn=null;
 		try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PARAM_VALO_DETERMINA_CICLO (?,?,?,?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,CodTipoContr);
      cs.setString(2,CodCicloFat);
      cs.registerOutParameter(3,Types.VARCHAR);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.registerOutParameter(6,Types.INTEGER);
      cs.registerOutParameter(7,Types.VARCHAR);
      cs.execute();
      if ((cs.getInt(6)!=DBMessage.OK_RT)&&(cs.getInt(6)!=DBMessage.NOT_FOUND_RT))
          throw new Exception("DB:"+cs.getInt(6)+":"+cs.getString(7)+"NOME STORED: PARAM_VALO_DETERMINA_CICLO");
      pk.setDataIniCiclo(cs.getString(3));
      pk.setDataFineCiclo(cs.getString(4));
      pk.setPeriodoFat(cs.getString(5));
      cs.close();
      // Chiudo la connessione
      conn.close();
    }
    catch(SQLException e)
		{
      StaticMessages.setCustomString(e.toString());
      StaticContext.writeLog(StaticMessages.getMessage(5002,"TariffaBMPBean","","",StaticContext.APP_SERVER_DRIVER));
      e.printStackTrace();
			throw new FinderException(e.getMessage());
		}
    catch(Exception ee)
		{
      StaticMessages.setCustomString(ee.toString());
      StaticContext.writeLog(StaticMessages.getMessage(5003,"PeriodoRifBMPBean","","",StaticContext.APP_SERVER_DRIVER));
      ee.printStackTrace();
			throw new RemoteException(ee.getMessage());
		}
finally
		{
			try
			{
				conn.close();
			} catch(Exception e)
			{
        StaticMessages.setCustomString(e.toString());
        StaticContext.writeLog(StaticMessages.getMessage(5002,"","","",StaticContext.APP_SERVER_DRIVER));
        e.printStackTrace();
        throw new RemoteException(e.getMessage());
			}
		}
   return  pk;
  }

public Collection ejbFindValAttClass(String CodTipoContr) throws FinderException, RemoteException
	{
    Vector recs = new Vector();
 		try
		{

			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PARAM_VALO_CL_PER_RIFR_VA (?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,CodTipoContr);
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_PERIODO_RIFR");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();
      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
          throw new EJBException("DB:"+cs.getInt(3)+":"+cs.getString(4)+"NOME STORED: PARAM_VALO_CL_PER_RIFR_VA");

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_PERIODO_RIFR",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new PeriodoRifBMPPK();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              pk.setCode(attr[1].stringValue());
              pk.setDescOf(attr[0].stringValue());
              recs.add(pk);
          }

      cs.close();
      // Chiudo la connessione
      conn.close();
    }
    catch(Exception lexc_Exception)
      {
       throw new CustomEJBException(lexc_Exception.toString(),
       "",
       "ejbFindValAttClass",
       this.getClass().getName(),
       StaticContext.FindExceptionType(lexc_Exception));
      }
    finally
      {
        try
        {
          conn.close();
        } catch(Exception lexc_Exception)
        {
          throw new CustomEJBException(lexc_Exception.toString(),
       "",
       "ejbFindValAttClass",
       this.getClass().getName(),
       StaticContext.FindExceptionType(lexc_Exception));
        }
      }    
/*		catch(SQLException e)
		{
			throw new FinderException(e.getMessage());
		} finally
		{
			try
			{
				conn.close();
			} catch(Exception e)
			{
        throw new RemoteException(e.getMessage());
			}
		}*/
    return recs;
  }

public Collection ejbFindAvanzRicClass(String CodTipoContr) throws FinderException, RemoteException
	{
    Vector recs = new Vector();

 		try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PARAM_VALO_CL_PER_RIFR_SAR (?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,CodTipoContr);
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_PERIODO_RIFR");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();
      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
          throw new EJBException("DB:"+cs.getInt(3)+":"+cs.getString(4)+"NOME STORED: PARAM_VALO_CL_PER_RIFR_SAR");      

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_PERIODO_RIFR",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new PeriodoRifBMPPK();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              pk.setCode(attr[1].stringValue());
              pk.setDescOf(attr[0].stringValue());
              recs.add(pk);
          }
      cs.close();
      // Chiudo la connessione
      conn.close();
    }
    catch(Exception lexc_Exception)
      {
       throw new CustomEJBException(lexc_Exception.toString(),
       "",
       "ejbFindAvanzRicClass",
       this.getClass().getName(),
       StaticContext.FindExceptionType(lexc_Exception));
      }
    finally
      {
        try
        {
          conn.close();
        } catch(Exception lexc_Exception)
        {
          throw new CustomEJBException(lexc_Exception.toString(),
       "",
       "ejbFindAvanzRicClass",
       this.getClass().getName(),
       StaticContext.FindExceptionType(lexc_Exception));
        }
      }    
    
/*		catch(SQLException e)
		{
			throw new FinderException(e.getMessage());
		} finally
		{
			try
			{
				conn.close();
			} catch(Exception e)
			{
        throw new RemoteException(e.getMessage());
			}
		}*/
    return recs;
  }

public Collection ejbFindNotaCreClass(String CodTipoContr) throws FinderException, RemoteException
	{
    Vector recs = new Vector();
 		try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PARAM_VALO_CL_PER_RIFR_NC (?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,CodTipoContr);
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_PERIODO_RIFR");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();
            if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
          throw new Exception("DB:"+cs.getInt(3)+":"+cs.getString(4)+"NOME STORED: PARAM_VALO_CL_PER_RIFR_NC");      
      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_PERIODO_RIFR",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new PeriodoRifBMPPK();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              pk.setCode(attr[1].stringValue());
              pk.setDescOf(attr[0].stringValue());
              recs.add(pk);
          }

      cs.close();
      // Chiudo la connessione
      conn.close();
    }
    catch(Exception lexc_Exception)
      {
       throw new CustomEJBException(lexc_Exception.toString(),
       "",
       "ejbFindNotaCreClass",
       this.getClass().getName(),
       StaticContext.FindExceptionType(lexc_Exception));
      }
    finally
      {
        try
        {
          conn.close();
        } catch(Exception lexc_Exception)
        {
          throw new CustomEJBException(lexc_Exception.toString(),
       "",
       "ejbFindNotaCreClass",
       this.getClass().getName(),
       StaticContext.FindExceptionType(lexc_Exception));
        }
      }    
    
/*		catch(SQLException e)
		{
			throw new FinderException(e.getMessage());
}
finally
		{
			try
			{
				conn.close();
			} 
      catch(Exception e)
			{
        throw new RemoteException(e.getMessage());
			}
		}*/
    return recs;
  }


  
public Collection ejbFindRepricClass(String CodTipoContr, String Funz) throws FinderException, RemoteException
	{
    Vector recs = new Vector();

 		try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PARAM_VALO_CL_PER_RIFR_REPR (?,?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,CodTipoContr);
      cs.setString(2,Funz);
      cs.registerOutParameter(3,OracleTypes.ARRAY, "ARR_PERIODO_RIFR");
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();
      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
          throw new EJBException("DB:"+cs.getInt(4)+":"+cs.getString(5)+"NOME STORED: PARAM_VALO_CL_PER_RIFR_REPR");
      
      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_PERIODO_RIFR",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(3);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new PeriodoRifBMPPK();

              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              pk.setCode(attr[1].stringValue());
              pk.setDescOf(attr[0].stringValue());
              recs.add(pk);
          }

      cs.close();
      // Chiudo la connessione
      conn.close();
    }
    catch(Exception lexc_Exception)
      {
       throw new CustomEJBException(lexc_Exception.toString(),
       "",
       "ejbFindRepricClass",
       this.getClass().getName(),
       StaticContext.FindExceptionType(lexc_Exception));
      }
    finally
      {
        try
        {
          conn.close();
        } catch(Exception lexc_Exception)
        {
          throw new CustomEJBException(lexc_Exception.toString(),
       "",
       "ejbFindRepricClass",
       this.getClass().getName(),
       StaticContext.FindExceptionType(lexc_Exception));
        }
      }        
		/*catch(SQLException e)
		{
			throw new FinderException(e.getMessage());
		} 
    finally
		{
			try
			{
				conn.close();
			} 
      catch(Exception e)
			{
        throw new RemoteException(e.getMessage());
			}
		}*/
    return recs;
  }

public Collection ejbFindNotaCreSpec1(String CodTipoContr) throws FinderException, RemoteException
	{
    Vector recs = new Vector();

 		try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PARAM_VALO_SP_PER_RIFR_NC_ULL (?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,CodTipoContr);
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_PERIODO_RIFR");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();
      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
         throw new EJBException("DB:"+cs.getInt(3)+":"+cs.getString(4)+"NOME STORED: PARAM_VALO_SP_PER_RIFR_NC_ULL");      

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_PERIODO_RIFR",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();
      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new PeriodoRifBMPPK();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              pk.setCode(attr[1].stringValue());
              pk.setDescOf(attr[0].stringValue());
              recs.add(pk);
          }

      cs.close();
      // Chiudo la connessione
      conn.close();
    }

    catch(Exception lexc_Exception)
      {
       throw new CustomEJBException(lexc_Exception.toString(),
       "",
       "ejbFindNotaCreSpec1",
       this.getClass().getName(),
       StaticContext.FindExceptionType(lexc_Exception));
      }
    finally
      {
        try
        {
          conn.close();
        } catch(Exception lexc_Exception)
        {
          throw new CustomEJBException(lexc_Exception.toString(),
       "",
       "ejbFindNotaCreSpec1",
       this.getClass().getName(),
       StaticContext.FindExceptionType(lexc_Exception));
        }
      }        
    
/*		catch(SQLException e)
		{
			throw new FinderException(e.getMessage());
		} finally
		{
			try
			{
				conn.close();
			} 
      catch(Exception e)
			{
        throw new RemoteException(e.getMessage());
			}
		}*/
    return recs;
    }
public Collection ejbFindValAttSpec2(String CodTipoContr) throws FinderException, RemoteException
	{
    Vector recs = new Vector();

 		try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PARAM_VALO_SP_PER_RIFR_VA_XDSL (?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,CodTipoContr);
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_PERIODO_RIFR");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();
      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
         throw new EJBException("DB:"+cs.getInt(3)+":"+cs.getString(4)+"NOME STORED: PARAM_VALO_SP_PER_RIFR_VA_XDSL");      

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_PERIODO_RIFR",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();
      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new PeriodoRifBMPPK();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              pk.setCode(attr[1].stringValue());
              pk.setDescOf(attr[0].stringValue());
              recs.add(pk);
          }

      cs.close();
      // Chiudo la connessione
      conn.close();
    }
    catch(Exception lexc_Exception)
      {
       throw new CustomEJBException(lexc_Exception.toString(),
       "",
       "ejbFindValAttSpec2",
       this.getClass().getName(),
       StaticContext.FindExceptionType(lexc_Exception));
      }
    finally
      {
        try
        {
          conn.close();
        } catch(Exception lexc_Exception)
        {
          throw new CustomEJBException(lexc_Exception.toString(),
       "",
       "ejbFindValAttSpec2",
       this.getClass().getName(),
       StaticContext.FindExceptionType(lexc_Exception));
        }
      }            
		/*catch(SQLException e)
		{
			throw new FinderException(e.getMessage());
		} finally
		{
			try
			{
				conn.close();
			} catch(Exception e)
			{
        throw new RemoteException(e.getMessage());
			}
		}*/
    return recs;
  }
	public Collection ejbFindRepSpec2(String CodTipoContr) throws FinderException, RemoteException
	{
		Vector recs = new Vector();

		try
		{
			conn = getConnection(dsName);
			OracleCallableStatement cs = (OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PARAM_VALO_SP_PER_REPR_XDSL (?,?,?,?)}");

			// Impostazione types I/O
			cs.setString(1, CodTipoContr);
			cs.registerOutParameter(2, OracleTypes.ARRAY, "ARR_PERIODO_RIFR");
			cs.registerOutParameter(3, Types.INTEGER);
			cs.registerOutParameter(4, Types.VARCHAR);
			cs.execute();
			if ((cs.getInt(3) != DBMessage.OK_RT) && (cs.getInt(3) != DBMessage.NOT_FOUND_RT))
				throw new EJBException("DB:" + cs.getInt(3) + ":" + cs.getString(4) + "NOME STORED: PARAM_VALO_SP_PER_RIFR_VA_XDSL");

			// Costruisco l'array che conterrà i dati di ritorno della stored
			ArrayDescriptor ad = ArrayDescriptor.createDescriptor("ARR_PERIODO_RIFR", conn);
			ARRAY rs = new ARRAY(ad, conn, null);

			// Ottengo i dati
			rs = cs.getARRAY(2);
			Datum dati[] = rs.getOracleArray();
			// Estrazione dei dati
			for (int i = 0; i < dati.length; i++)
			{
				pk = new PeriodoRifBMPPK();
				STRUCT s = (STRUCT)dati[i];
				Datum attr[] = s.getOracleAttributes();
				pk.setCode(attr[1].stringValue());
				pk.setDescOf(attr[0].stringValue());
				recs.add(pk);
			}

			cs.close();
			// Chiudo la connessione
			conn.close();
		}
		catch (Exception lexc_Exception)
		{
			throw new CustomEJBException(lexc_Exception.toString(),
			"",
			"ejbFindRepSpec2",
			this.getClass().getName(),
			StaticContext.FindExceptionType(lexc_Exception));
		}
		finally
		{
			try
			{
				conn.close();
			}
			catch (Exception lexc_Exception)
			{
				throw new CustomEJBException(lexc_Exception.toString(),
			 "",
			 "ejbFindRepSpec2",
			 this.getClass().getName(),
			 StaticContext.FindExceptionType(lexc_Exception));
			}
		}
		/*catch(SQLException e)
		{
			throw new FinderException(e.getMessage());
		} finally
		{
			try
			{
				conn.close();
			} catch(Exception e)
			{
		throw new RemoteException(e.getMessage());
			}
		}*/
			return recs;
	}

  public Collection ejbFindFattMan(String CodTipoContr) throws FinderException, RemoteException
  {
    Vector recs = new Vector();

    try
    {
      conn = getConnection(dsName);
      OracleCallableStatement cs = (OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL_ONLINE + ".PARAM_VALO_SP_PER_FATT_MAN (?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1, CodTipoContr);
      cs.registerOutParameter(2, OracleTypes.ARRAY, "ARR_PERIODO_RIFR");
      cs.registerOutParameter(3, Types.INTEGER);
      cs.registerOutParameter(4, Types.VARCHAR);
      cs.execute();
      if ((cs.getInt(3) != DBMessage.OK_RT) && (cs.getInt(3) != DBMessage.NOT_FOUND_RT))
        throw new EJBException("DB:" + cs.getInt(3) + ":" + cs.getString(4) + "NOME STORED: PARAM_VALO_SP_PER_FATT_MAN");

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad = ArrayDescriptor.createDescriptor("ARR_PERIODO_RIFR", conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs = cs.getARRAY(2);
      Datum dati[] = rs.getOracleArray();
      // Estrazione dei dati
      for (int i = 0; i < dati.length; i++)
      {
        pk = new PeriodoRifBMPPK();
        STRUCT s = (STRUCT)dati[i];
        Datum attr[] = s.getOracleAttributes();
        pk.setCode(attr[1].stringValue());
        pk.setDescOf(attr[0].stringValue());
        recs.add(pk);
      }

      cs.close();
      // Chiudo la connessione
      conn.close();
    }
    catch (Exception lexc_Exception)
    {
      throw new CustomEJBException(lexc_Exception.toString(),
      "",
      "ejbfindFattMan",
      this.getClass().getName(),
      StaticContext.FindExceptionType(lexc_Exception));
    }
    finally
    {
      try
      {
        conn.close();
      }
      catch (Exception lexc_Exception)
      {
        throw new CustomEJBException(lexc_Exception.toString(),
       "",
       "ejbfindFattMan",
       this.getClass().getName(),
       StaticContext.FindExceptionType(lexc_Exception));
      }
    }

      return recs;
  }


public Collection ejbFindNotaCreSpec2(String CodTipoContr) throws FinderException, RemoteException
	{
    Vector recs = new Vector();

 		try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PARAM_VALO_SP_PER_RIFR_NC_XDSL (?,?,?,?)}");

      // Impostazione types I/O
      cs.setString(1,CodTipoContr);
      cs.registerOutParameter(2,OracleTypes.ARRAY, "ARR_PERIODO_RIFR");
      cs.registerOutParameter(3,Types.INTEGER);
      cs.registerOutParameter(4,Types.VARCHAR);
      cs.execute();
      if ((cs.getInt(3)!=DBMessage.OK_RT)&&(cs.getInt(3)!=DBMessage.NOT_FOUND_RT))
         throw new EJBException("DB:"+cs.getInt(3)+":"+cs.getString(4)+"NOME STORED: PARAM_VALO_SP_PER_RIFR_NC_XDSL");            

      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_PERIODO_RIFR",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(2);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new PeriodoRifBMPPK();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              pk.setCode(attr[1].stringValue());
              pk.setDescOf(attr[0].stringValue());
              recs.add(pk);
          }

      cs.close();
      // Chiudo la connessione
      conn.close();
    }
        catch(Exception lexc_Exception)
      {
       throw new CustomEJBException(lexc_Exception.toString(),
       "",
       "ejbFindNotaCreSpec2",
       this.getClass().getName(),
       StaticContext.FindExceptionType(lexc_Exception));
      }
    finally
      {
        try
        {
          conn.close();
        } catch(Exception lexc_Exception)
        {
          throw new CustomEJBException(lexc_Exception.toString(),
       "",
       "ejbFindNotaCreSpec2",
       this.getClass().getName(),
       StaticContext.FindExceptionType(lexc_Exception));
        }
      }                
		/*catch(SQLException e)
		{
			throw new FinderException(e.getMessage());
		} finally
		{
			try
			{
				conn.close();
			} catch(Exception e)
			{
        throw new RemoteException(e.getMessage());
			}
		}*/
    return recs;
  }
    public String getCode()
  {
      pk = (PeriodoRifBMPPK) ctx.getPrimaryKey();
      if (pk==null) return null;
      else
        return pk.getCode();
  }

public Collection ejbFindRepricing(String CodTipoContr, String Funz) throws FinderException, RemoteException
	{
    Vector recs = new Vector();

 		try
		{
			conn = getConnection(dsName);
      OracleCallableStatement cs=(OracleCallableStatement)conn.prepareCall("{call " + StaticContext.PACKAGE_SPECIAL + ".PARAM_VALO_SP_PER_RIFR_VR_ULL (?,?,?,?,?)}");
      // Impostazione types I/O
      cs.setString(1,CodTipoContr);
      cs.setString(2,Funz);
      cs.registerOutParameter(3,OracleTypes.ARRAY, "ARR_PERIODO_RIFR");
      cs.registerOutParameter(4,Types.INTEGER);
      cs.registerOutParameter(5,Types.VARCHAR);
      cs.execute();
      if ((cs.getInt(4)!=DBMessage.OK_RT)&&(cs.getInt(4)!=DBMessage.NOT_FOUND_RT))
          throw new EJBException("DB:"+cs.getInt(4)+":"+cs.getString(5)+"NOME STORED: PARAM_VALO_SP_PER_RIFR_VR_ULL");
      
      // Costruisco l'array che conterrà i dati di ritorno della stored
      ArrayDescriptor ad=ArrayDescriptor.createDescriptor("ARR_PERIODO_RIFR",conn);
      ARRAY rs = new ARRAY(ad, conn, null);

      // Ottengo i dati
      rs=cs.getARRAY(3);
      Datum dati[]=rs.getOracleArray();

      // Estrazione dei dati
      for (int i=0;i<dati.length;i++)
          {
              pk = new PeriodoRifBMPPK();
              STRUCT s=(STRUCT)dati[i];
              Datum attr[]=s.getOracleAttributes();
              pk.setCode(attr[1].stringValue());
              pk.setDescOf(attr[0].stringValue());
              recs.add(pk);
          }

      cs.close();
      // Chiudo la connessione
      conn.close();
    }
    catch(Exception lexc_Exception)
      {
       throw new CustomEJBException(lexc_Exception.toString(),
       "",
       "ejbFindRepricing",
       this.getClass().getName(),
       StaticContext.FindExceptionType(lexc_Exception));
      }
    finally
      {
        try
        {
          conn.close();
        } catch(Exception lexc_Exception)
        {
          throw new CustomEJBException(lexc_Exception.toString(),
       "",
       "ejbFindRepricing",
       this.getClass().getName(),
       StaticContext.FindExceptionType(lexc_Exception));
        }
      }                
		/*catch(SQLException e)
		{
			throw new FinderException(e.getMessage());
		} 
    finally
		{
			try
			{
				conn.close();
			} 
      catch(Exception e)
			{
        throw new RemoteException(e.getMessage());
			}
		}*/
    return recs;
  }

//code= DATA_PERIODO
  public void setCode(String code)
  {

		pk = (PeriodoRifBMPPK) ctx.getPrimaryKey();
		pk.setCode (code);

  }
//desc = periodo_vis
 public String getDesc()
  {
      pk = (PeriodoRifBMPPK) ctx.getPrimaryKey();
      return pk.getDescOf();
  }

  public void setDesc(String desc)
  {
		pk = (PeriodoRifBMPPK) ctx.getPrimaryKey();
		pk.setDescOf (desc);
  }

   public String getPeriodoFat()
    {
        pk = (PeriodoRifBMPPK) ctx.getPrimaryKey();
        if (pk==null) return null;
        else
          return pk.getPeriodoFat();
    }

    public void setPeriodoFat(String periodo)
    {
  		pk = (PeriodoRifBMPPK) ctx.getPrimaryKey();
  		pk.setPeriodoFat(periodo);
    }

   public String getDataFineCiclo()
    {
        pk = (PeriodoRifBMPPK) ctx.getPrimaryKey();
        return pk.getDataFineCiclo();
    }

    public void setDataFineCiclo(String dataF)
    {
  		pk = (PeriodoRifBMPPK) ctx.getPrimaryKey();
  		pk.setDataFineCiclo (dataF);
    }

   public String getDataIniCiclo()
    {
        pk = (PeriodoRifBMPPK) ctx.getPrimaryKey();
        return pk.getDataIniCiclo();
    }

    public void setDataIniCiclo(String dataI)
    {
  		pk = (PeriodoRifBMPPK) ctx.getPrimaryKey();
  		pk.setDataIniCiclo (dataI);
    }
}