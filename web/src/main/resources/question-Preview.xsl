<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" indent="yes"></xsl:output>
    <xsl:template match="/root">
        <xsl:value-of select="question"/>
    </xsl:template>
</xsl:stylesheet>