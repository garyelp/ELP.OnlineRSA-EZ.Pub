<!--
 Copyright (c) 2010  Dave Reid <http://drupal.org/user/53892>

     This file is free software: you may copy, redistribute and/or modify it
     under the terms of the GNU General Public License as published by the
     Free Software Foundation, either version 2 of the License, or (at your
     option) any later version.

     This file is distributed in the hope that it will be useful, but
     WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
     General Public License for more details.

     You should have received a copy of the GNU General Public License
     along with this program.  If not, see <http://www.gnu.org/licenses/>.

     This file incorporates work covered by the following copyright and
     permission notice:

     Google Sitmaps Stylesheets (GSStylesheets)
     Project Home: http://sourceforge.net/projects/gstoolbox
     Copyright (c) 2005 Baccou Bonneville SARL (http://www.baccoubonneville.com)
     License http://www.gnu.org/copyleft/lesser.html GNU/LGPL 
-->
<xsl:stylesheet xmlns:html="http://www.w3.org/TR/REC-html40" xmlns:sitemap="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
<xsl:output method="html" version="1.0" encoding="utf-8" indent="yes"/>
<!--  Root template  -->
<xsl:template match="/">
<html>
<head>
<title>Sitemap file</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"/>
<script type="text/javascript" src="../../extension/ptw_sitetweaks/design/xmlsitemap/javascripts/jquery.tablesorter.min.js"/>
<script type="text/javascript" src="../../extension/ptw_sitetweaks/design/xmlsitemap/javascripts/xmlsitemap.xsl.js"/>
<link href="../../extension/ptw_sitetweaks/design/xmlsitemap/stylesheets/xml-sitemap.xsl.css" type="text/css" rel="stylesheet"/>
</head>
<!--
 Store in $fileType if we are in a sitemap or in a siteindex  
-->
<xsl:variable name="fileType">
<xsl:choose>
<xsl:when test="//sitemap:url">sitemap</xsl:when>
<xsl:otherwise>siteindex</xsl:otherwise>
</xsl:choose>
</xsl:variable>
<body>
<h1>Sitemap file</h1>
<xsl:choose>
<xsl:when test="$fileType='sitemap'">
<xsl:call-template name="sitemapTable"/>
</xsl:when>
<xsl:otherwise>
<xsl:call-template name="siteindexTable"/>
</xsl:otherwise>
</xsl:choose>
<div id="footer">
</div>
</body>
</html>
</xsl:template>
<!--  siteindexTable template  -->
<xsl:template name="siteindexTable">
<div id="information">
<p>
Number of sitemaps in this index:
<xsl:value-of select="count(sitemap:sitemapindex/sitemap:sitemap)"/>
</p>
</div>
<table class="tablesorter siteindex">
<thead>
<tr>
<th>Sitemap URL</th>
<th>Last modification date</th>
</tr>
</thead>
<tbody>
<xsl:apply-templates select="sitemap:sitemapindex/sitemap:sitemap">
<xsl:sort select="sitemap:lastmod" order="descending"/>
</xsl:apply-templates>
</tbody>
</table>
</xsl:template>
<!--  sitemapTable template  -->
<xsl:template name="sitemapTable">
<div id="information">
<p>
Number of URLs in this sitemap:
<xsl:value-of select="count(sitemap:urlset/sitemap:url)"/>
</p>
</div>
<table class="tablesorter sitemap">
<thead>
<tr>
<th>URL location</th>
<th>Last modification date</th>
<th>Change frequency</th>
<th>Priority</th>
</tr>
</thead>
<tbody>
<xsl:apply-templates select="sitemap:urlset/sitemap:url">
<xsl:sort select="sitemap:priority" order="descending"/>
</xsl:apply-templates>
</tbody>
</table>
</xsl:template>
<!--  sitemap:url template  -->
<xsl:template match="sitemap:url">
<tr>
<td>
<xsl:variable name="sitemapURL">
<xsl:value-of select="sitemap:loc"/>
</xsl:variable>
<a href="{$sitemapURL}" ref="nofollow" target="_blank">
<xsl:value-of select="$sitemapURL"/>
</a>
</td>
<td>
<xsl:value-of select="sitemap:lastmod"/>
</td>
<td>
<xsl:value-of select="sitemap:changefreq"/>
</td>
<td>
<xsl:choose>
<!--
 If priority is not defined, show the default value of 0.5 
-->
<xsl:when test="sitemap:priority">
<xsl:value-of select="sitemap:priority"/>
</xsl:when>
<xsl:otherwise>0.5</xsl:otherwise>
</xsl:choose>
</td>
</tr>
</xsl:template>
<!--  sitemap:sitemap template  -->
<xsl:template match="sitemap:sitemap">
<tr>
<td>
<xsl:variable name="sitemapURL">
<xsl:value-of select="sitemap:loc"/>
</xsl:variable>
<a href="{$sitemapURL}" target="_blank">
<xsl:value-of select="$sitemapURL"/>
</a>
</td>
<td>
<xsl:value-of select="sitemap:lastmod"/>
</td>
</tr>
</xsl:template>
</xsl:stylesheet>
