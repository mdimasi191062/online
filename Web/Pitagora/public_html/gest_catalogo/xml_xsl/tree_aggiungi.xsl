<xsl:stylesheet xmlns:xsl="http://www.w3.org/TR/WD-xsl" language="JavaScript">
<LINK REL="stylesheet" TYPE="text/css" HREF="../../css/tree.css" />
<xsl:template match="tree">
  <xsl:apply-templates select="entity"/>
</xsl:template>

<xsl:template match="entity">

<div onclick="window.event.cancelBubble = true;clickOnEntity(this);" onselectstart="return false" ondragstart="return false">

  <xsl:attribute name="image"><xsl:value-of select="image"/></xsl:attribute>
  <xsl:attribute name="imageOpen"><xsl:value-of select="imageOpen"/></xsl:attribute>
  <xsl:attribute name="open">false</xsl:attribute>
  <xsl:attribute name="Id"><xsl:value-of select="@Id"/></xsl:attribute>
  <xsl:attribute name="Tipo"><xsl:value-of select="@Tipo"/></xsl:attribute>
  <xsl:attribute name="alt"><xsl:value-of select="Description"/></xsl:attribute>
  <xsl:attribute name="title"><xsl:value-of select="Description"/></xsl:attribute>
  <xsl:attribute name="STYLE">
    padding-left: 20px;
    cursor: hand;
    <xsl:if expr="depth(this) > 2">
      display: none;
    </xsl:if>
  </xsl:attribute>

    <table border="0" cellspacing="0" cellpadding="0">
      <tr ONMOUSEOVER="swapTR(this, 'trOver')" 
          ONMOUSEOUT="swapTR(this, 'trOut')" selezionato="" onclick="selected(this, 'selected');">
        <td id="Id" name="Id" valign="middle" class="trOut">
            <xsl:choose>
    	        <xsl:when match=".[@Tipo!='']">
                <input type="checkbox" value="Y">
                  <xsl:attribute name="name">
                  <xsl:value-of select="@Id"/></xsl:attribute>
                </input>
              </xsl:when>
              <xsl:otherwise>
              </xsl:otherwise>
    	     </xsl:choose>
          <img border="0" id="image">
            <xsl:attribute name="alt">
            <xsl:value-of select="Description"/></xsl:attribute>
            <xsl:attribute name="SRC">
            <xsl:value-of select="image"/></xsl:attribute>
          </img>
        </td>
        <td align="middle" nowrap="true">
        <xsl:attribute name="STYLE">
           padding-top: 4px;
      	   padding-left: 7px;
           padding-bottom: 4px;
           padding-right: 7px;
           font-family: Verdana;
           font-size: 11px;
        </xsl:attribute>
         <xsl:choose>
                <xsl:when match=".[statoElemento='S']">
                  <xsl:attribute name="style">
                    color:black;
                  </xsl:attribute>
                  <xsl:value-of select="Description"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:attribute name="style">
                    color:red;
                  </xsl:attribute>
                  <xsl:value-of select="Description"/>
                </xsl:otherwise>
          </xsl:choose>
	</td>
 </tr>
</table>
<xsl:apply-templates select="contents/entity"/>
</div>
</xsl:template>
</xsl:stylesheet>
