<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
<xsl:output method="xml" version="1.0" indent="yes"/>
<xsl:template match="/">
	<fo:root>
	
		<fo:layout-master-set>
			<fo:simple-page-master page-height="297mm" page-width="210mm" margin="5mm 25mm 5mm 25mm" master-name="template">
				<fo:region-body margin="20mm 0mm 20mm 0mm"/>
			</fo:simple-page-master>
		</fo:layout-master-set>
		
<!--===========================Title===============================-->
		
		<fo:page-sequence master-reference="template">
			<fo:flow flow-name="xsl-region-body">
				<fo:block position ="absolute" text-align ="center" font-weight="bold" margin-bottom="50mm"
					font-family="Calibri" font-size="48pt" padding-before="50mm" color="black">
					Museums catalogue
				</fo:block>
			</fo:flow>
		</fo:page-sequence>

<!--===========================WebDesigns===============================-->
        <xsl:for-each select="//museum">
			<xsl:variable name="museumID" select="@id"/>
			<xsl:variable name="museumRegion" select="@region"/>
        	<fo:page-sequence master-reference="template">
			<fo:flow flow-name="xsl-region-body">
				<fo:block-container position="absolute" top="-2.5cm" left="-2.5cm">
					<fo:block position="absolute" text-align="center" padding-before="2cm" margin-left="2.5cm"
								font-family="Calibri" font-size="18pt" color="black">
						<xsl:value-of select="name"/>
					</fo:block>
					<fo:block position="absolute" text-align="center" padding-before="7mm" margin-left="2.5cm">
					   <fo:external-graphic src="{unparsed-entity-uri(image/@src)}" width="1.92in" height="1.13in"
     					content-width="scale-to-fit" content-height="scale-to-fit"/>
					</fo:block>
					<fo:block position="relative" font-family="Calibri" font-weight="bold" font-size="13pt" color="black" 
					padding-before="5mm" margin-left="2cm">
						Описание:
						<fo:inline position="relative" padding-left="32mm" font-weight="normal" font-size="12pt">
							<xsl:value-of select="description"/> 
						</fo:inline>
					</fo:block> 
					
					<fo:block position="relative" font-family="Calibri" font-weight="bold" font-size="13pt" color="black" 
					padding-before="5mm" margin-left="2cm">
						Часове за посещение:
						<fo:inline position="relative" padding-left="10mm" font-weight="normal" font-size="12pt">
							<xsl:value-of select="visiting_hours"/> 
						</fo:inline>
					</fo:block>

					<fo:block position="relative" font-family="Calibri" font-weight="bold" font-size="13pt" color="black" 
					padding-before="5mm" margin-left="2cm">
						Адрес:
						<fo:inline position="relative" padding-left="10mm" font-weight="normal" font-size="12pt">
							<xsl:value-of select="address"/> 
						</fo:inline>
					</fo:block>
						<fo:block position="relative" font-family="Arial" font-weight="bold" font-size="15pt" color="black" padding-before="0mm" margin-left="2cm">
							Билети:
						</fo:block>
						<fo:block position="relative" font-family="Arial"  font-size="12pt" color="black" start-indent ="5mm" padding-before="5mm" margin-left="2.5cm">
							<xsl:apply-templates select="ticket_options"/> 
						</fo:block>
				</fo:block-container>
			</fo:flow>
		</fo:page-sequence>
		</xsl:for-each>
	</fo:root>
</xsl:template>

	<xsl:template match="ticket_options">
		<xsl:for-each select="./ticket">
			<xsl:choose>
				<xsl:when test="@type = 'noDescription'">
					<fo:block position="relative">
						<fo:inline position="relative" font-family="Arial"  font-size="10pt" color="black" start-indent ="2mm" padding-before="3mm"  font-weight="normal" margin-left="0.2cm">
							* <xsl:value-of select="text()"/>
						</fo:inline>
					</fo:block>
				</xsl:when>
				<xsl:otherwise>
					<fo:block position="relative">
						<fo:inline position="relative" font-family="Arial"  font-size="12pt" color="black" start-indent ="2mm" padding-before="3mm"  font-weight="bold" margin-left="0.2cm">
							<xsl:value-of select="text()"/>:
						</fo:inline>
						<xsl:for-each select="./type">
							<fo:inline position="relative" font-family="Arial"  font-size="10pt" color="black" start-indent ="2mm" padding-before="0mm" margin-left="2mm">
								<xsl:value-of select="text()"/>
							</fo:inline>
						</xsl:for-each>
					</fo:block>
					<xsl:for-each select="./price">
						<fo:block position="relative" font-family="Arial"  font-size="10pt" color="black" start-indent ="2mm" padding-before="0mm" margin-left="0.5cm">
							* <xsl:value-of select="text()"/>
						</fo:block>
					</xsl:for-each>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="src">
		<fo:external-graphic src="{unparsed-entity-uri(@href)}" content-height="250" content-width="150"/>
	</xsl:template>

</xsl:stylesheet>
