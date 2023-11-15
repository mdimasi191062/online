package com.applet;

import java.applet.Applet;
import java.util.Vector;
import java.awt.Dimension;
import java.awt.Toolkit;
import java.awt.BorderLayout;
import java.awt.GridLayout;
import java.awt.Canvas;
import java.awt.Frame;
import java.awt.Adjustable;
import java.awt.Graphics;
import java.awt.Font;
import java.awt.Image;
import java.awt.Color;
import java.awt.Cursor;
import java.awt.FontMetrics;
import java.awt.Event;
import java.awt.Panel;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.awt.event.MouseListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseMotionListener;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;


public class Tree extends Applet 
implements MouseListener,MouseMotionListener
{
	protected int valuex,valuey;
	private base bb;
	protected Arrows arrow;
	protected int dimy,ty,dimx,tx;
	protected int extd = -1;
	protected Image[] arrows;
	protected int cp = -1;

	public void init()
	{
		tx = Integer.parseInt(getParameter("sizex"));
		ty = Integer.parseInt(getParameter("sizey"));
		bb = new base(tx,ty-20,this);
		setLayout(new BorderLayout());
		setBackground(new Color(214,223,247));

		arrow = new Arrows();
		arrow.setSize(tx,20);
		arrow.addMouseListener(this);
		arrow.addMouseMotionListener(this);
		valuex = dimx-140;
		add("South",arrow);
		add("Center",bb);
    impostaPosizione();
	}

  public void impostaPosizione() {
    while(dimx-bb.getPreferredSize().width-valuex >0) {
      valuex+=10;
      if(bb.getPreferredSize().width < valuex+tx)
      {
        valuex-=10;
        if(valuex<0)
        valuex=0;
      }
    }
    bb.setSize(bb.getPreferredSize());
		bb.repaint();
		arrow.repaint();
		repaint();
  }

	public void mouseClicked(MouseEvent e)
	{
	}
	public void mouseEntered(MouseEvent e)
	{
	}
	public void mouseExited(MouseEvent e)
	{
		cp = -1;
		arrow.repaint();
	}
	public void mousePressed(MouseEvent e)
	{
		switch(cp)
		{
		case -1:
			break;
		case 0:
			if(dimx-bb.getPreferredSize().width-valuex >0)
				valuex+=10;
			break;
		case 1:
			if(bb.getPreferredSize().width < valuex+tx)
			{
				valuex-=10;
				if(valuex<0)
					valuex=0;
			}
			break;
		case 2:
			if(valuey>0)
				valuey-=10;
			break;
		case 3:
			if(bb.getPreferredSize().height>ty+valuey-10)
				valuey+=10;
			break;
		}
		bb.setSize(bb.getPreferredSize());
		bb.repaint();
		arrow.repaint();
		repaint();
	}

	public void mouseReleased(MouseEvent e)
	{
	}
	public void mouseDragged(MouseEvent e)
	{
	}

	public void mouseMoved(MouseEvent e)
	{
		int x = e.getX();
		cp = (x-1)/35;
		arrow.repaint();
	}

	class Arrows extends Canvas
	{
		public Arrows()
		{
			arrows = new Image[4];
			try
			{
                            arrows[0]= getToolkit().getImage(new URL(getDocumentBase(),"../../common/images/applets/left.gif"));
                            arrows[1]= getToolkit().getImage(new URL(getDocumentBase(),"../../common/images/applets/right.gif"));
                            arrows[2]= getToolkit().getImage(new URL(getDocumentBase(),"../../common/images/applets/up.gif"));
                            arrows[3]= getToolkit().getImage(new URL(getDocumentBase(),"../../common/images/applets/down.gif"));
			} catch(MalformedURLException mue)
			{
				System.out.println("Exception MalformedURLException :" + mue.getMessage());
			}
		}

		public void paint(Graphics g)
		{
			if(cp == -1)
			{
				for(int i=0;i<4;i++)
					g.clearRect((0*35),0,35,10); 
			} else
			{
				for(int i=0;i<4;i++)
				{
					g.drawImage(arrows[cp],(cp*35),0,this);
				}
			}
		}
	}

	class base extends Canvas implements MouseListener,MouseMotionListener
	{
		int sep, level;
		Font f = new Font("Arial", Font.BOLD, 12);
		int xx,yy;
		Vector appoFather;

		public base(int xx, int yy,Applet parent)
		{
			super();
			this.parent = (Tree)parent;
			this.xx = xx;
			this.yy = yy;
			albero = new Vector();
			setLayout(new BorderLayout());
			setSize(new Dimension(xx,yy));
			addMouseListener(this);
			addMouseMotionListener(this);

			// Formattazione dati 
			Vector appoNodi = new Vector();
			try
			{
				URL url = new URL(getDocumentBase()  ,"../../loadTree?fillme=yes");
				URLConnection con = url.openConnection();
				con.setUseCaches(false);
				InputStream in = con.getInputStream();
				ObjectInputStream objStream = new ObjectInputStream(in);
				appoNodi = (Vector)objStream.readObject();
				objStream.close();
			} catch(MalformedURLException mue)
			{
				System.out.println("MalformedURLException: "+mue.getMessage());
			} catch(IOException ioe)
			{
				System.out.println("IOException: "+ioe.getMessage());
			} catch(ClassNotFoundException cnfe)
			{
				System.out.println("ClassNotFoundException: "+cnfe.getMessage());
			}
			setNodes(appoNodi);
		}

		public Dimension getPreferredSize()
		{
			int maxy = 0;
			int maxx = 0;
			for(int i=0;i<albero.size();i++)
			{
				ilNodo cn = (ilNodo)albero.elementAt(i);
				if(maxy<(cn.getYPos()+10))
					maxy = cn.getYPos()+10;
				if(cn.getOpen())
				{
					if(maxx>(cn.getXPos()))
					{
						maxx = cn.getXPos();
					}
				}
			}
			if(maxy<MAXIMAGE)
				maxy=MAXIMAGE;
			if(maxx<xx)
				maxx=xx;
			return new Dimension(maxx, maxy);
		}

		public void setNodes(Vector nodi)
		{
			this.nodi = nodi;
			dimy = 0;
			dimx = 0;
			int nf = 0;
			appoFather = new Vector();              
			String cs = "";
			FontMetrics currentMetrics = getFontMetrics(f);
			for(int v=0; v< nodi.size(); v++)
			{
				Vector cn = (Vector)nodi.elementAt(v);
				String csAppo = cn.elementAt(1).toString();
				if(!csAppo.equals(cs))
				{
					cs = csAppo;
					String level,code,code_figlio,label,link,frame;
					level = cn.elementAt(0).toString();
					code = cn.elementAt(1).toString();
					if(cn.elementAt(2) != null)
						code_figlio = cn.elementAt(2).toString();
					else
						code_figlio	= "";
					label = cn.elementAt(3).toString();
					if(code_figlio.equals(""))
						if(cn.elementAt(4) == null)
							link = code+".jsp";
						else
						{
							link = cn.elementAt(4).toString();
							if(link.equals(""))
								link = code+".jsp";
						} else
						link = "";
					if(cn.elementAt(5) != null)
						frame = cn.elementAt(5).toString();
					else
						frame = "MAIN";
					Vector figli = new Vector();
					for(int fi=0;fi<nodi.size();fi++)
					{
						Vector c2n = (Vector)nodi.elementAt(fi);
            int xf = ((Integer.parseInt(c2n.elementAt(0).toString())-1)*13)+
              currentMetrics.stringWidth(c2n.elementAt(3).toString());
            if(xf>dimx)
              dimx = xf;
						if(c2n.elementAt(1).toString().equals(code))
						{
							if(c2n.elementAt(2) != null)
								if(!c2n.elementAt(2).toString().equals(""))
								{
									figli.addElement(c2n.elementAt(2).toString());
								}
						}
					}
					albero.addElement(new ilNodo(
                         level,					// livello (1 = root)
												 code,					// code
												 code_figlio,		// code_figlio
												 figli,					// Puntamenti ai figli
												 label,				  // label
												 link,				  // link
												 frame));			  // frame

					boolean addF = false;
					if(level.equals("1"))
					{
						for(int f=0;f<appoFather.size();f++)
						{
							if(code.equals(appoFather.elementAt(f)))
								addF = true;
						}
						if(!addF)
						{
							appoFather.addElement(code);
							nf++;
						}
					}
				}
			}
			if(dimx<xx)
				dimx=xx;
			try
			{

                            img = getToolkit().getImage(new URL(getDocumentBase(),"../../common/images/applets/bg.gif"));
                            bglabel = getToolkit().getImage(new URL(getDocumentBase(),"../../common/images/applets/bglabel.gif"));
			
                        } catch(MalformedURLException mue)
			{
				System.out.println("Exception MalformedURLException :" + mue.getMessage());
			}

			// Calcolo della dimensione massima dell'albero con tutti i nodi aperti
			dimy = 4+(20*nf)+(15*(albero.size()-nf));
			if(dimy<MAXIMAGE)
				dimy = MAXIMAGE;
			offscreen = parent.createImage(dimx+30,dimy);
			bufferGraphics = offscreen.getGraphics();
			repaint();
		}

		public void update(Graphics g)
		{
			paint(g);
		} 

		public void paint(Graphics g)
		{
			bufferGraphics.clearRect(0,0,dimx+30,dimy); 
			//setBackground(new Color(214,223,247));
      bufferGraphics.setColor(new Color(214,223,247));
      bufferGraphics.fillRect(0,0,dimx+30,dimy);
			bufferGraphics.drawImage(img,(dimx-122),0,this);
			sep = 0;
			int sp = dimx-122+9;
			for(int y=0;y<albero.size();y++)
			{
				ilNodo cn = (ilNodo)albero.elementAt(y);
				if(cn.getFather())
				{
					int cr[] = {214,223,247};
					int cl[] = {214,223,247};
					bufferGraphics.drawImage(bglabel,sp-24,4+sep,this);
					bufferGraphics.setColor(Color.black);
					if(cn.getOpen()) {
						if (!cn.getLink().equals(""))
							bufferGraphics.setColor(Color.blue);
					}
					bufferGraphics.setFont(f);
					FontMetrics currentMetrics = getFontMetrics(f);
					int fl = currentMetrics.stringWidth(cn.getLabel());
					changeStatusNodo(cn.getCode(),115+(sp-5)-fl,16+sep);
					bufferGraphics.drawString(cn.getLabel(),115+(sp-5)-fl,16+sep);
					sep+=20;
					if(cn.getOpen()) {
						if (cn.getLink().equals("")) {
							sep-=5;
							level = 2;
							drawSons(cn,16+sep-10);
						}
					}
				}
			}
			g.drawImage(offscreen, -valuex, -valuey, this);
			if(firstTime)
			{
				firstTime = false;
				Dimension ns = getPreferredSize();
				setSize(ns);
			}
		}

		public void drawSons(ilNodo curN,int dy)
		{
			boolean opened = false;
			int dsep = 15+dimx-122;
			int fm = 10;
			Vector elencoFigli = curN.getSons();
			for(int fq=0;fq<elencoFigli.size();fq++)
			{
				String cf = elencoFigli.elementAt(fq).toString();
				for(int i=0;i<albero.size();i++)
				{
					ilNodo cf2 = (ilNodo)albero.elementAt(i);
					if(cf2.getCode().equals(cf))
					{
						bufferGraphics.setFont(f);
						FontMetrics currentSmallMetrics = getFontMetrics(f);
						int sfl = currentSmallMetrics.stringWidth(cf2.getLabel());
						changeStatusNodo(cf2.getCode(),115+(dsep-level*fm)-sfl,15+sep);
						if( (!cf2.getLink().equals("") && cf2.getOpen()) || (i == lastOpened) )
							bufferGraphics.setColor(Color.blue);
						bufferGraphics.drawString(cf2.getLabel(),115+(dsep-level*fm)-sfl,15+sep);
						bufferGraphics.setColor(Color.black);
						bufferGraphics.drawLine(115+(dsep-level*fm)+2,15+sep-3,120+(dsep-level*fm),15+sep-3);
						bufferGraphics.drawLine(120+(dsep-level*fm),15+sep-3,120+(dsep-level*fm),dy);
						sep+=14;
						level ++;
						if(cf2.getOpen())
							drawSons(cf2,15+sep-8);
						level--;
						opened = true;
					}
				}
			}
			if(opened)
			sep+=2;
		}

		public ilNodo getLastNode(String cc)
		{
			ilNodo serachNode = null;
			for(int i=0; i < albero.size(); i++)
			{
				serachNode = (ilNodo)albero.elementAt(i);
				if(serachNode.getCode().equals(cc))
					break;
			}
			return serachNode;
		}

		public void changeStatusNodo(String nome, int newX, int newY)
		{
			for(int i=0; i < albero.size(); i++)
			{
				ilNodo cn = (ilNodo)albero.elementAt(i);
				if(cn.getCode().equals(nome))
				{
					cn.setXPos(newX);
					cn.setYPos(newY);
					break;
				}
			}
		}

		public void openLink(ilNodo nn)
		{
			String link = nn.getLink().trim();
			String frame = nn.getFrame().trim();
			try
			{
				getAppletContext().showDocument(new URL(getCodeBase(),link), frame);
			} catch(java.net.MalformedURLException ue)
			{
			}
		}

		public void mouseClicked(MouseEvent e)
		{
		}

		public void closeNode(ilNodo iln)
		{
			iln.setXPos(-100);
			iln.setYPos(-100);
			if(iln.getOpen() && (iln.getLink().equals(""))) 
			{
				Vector nodiFigli = iln.getSons();
				for(int y=0;y<nodiFigli.size();y++)
				{
					String fig = nodiFigli.elementAt(y).toString();
					for(int a=0;a<albero.size();a++)
					{
						ilNodo on = (ilNodo)albero.elementAt(a);
						if(on.getCode().equals(fig))
							closeNode(on);
					}
				}
			}
			iln.setOpen(false);
		}


		public void mouseEntered(MouseEvent e)
		{
		}
		public void mouseExited(MouseEvent e)
		{
		}
		public void mousePressed(MouseEvent e) {
			int x = e.getX()+valuex;
			int y = e.getY()+valuey;
			for(int i=0;i<albero.size();i++) {
				ilNodo nn = (ilNodo)albero.elementAt(i);
				if(x>=nn.getXPos() && y<=nn.getYPos() && y>= (nn.getYPos()-10)) {
					
          			if (!nn.getLink().trim().equals("")) {
			            if(!nn.getOpen())
	    					nn.setOpen(true);
						String ll = nn.getLink().trim();
						if(!ll.equals("")) {
							openLink(nn);
							lastOpened = i;
						}
						// Chiudo tutti i nodi tranne quello aperto
						for(int a=0;a<albero.size();a++) {
							ilNodo in = (ilNodo)albero.elementAt(a);
							if (!in.getLink().trim().equals("") && (a!=i))
								in.setOpen(false);
						}
					}
          			else {
            			if (nn.getOpen())
              				closeNode(nn);
            			else {
						
							// ^ cerco i padri
							String mioP = nn.getCode();
							Vector pef = new Vector();
							pef.addElement(nn.getCode());
							for (int p=albero.size()-1;p>=0;p--) {
								ilNodo fn = (ilNodo)albero.elementAt(p);
								for (int cf = 0;cf<fn.getSons().size();cf++) {
									String crf = fn.getSons().elementAt(cf).toString();
									if (mioP.equals(crf)) {
										pef.addElement(fn.getCode());
										mioP = fn.getCode();
										break;
									}
								}
							}
							Vector figli = nn.getSons();
							for (int h=0; h<figli.size();h++)
								pef.addElement(figli.elementAt(h));
							// Chiudo tutti i nodi tranne quelli del ramo clicckato
							boolean canclose;
							for (int ch = 0; ch<albero.size();ch++) {
								canclose = true;
								ilNodo cn = (ilNodo)albero.elementAt(ch);
								for (int tn=0;tn<pef.size();tn++) {
									if (cn.getCode().equals(pef.elementAt(tn).toString())) {
										canclose = false;
									}
								}
								if (canclose)
									closeNode(cn);
							}
							nn.setOpen(true);
						}
          			}
				}
			}
			repaint();
		}          

		public void mouseReleased(MouseEvent e)
		{
			Dimension ns = getPreferredSize();
			setSize(ns);
			if(ns.height<ty)
				valuey=0;
			repaint();
		} 

		public void mouseDragged(MouseEvent e)
		{
		}

		public void mouseMoved(MouseEvent e)
		{
			int x = e.getX()+valuex;
			int y = e.getY()+valuey;
			for(int i=0;i<albero.size();i++)
			{
				ilNodo nn = (ilNodo)albero.elementAt(i);
				if(x>=nn.getXPos() && y<=nn.getYPos() && y>= (nn.getYPos()-10))
				{
					setCursor(Cursor.getPredefinedCursor(12));
					break;
				} else
					setCursor(Cursor.getPredefinedCursor(Cursor.DEFAULT_CURSOR));
			}
		}

		private Vector albero;
		private Vector nodi;
		private int lastOpened = -1;
		private Tree parent;
		private Graphics bufferGraphics;
		private Image offscreen,img,bglabel;
		private boolean firstTime = true;
		private Panel menu;
		private final int MAXIMAGE = 342;
	}

	class ilNodo
	{
		public ilNodo(String level, String code, String code_rif, 
					  Vector sons, String label, 
					  String link, String frame)
		{
			this.level = level;
			this.code = code;
			this.code_rif = code_rif;
			this.label = label;
			this.xPos = 0;
			this.yPos = 0;
			this.isOpen = false;
			if(level.equals("1"))
				this.isFather = true;
			else
				this.isFather = false;
			this.link = link;
			this.frame = frame;
			this.sons = sons;
		}

		public Vector getSons()
		{
			return sons;
		}
		public String getCode()
		{
			return code;
		}
		public String getCodeRif()
		{
			return code_rif;
		}
		public String getLabel()
		{
			return label;
		}
		public void setXPos(int newX)
		{
			this.xPos = newX;
		}
		public void setYPos(int newY)
		{
			this.yPos = newY;
		}
		public int getYPos()
		{
			return yPos;
		}
		public int getXPos()
		{
			return xPos;
		}
		public void setOpen(boolean isOpened)
		{
			this.isOpen = isOpened;
		}
		public boolean getOpen()
		{
			return isOpen;
		}
		public boolean getFather()
		{
			return isFather;
		}
		public String getLink()
		{
			return link;
		}
		public String getFrame()
		{
			return frame;
		}
		String level,code, code_rif;
		String label, link, frame;
		int xPos, yPos;
		boolean isOpen, isFather;
		Vector sons;
	}
}