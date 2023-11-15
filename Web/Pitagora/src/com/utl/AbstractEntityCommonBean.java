package com.utl;

import java.rmi.*;
import javax.naming.*;
import javax.ejb.*;
import com.utl.StaticContext;

public abstract class AbstractEntityCommonBean extends AbstractDataSource  
{

	protected EntityContext ctx;

	public EJBHome getEJBHome()
	{
		return ctx.getEJBHome();
	}

	public Handle getHandle() throws RemoteException
	{
		return ctx.getEJBObject().getHandle();
	}

	public Object getPrimaryKey() throws RemoteException
	{
		return ctx.getEJBObject().getPrimaryKey();
	}

	public boolean isIdentical(EJBObject remote) throws RemoteException
	{
		return ctx.getEJBObject().isIdentical(remote);
	}

//  public void remove() throws RemoveException,RemoteException {
//    ctx.getEJBObject().remove();
//  }


	public void ejbActivate()
	{
	}

	public void ejbLoad() throws RemoteException {}

	public void ejbPassivate()
	{
	}

	public void ejbRemove() throws RemoveException, RemoteException {}

	public void ejbStore() throws RemoteException {}

	public void setEntityContext(EntityContext newCtx)
	{
		ctx = newCtx;
	}

	public void unsetEntityContext()
	{
		ctx = null;
	}


}

