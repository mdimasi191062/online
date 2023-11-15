package com.utl;
import org.jdom.Element;

public class Entity extends Element{
  private String Description;
  private String url;
  private String image;
  private String imageOpen;
  private String contents;
  private String idItem;
  private String Tipo;
  private Element content;
  private Element elemImage;
  private Element elemImageOpen;
  private String statoElemento;
  
  public Entity(String idItem, String Description, String url, String image, String imageOpen, String statoElemento) {
      super("entity");
      this.idItem = idItem;
      this.Description = Description;
      this.url = url;
      this.image = image;
      this.imageOpen = imageOpen;
      this.contents = contents;
      this.statoElemento = statoElemento;

      elemImage     = new Element("image");
      elemImageOpen = new Element("imageOpen");

      setAttribute("Id",idItem); 
      addContent(new Element("Description").addContent(Description));
      addContent(new Element("url").addContent(url));
      addContent(new Element("statoElemento").addContent(statoElemento));
      addContent(elemImage.addContent(image));
      addContent(elemImageOpen.addContent(imageOpen));
      content=new Element("contents");
      addContent(content);
  }

  public Entity(String idItem, String Description, String url, String image, String imageOpen,String Tipo,String statoElemento) {
      super("entity");
      this.idItem = idItem;
      this.Description = Description;
      this.url = url;
      this.image = image;
      this.imageOpen = imageOpen;
      this.contents = contents;
      this.statoElemento = statoElemento;

      elemImage     = new Element("image");
      elemImageOpen = new Element("imageOpen");

      setAttribute("Id",idItem); 
      setAttribute("Tipo",Tipo);
      addContent(new Element("Description").addContent(Description));
      addContent(new Element("url").addContent(url));
      addContent(new Element("statoElemento").addContent(statoElemento));      
      addContent(elemImage.addContent(image));
      addContent(elemImageOpen.addContent(imageOpen));
      content=new Element("contents");
      addContent(content);
  }


  public Entity copia (String idItem)  {
   return ( new Entity (idItem,this.Description,this.url,this.image,this.imageOpen,this.statoElemento) );
  }
  
   public void addContents(Entity ent) {
      content.addContent(ent);
   }

   public void setImage(String image) {
     this.image = image;
     elemImage.setText(image);
//      content.addContent(ent);
   }

   public void setImageSel( String imageSel) {
        this.image = imageSel;
        elemImageOpen.setText(imageSel);
//      content.addContent(ent);
   }
   
}
