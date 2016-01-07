<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" indent="yes"></xsl:output>
    <xsl:param name="questionNumber" />
    <xsl:param name="renderType" />
    <xsl:param name="type" />
    <xsl:param name="griddableType"/>
    <xsl:param name="writeOnLines" />

    <xsl:variable name="rowNumberOE">
         <xsl:choose>
             <xsl:when test="$writeOnLines > 0">
                 <xsl:value-of select="$writeOnLines"/>
             </xsl:when>
             <xsl:otherwise>
                 <xsl:value-of select="3"/>
             </xsl:otherwise>
         </xsl:choose>
     </xsl:variable>
     <xsl:variable name="rowNumberES">
         <xsl:choose>
             <xsl:when test="$writeOnLines > 0">
                 <xsl:value-of select="$writeOnLines"/>
             </xsl:when>
             <xsl:otherwise>
                 <xsl:value-of select="10"/>
             </xsl:otherwise>
         </xsl:choose>
     </xsl:variable>
     <xsl:variable name="rowNumberDR">
         <xsl:choose>
             <xsl:when test="$writeOnLines > 0">
                 <xsl:value-of select="$writeOnLines"/>
             </xsl:when>
             <xsl:otherwise>
                 <xsl:value-of select="10"/>
             </xsl:otherwise>
         </xsl:choose>
     </xsl:variable>
    <xsl:variable name="directionText">
        <xsl:value-of select="'Directions'"/>
    </xsl:variable>
    <xsl:variable name="answerText">
         <xsl:value-of select="'Answer'"/>
    </xsl:variable>

    <xsl:template name="GR_2_Column">

      <xsl:param name="count" select="-1"/>
      <xsl:param name="questionNumber"/>
      <xsl:if test="$count &lt; 10">
          <xsl:choose>
              <xsl:when test="$count = -1">
                <tr>
                    <td id="l_a{$questionNumber}_0">&amp;nbsp;</td>
                    <td id="l_a{$questionNumber}_1">&amp;nbsp;</td>
                </tr>
              </xsl:when>
              <xsl:otherwise>
                  <tr>
                    <td class="cell_{$questionNumber}_0"><input type="radio" name="a{$questionNumber}_0" onchange="updateGRSelectedValue(this)" value="{$count}" class="{{src:'/sc-content/images/grid/{$count}.png',checked:'/sc-content/images/grid/{$count}_checked.png',hover:'/sc-content/images/grid/{$count}.png'}}"/></td>
                    <td class="cell_{$questionNumber}_1"><input type="radio" name="a{$questionNumber}_1" onchange="updateGRSelectedValue(this)" value="{$count}" class="{{src:'/sc-content/images/grid/{$count}.png',checked:'/sc-content/images/grid/{$count}_checked.png',hover:'/sc-content/images/grid/{$count}.png'}}"/></td>
                  </tr>
              </xsl:otherwise>
          </xsl:choose>
        <xsl:call-template name="GR_2_Column">
          <xsl:with-param name="count" select="$count + 1"/>
          <xsl:with-param name="questionNumber" select="$questionNumber"/>
        </xsl:call-template>
      </xsl:if>

    </xsl:template>

    <xsl:template name="GR_4_Column">

      <xsl:param name="count" select="-1"/>
      <xsl:param name="questionNumber"/>
      <xsl:if test="$count &lt; 10">
          <xsl:choose>
              <xsl:when test="$count = -1">
                <tr>
                    <td id="l_a{$questionNumber}_0">&amp;nbsp;</td>
                    <td id="l_a{$questionNumber}_1">&amp;nbsp;</td>
                    <td id="l_a{$questionNumber}_2">&amp;nbsp;</td>
                    <td id="l_a{$questionNumber}_3">.</td>
                </tr>
              </xsl:when>
              <xsl:otherwise>
                  <tr>
                      <td class="cell_{$questionNumber}_0"><input type="radio" name="a{$questionNumber}_0" onchange="updateGRSelectedValue(this)" value="{$count}" class="{{src:'/sc-content/images/grid/{$count}.png',checked:'/sc-content/images/grid/{$count}_checked.png',hover:'/sc-content/images/grid/{$count}.png'}}"/></td>
                      <td class="cell_{$questionNumber}_1"><input type="radio" name="a{$questionNumber}_1" onchange="updateGRSelectedValue(this)" value="{$count}" class="{{src:'/sc-content/images/grid/{$count}.png',checked:'/sc-content/images/grid/{$count}_checked.png',hover:'/sc-content/images/grid/{$count}.png'}}"/></td>
                      <td class="cell_{$questionNumber}_2"><input type="radio" name="a{$questionNumber}_2" onchange="updateGRSelectedValue(this)" value="{$count}" class="{{src:'/sc-content/images/grid/{$count}.png',checked:'/sc-content/images/grid/{$count}_checked.png',hover:'/sc-content/images/grid/{$count}.png'}}"/></td>
                      <td>&amp;nbsp;</td>
                  </tr>
              </xsl:otherwise>
          </xsl:choose>
        <xsl:call-template name="GR_4_Column">
          <xsl:with-param name="count" select="$count + 1"/>
          <xsl:with-param name="questionNumber" select="$questionNumber"/>
        </xsl:call-template>
      </xsl:if>

    </xsl:template>

    <xsl:template name="GR_7_Column">

      <xsl:param name="count" select="-1"/>
      <xsl:param name="questionNumber"/>

      <xsl:if test="$count &lt; 10">
          <xsl:choose>
              <xsl:when test="$count = -1">
                <tr>
                    <td id="l_a{$questionNumber}_0">&amp;nbsp;</td>
                    <td id="l_a{$questionNumber}_1">&amp;nbsp;</td>
                    <td id="l_a{$questionNumber}_2">&amp;nbsp;</td>
                    <td id="l_a{$questionNumber}_3">&amp;nbsp;</td>
                    <td id="l_a{$questionNumber}_4">.</td>
                    <td id="l_a{$questionNumber}_5">&amp;nbsp;</td>
                    <td id="l_a{$questionNumber}_6">&amp;nbsp;</td>
                </tr>
              </xsl:when>
              <xsl:otherwise>
                <tr>
                  <td class="cell_{$questionNumber}_0"><input type="radio" name="a{$questionNumber}_0" onchange="updateGRSelectedValue(this)" value="{$count}" class="{{src:'/sc-content/images/grid/{$count}.png',checked:'/sc-content/images/grid/{$count}_checked.png',hover:'/sc-content/images/grid/{$count}.png'}}"/></td>
                  <td class="cell_{$questionNumber}_1"><input type="radio" name="a{$questionNumber}_1" onchange="updateGRSelectedValue(this)" value="{$count}" class="{{src:'/sc-content/images/grid/{$count}.png',checked:'/sc-content/images/grid/{$count}_checked.png',hover:'/sc-content/images/grid/{$count}.png'}}"/></td>
                  <td class="cell_{$questionNumber}_2"><input type="radio" name="a{$questionNumber}_2" onchange="updateGRSelectedValue(this)" value="{$count}" class="{{src:'/sc-content/images/grid/{$count}.png',checked:'/sc-content/images/grid/{$count}_checked.png',hover:'/sc-content/images/grid/{$count}.png'}}"/></td>
                  <td class="cell_{$questionNumber}_3"><input type="radio" name="a{$questionNumber}_3" onchange="updateGRSelectedValue(this)" value="{$count}" class="{{src:'/sc-content/images/grid/{$count}.png',checked:'/sc-content/images/grid/{$count}_checked.png',hover:'/sc-content/images/grid/{$count}.png'}}"/></td>
                  <td>&amp;nbsp;</td>
                  <td class="cell_{$questionNumber}_5"><input type="radio" name="a{$questionNumber}_5" onchange="updateGRSelectedValue(this)" value="{$count}" class="{{src:'/sc-content/images/grid/{$count}.png',checked:'/sc-content/images/grid/{$count}_checked.png',hover:'/sc-content/images/grid/{$count}.png'}}"/></td>
                  <td class="cell_{$questionNumber}_6"><input type="radio" name="a{$questionNumber}_6" onchange="updateGRSelectedValue(this)" value="{$count}" class="{{src:'/sc-content/images/grid/{$count}.png',checked:'/sc-content/images/grid/{$count}_checked.png',hover:'/sc-content/images/grid/{$count}.png'}}"/></td>
              </tr>
              </xsl:otherwise>
          </xsl:choose>

        <xsl:call-template name="GR_7_Column">
          <xsl:with-param name="count" select="$count + 1"/>
          <xsl:with-param name="questionNumber" select="$questionNumber"/>
        </xsl:call-template>
      </xsl:if>

    </xsl:template>

    <xsl:template name="GR_8_Column">

      <xsl:param name="count" select="-2"/>
      <xsl:param name="questionNumber"/>
      <xsl:if test="$count &lt; 10">
          <xsl:choose>
              <xsl:when test="$count = -2">
                <tr>
                    <td id="l_a{$questionNumber}_0">&amp;nbsp;</td>
                    <td id="l_a{$questionNumber}_1">&amp;nbsp;</td>
                    <td id="l_a{$questionNumber}_2">&amp;nbsp;</td>
                    <td id="l_a{$questionNumber}_3">&amp;nbsp;</td>
                    <td id="l_a{$questionNumber}_4">&amp;nbsp;</td>
                    <td id="l_a{$questionNumber}_5">&amp;nbsp;</td>
                    <td id="l_a{$questionNumber}_6">&amp;nbsp;</td>
                    <td id="l_a{$questionNumber}_7">&amp;nbsp;</td>
                </tr>
              </xsl:when>
              <xsl:otherwise>
                <tr>
                  <td class="cell_{$questionNumber}_0">
                      <xsl:choose>
                          <xsl:when test="$count = -1">
                              <input type="radio" name="a{$questionNumber}_0" onchange="updateGRSelectedValue(this)"  value="+" class="{{src:'/sc-content/images/grid/plus.png',checked:'/sc-content/images/grid/plus_checked.png',hover:'/sc-content/images/grid/plus.png'}}"/>
                          </xsl:when>
                          <xsl:when test="$count = 0">
                              <input type="radio" name="a{$questionNumber}_0" onchange="updateGRSelectedValue(this)" value="-" class="{{src:'/sc-content/images/grid/minus.png',checked:'/sc-content/images/grid/minus_checked.png',hover:'/sc-content/images/grid/minus.png'}}"/>
                          </xsl:when>
                          <xsl:otherwise>
                              &amp;nbsp;
                          </xsl:otherwise>
                      </xsl:choose>
                  </td>
                  <td class="cell_{$questionNumber}_1">
                      <xsl:choose>
                          <xsl:when test="$count = -1">
                            <input type="radio" name="a{$questionNumber}_1" onchange="updateGRSelectedValue(this)" value="." class="{{src:'/sc-content/images/grid/dot.png',checked:'/sc-content/images/grid/dot_checked.png',hover:'/sc-content/images/grid/dot.png'}}"/>
                          </xsl:when>
                          <xsl:otherwise>
                              <input type="radio" name="a{$questionNumber}_1" onchange="updateGRSelectedValue(this)" value="{$count}" class="{{src:'/sc-content/images/grid/{$count}.png',checked:'/sc-content/images/grid/{$count}_checked.png',hover:'/sc-content/images/grid/{$count}.png'}}"/>
                          </xsl:otherwise>
                      </xsl:choose>
                  </td>
                  <td class="cell_{$questionNumber}_2">
                      <xsl:choose>
                          <xsl:when test="$count = -1">
                            <input type="radio" name="a{$questionNumber}_2" onchange="updateGRSelectedValue(this)" value="." class="{{src:'/sc-content/images/grid/dot.png',checked:'/sc-content/images/grid/dot_checked.png',hover:'/sc-content/images/grid/dot.png'}}"/>
                          </xsl:when>
                          <xsl:otherwise>
                              <input type="radio" name="a{$questionNumber}_2" onchange="updateGRSelectedValue(this)" value="{$count}" class="{{src:'/sc-content/images/grid/{$count}.png',checked:'/sc-content/images/grid/{$count}_checked.png',hover:'/sc-content/images/grid/{$count}.png'}}"/>
                          </xsl:otherwise>
                      </xsl:choose>
                  </td>
                  <td class="cell_{$questionNumber}_3">
                      <xsl:choose>
                          <xsl:when test="$count = -1">
                            <input type="radio" name="a{$questionNumber}_3" onchange="updateGRSelectedValue(this)" value="." class="{{src:'/sc-content/images/grid/dot.png',checked:'/sc-content/images/grid/dot_checked.png',hover:'/sc-content/images/grid/dot.png'}}"/>
                          </xsl:when>
                          <xsl:otherwise>
                              <input type="radio" name="a{$questionNumber}_3" onchange="updateGRSelectedValue(this)" value="{$count}" class="{{src:'/sc-content/images/grid/{$count}.png',checked:'/sc-content/images/grid/{$count}_checked.png',hover:'/sc-content/images/grid/{$count}.png'}}"/>
                          </xsl:otherwise>
                      </xsl:choose>
                  </td>
                  <td class="cell_{$questionNumber}_4">
                      <xsl:choose>
                          <xsl:when test="$count = -1">
                            <input type="radio" name="a{$questionNumber}_4" onchange="updateGRSelectedValue(this)" value="." class="{{src:'/sc-content/images/grid/dot.png',checked:'/sc-content/images/grid/dot_checked.png',hover:'/sc-content/images/grid/dot.png'}}"/>
                          </xsl:when>
                          <xsl:otherwise>
                              <input type="radio" name="a{$questionNumber}_4" onchange="updateGRSelectedValue(this)" value="{$count}" class="{{src:'/sc-content/images/grid/{$count}.png',checked:'/sc-content/images/grid/{$count}_checked.png',hover:'/sc-content/images/grid/{$count}.png'}}"/>
                          </xsl:otherwise>
                      </xsl:choose>
                  </td>
                  <td class="cell_{$questionNumber}_5">
                      <xsl:choose>
                          <xsl:when test="$count = -1">
                            <input type="radio" name="a{$questionNumber}_5" onchange="updateGRSelectedValue(this)" value="." class="{{src:'/sc-content/images/grid/dot.png',checked:'/sc-content/images/grid/dot_checked.png',hover:'/sc-content/images/grid/dot.png'}}"/>
                          </xsl:when>
                          <xsl:otherwise>
                              <input type="radio" name="a{$questionNumber}_5" onchange="updateGRSelectedValue(this)" value="{$count}" class="{{src:'/sc-content/images/grid/{$count}.png',checked:'/sc-content/images/grid/{$count}_checked.png',hover:'/sc-content/images/grid/{$count}.png'}}"/>
                          </xsl:otherwise>
                      </xsl:choose>
                  </td>
                    <td class="cell_{$questionNumber}_6">
                      <xsl:choose>
                          <xsl:when test="$count = -1">
                            <input type="radio" name="a{$questionNumber}_6" onchange="updateGRSelectedValue(this)" value="." class="{{src:'/sc-content/images/grid/dot.png',checked:'/sc-content/images/grid/dot_checked.png',hover:'/sc-content/images/grid/dot.png'}}"/>
                          </xsl:when>
                          <xsl:otherwise>
                              <input type="radio" name="a{$questionNumber}_6" onchange="updateGRSelectedValue(this)" value="{$count}" class="{{src:'/sc-content/images/grid/{$count}.png',checked:'/sc-content/images/grid/{$count}_checked.png',hover:'/sc-content/images/grid/{$count}.png'}}"/>
                          </xsl:otherwise>
                      </xsl:choose>
                  </td>
                    <td class="cell_{$questionNumber}_7">
                      <xsl:choose>
                          <xsl:when test="$count = -1">
                            <input type="radio" name="a{$questionNumber}_7" onchange="updateGRSelectedValue(this)" value="." class="{{src:'/sc-content/images/grid/dot.png',checked:'/sc-content/images/grid/dot_checked.png',hover:'/sc-content/images/grid/dot.png'}}"/>
                          </xsl:when>
                          <xsl:otherwise>
                              <input type="radio" name="a{$questionNumber}_7" onchange="updateGRSelectedValue(this)" value="{$count}" class="{{src:'/sc-content/images/grid/{$count}.png',checked:'/sc-content/images/grid/{$count}_checked.png',hover:'/sc-content/images/grid/{$count}.png'}}"/>
                          </xsl:otherwise>
                      </xsl:choose>
                  </td>
              </tr>
              </xsl:otherwise>
          </xsl:choose>

        <xsl:call-template name="GR_8_Column">
          <xsl:with-param name="count" select="$count + 1"/>
          <xsl:with-param name="questionNumber" select="$questionNumber"/>
        </xsl:call-template>
      </xsl:if>

    </xsl:template>
    <xsl:template name="strip-p-tags">
        <xsl:param name="text"/>
        <xsl:choose>
            <xsl:when test="starts-with(normalize-space($text), '&lt;p')">
                <xsl:variable name="textTrim">
                    <xsl:value-of select="normalize-space($text)"/>
                </xsl:variable>
                <xsl:variable name="temp">
                    <xsl:value-of select="normalize-space(substring-after($textTrim, '&gt;'))"/>
                </xsl:variable>

                <xsl:variable name="res">
                    <xsl:choose>

                        <xsl:when test="starts-with(substring($temp, string-length($temp) - 3),'&lt;/p&gt;')">
                            <xsl:value-of select="normalize-space(substring($temp, 0,  string-length($temp) - 3))"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="normalize-space($temp)"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:choose>
                    <xsl:when test="starts-with(substring($res, string-length($res) - 3),'&lt;p')">
                        <xsl:value-of select="normalize-space(substring($res, 0, string-length($res) - 3))"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space($res)"/>
                    </xsl:otherwise>
                </xsl:choose>


            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$text"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="/root">
        <xsl:variable name="direction">
            <xsl:value-of select="/root/direction/text()"/>
          </xsl:variable>
          <xsl:if test="normalize-space($direction) != ''">
              <table border="0" width="100%" style="table-layout:fixed;">
                  <tr>
                    <td align="left">
                        <p><xsl:value-of select="$direction" disable-output-escaping="yes"/></p>
                    </td>
                  </tr>
              </table>
          </xsl:if>
        <table border="0" width="100%" style="table-layout:fixed;"  id="question_table_{$questionNumber}">


          <xsl:variable name="index_width">
              <xsl:choose>
                  <xsl:when test="$questionNumber > 9">
                      <xsl:value-of select="30"/>
                  </xsl:when>
                  <xsl:otherwise>
                      <xsl:value-of select="20"/>
                  </xsl:otherwise>
              </xsl:choose>
          </xsl:variable>

          <xsl:variable name="questionText">
                <xsl:value-of select="/root/question/text()"/>
          </xsl:variable>
          <xsl:variable name="hasQuestionText">
              <xsl:choose>
                  <xsl:when test="normalize-space($questionText) != ''">
                      <xsl:value-of select="1"/>
                  </xsl:when>
                  <xsl:otherwise>
                      <xsl:value-of select="0"/>
                  </xsl:otherwise>
              </xsl:choose>

          </xsl:variable>

          <xsl:if test="normalize-space($questionText) != ''">
              <tr>
                <td class="question_number"><xsl:value-of select="$questionNumber"/>.</td>
                <td><xsl:value-of select="$questionText" disable-output-escaping="yes"/></td>

              </tr>
          </xsl:if>

          <xsl:choose>
            <!-- Multiple choice type -->
            <xsl:when test="$type = 'MC'">
                <xsl:choose>
                    <xsl:when test="$renderType = 'vertical'">
                        <tr>
                            <td>&amp;nbsp;</td>
                            <td>
                                <table class="mc_question_table vertical">
                                    <xsl:variable name="showOptionLabel">
                                        <xsl:value-of select="/root/showOptionLabel/text()"/>
                                    </xsl:variable>
                                    <xsl:for-each select="answers/ans">
                                        <xsl:variable name="index">
                                            <xsl:value-of select="position()"/>
                                        </xsl:variable>
                                        <xsl:variable name="label" select='substring("abcdefghijklmnopqrstuvwxyz",$index,1)'/>
                                        <tr>
                                            <td align="left">
                                                <input type="radio" name="a{$questionNumber}" value="{$label}"/>
                                                <label>
                                                    <xsl:if test="$showOptionLabel != 'false'">
                                                    <xsl:value-of select='$label'/>.
                                                    </xsl:if>
                                                    <xsl:value-of select="."/>
                                                </label>
                                            </td>
                                        </tr>
                                    </xsl:for-each>

                                </table>
                            </td>
                        </tr>
                    </xsl:when>
                    <xsl:otherwise>
                        <tr>
                            <td class="question_number"><xsl:if test="$hasQuestionText = 0"><xsl:value-of select="$questionNumber"/>.</xsl:if></td>
                            <td>
                                <table class="mc_question_table">
                                    <tr>
                                        <xsl:variable name="showOptionLabel">
                                            <xsl:value-of select="/root/showOptionLabel/text()"/>
                                        </xsl:variable>
                                        <xsl:for-each select="answers/ans">
                                            <xsl:variable name="index">
                                                <xsl:value-of select="position()"/>
                                            </xsl:variable>
                                            <xsl:variable name="label" select='substring("abcdefghijklmnopqrstuvwxyz",$index,1)'/>

                                            <td align="left">
                                                <input type="radio" name="a{$questionNumber}" value="{$label}"/>
                                                <label>
                                                <xsl:if test="$showOptionLabel != 'false'">
                                                    <xsl:value-of select='$label'/>.
                                                </xsl:if>
                                                <xsl:value-of select="."/></label>
                                            </td>

                                        </xsl:for-each>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </xsl:otherwise>
                </xsl:choose>


            </xsl:when>
              <xsl:when test="$type = 'MSC'">
                  <xsl:choose>
                      <xsl:when test="$renderType = 'vertical'">
                          <tr>
                              <td>&amp;nbsp;</td>
                              <td>
                                  <table class="mc_question_table vertical">
                                      <xsl:variable name="showOptionLabel">
                                          <xsl:value-of select="/root/showOptionLabel/text()"/>
                                      </xsl:variable>
                                      <xsl:for-each select="answers/ans">
                                          <xsl:variable name="index">
                                              <xsl:value-of select="position()"/>
                                          </xsl:variable>
                                          <xsl:variable name="answerValue">
                                              <xsl:value-of select="."/>
                                          </xsl:variable>
                                          <xsl:variable name="label" select='substring("abcdefghijklmnopqrstuvwxyz",$index,1)'/>
                                          <tr>
                                              <td align="left">
                                                  <input type="checkbox" name="a{$questionNumber}" value="{$answerValue}"/>
                                                  <label>
                                                      <xsl:if test="$showOptionLabel != 'false'">
                                                          <xsl:value-of select='$label'/>.
                                                      </xsl:if>
                                                      <xsl:value-of select='$answerValue'/>
                                                  </label>
                                              </td>
                                          </tr>
                                      </xsl:for-each>

                                  </table>
                              </td>
                          </tr>
                      </xsl:when>
                      <xsl:otherwise>
                          <tr>
                              <td class="question_number"><xsl:if test="$hasQuestionText = 0"><xsl:value-of select="$questionNumber"/>.</xsl:if></td>
                              <td>
                                  <table class="mc_question_table">
                                      <tr>
                                          <xsl:variable name="showOptionLabel">
                                              <xsl:value-of select="/root/showOptionLabel/text()"/>
                                          </xsl:variable>
                                          <xsl:for-each select="answers/ans">
                                              <xsl:variable name="index">
                                                  <xsl:value-of select="position()"/>
                                              </xsl:variable>
                                              <xsl:variable name="answerValue">
                                                  <xsl:value-of select="."/>
                                              </xsl:variable>
                                              <xsl:variable name="label" select='substring("abcdefghijklmnopqrstuvwxyz",$index,1)'/>

                                              <td align="left">
                                                  <input type="checkbox" name="a{$questionNumber}" value="{$answerValue}"/>
                                                  <label>
                                                      <xsl:if test="$showOptionLabel != 'false'">
                                                          <xsl:value-of select='$label'/>.
                                                      </xsl:if>
                                                      <xsl:value-of select='$answerValue'/></label>
                                              </td>

                                          </xsl:for-each>
                                      </tr>
                                  </table>
                              </td>
                          </tr>
                      </xsl:otherwise>
                  </xsl:choose>


              </xsl:when>
              <xsl:when test="$type = 'MR'">
                  <tr>
                      <td class="question_number"><xsl:if test="$hasQuestionText = 0"><xsl:value-of select="$questionNumber"/>.&#160;&#160;</xsl:if></td>
                      <td>
                          <table class="mr_question_table">
                              <tr>

                                  <xsl:for-each select="answers/ans">
                                      <xsl:variable name="index">
                                          <xsl:value-of select="position()"/>
                                      </xsl:variable>
                                      <xsl:variable name="label" select='substring("abcdefghijklmnopqrstuvwxyz",$index,1)'/>

                                      <td align="left">
                                          <input type="radio" name="a{$questionNumber}" value="{$label}"/>
                                          <label><xsl:value-of select='$label'/>.
                                          <xsl:value-of select="."/></label>
                                      </td>

                                  </xsl:for-each>
                                  <td>
                                      <input type="text" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" name="a{$questionNumber}_mr" value="" class="multiple_textbox"/>
                                  </td>
                              </tr>
                          </table>
                      </td>
                  </tr>

              </xsl:when>
            <!-- Short answer -->
            <xsl:when test="$type = 'SA'">
                <tr>
                    <td>
                    <xsl:if test="$hasQuestionText = 0">
                        <xsl:value-of select="$questionNumber"/>.&#160;
                    </xsl:if>&#160;
                    </td>
                    <td>

                        <input class="textbox" type="text" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" name="a{$questionNumber}" onclick="javascript:this.focus();" style="width:500px;"/>
                    </td>
                </tr>
            </xsl:when>
            <!-- Drawing response -->
            <xsl:when test="$type = 'DR'">
                <tr>
                    <td>
                        <xsl:if test="$hasQuestionText = 0">
                            <xsl:value-of select="$questionNumber"/>.&#160;
                        </xsl:if>&#160;
                    </td>
                    <td colspan="2">

                        <div style="width:100%; height:100%; min-height:200px;"><xsl:comment></xsl:comment>
                            <xsl:value-of select="/root/trace/text()" disable-output-escaping="yes"/>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>&amp;nbsp;</td>
                    <td>
                        <label for="a{$questionNumber}"><xsl:value-of select="$answerText"/>:</label>
                        <div class="essay">
                            <textarea autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" class="screen" onclick="javascript:this.focus();" style="font-size:12px; width:98%; vertical-align:top;height:{$rowNumberDR*1.5}em;line-height:1.5em;" name="a{$questionNumber}" cols="100" rows="{$rowNumberDR}" id="a{$questionNumber}"></textarea>
                            <img id="noscreen" style="width:98%" src="/sc-content/images/space_essay.png" />
                        </div>
                    </td>
                </tr>
            </xsl:when>
            <!-- Gridded response -->
            <xsl:when test="$type = 'GR'">
                <tr>
                    <td>&amp;nbsp;</td>
                    <td>
                        <div style="width:100%; height:100%; "><xsl:comment></xsl:comment>
                            <xsl:value-of select="/root/trace/text()" disable-output-escaping="yes"/>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td>&amp;nbsp;</td>
                    <td>

                          <input type="hidden" name="question_{$questionNumber}_type" value="{$type}"/>
                          <input type="hidden" name="question_{$questionNumber}_griddable_type" value="{$griddableType}"/>
                          <table>
                              <tr>
                                  <td>
                                      <xsl:choose>
                                          <xsl:when test="$griddableType = '2-Column'">
                                            <table border="0" class="griddable_2_column" cellpadding="0" cellspacing="0">
                                            <xsl:call-template name="GR_2_Column">
                                                <xsl:with-param name="questionNumber" select="$questionNumber"/>
                                            </xsl:call-template>
                                            </table>
                                            <script language="javascript">
                                                $(document).ready(function() {
                                                    var answer = $('#q_answertext_<xsl:value-of select="$questionNumber"/>').text();
                                                    if (answer != null &amp;&amp; answer != '') {
                                                        for (var i = 0; i &lt; 2; i++) {
                                                            var items = document.getElementsByName('a<xsl:value-of select="$questionNumber"/>_' + i);
                                                            $('#l_a<xsl:value-of select="$questionNumber"/>_' + i).html(answer.charAt(i));
                                                            for (var j = 0; j &lt; items.length; j++) {
                                                                if (items[j].value == answer.charAt(i)) {
                                                                    items[j].checked = true;
                                                                }
                                                            }
                                                        }
                                                    }
                                                    $(".cell_<xsl:value-of select="$questionNumber"/>_0").imageradio();
                                                    $(".cell_<xsl:value-of select="$questionNumber"/>_1").imageradio();
                                                });
                                            </script>
                                          </xsl:when>
                                          <xsl:when test="$griddableType = '4-Column'">
                                            <table border="0" class="griddable_4_column" cellpadding="0" cellspacing="0">
                                            <xsl:call-template name="GR_4_Column">
                                                <xsl:with-param name="questionNumber" select="$questionNumber"/>
                                            </xsl:call-template>
                                              </table>
                                              <script language="javascript">
                                                $(document).ready(function() {
                                                    var answer = $('#q_answertext_<xsl:value-of select="$questionNumber"/>').text();
                                                    if (answer != null &amp;&amp; answer != '') {
                                                        for (var i = 0; i &lt; 3; i++) {
                                                            var items = document.getElementsByName('a<xsl:value-of select="$questionNumber"/>_' + i);
                                                            $('#l_a<xsl:value-of select="$questionNumber"/>_' + i).html(answer.charAt(i));
                                                            for (var j = 0; j &lt; items.length; j++) {
                                                                if (items[j].value == answer.charAt(i)) {
                                                                    items[j].checked = true;
                                                                }
                                                            }
                                                        }
                                                    }
                                                    $(".cell_<xsl:value-of select="$questionNumber"/>_0").imageradio();
                                                    $(".cell_<xsl:value-of select="$questionNumber"/>_1").imageradio();
                                                    $(".cell_<xsl:value-of select="$questionNumber"/>_2").imageradio();
                                                });
                                            </script>
                                          </xsl:when>
                                          <xsl:when test="$griddableType = '7-Column'">
                                            <table border="0" class="griddable_7_column" cellpadding="0" cellspacing="0">
                                            <xsl:call-template name="GR_7_Column">
                                                <xsl:with-param name="questionNumber" select="$questionNumber"/>
                                            </xsl:call-template>

                                            </table>
                                              <script language="javascript">
                                                $(document).ready(function() {
                                                    var answer = $('#q_answertext_<xsl:value-of select="$questionNumber"/>').text();
                                                    if (answer != null &amp;&amp; answer != '') {
                                                        for (var i = 0; i &lt; 7; i++) {
                                                            if (i == 4) continue;
                                                            var items = document.getElementsByName('a<xsl:value-of select="$questionNumber"/>_' + i);
                                                            $('#l_a<xsl:value-of select="$questionNumber"/>_' + i).html(answer.charAt(i));
                                                            for (var j = 0; j &lt; items.length; j++) {
                                                                if (items[j].value == answer.charAt(i)) {
                                                                    items[j].checked = true;
                                                                }
                                                            }
                                                        }
                                                    }
                                                    $(".cell_<xsl:value-of select="$questionNumber"/>_0").imageradio();
                                                    $(".cell_<xsl:value-of select="$questionNumber"/>_1").imageradio();
                                                    $(".cell_<xsl:value-of select="$questionNumber"/>_2").imageradio();
                                                    $(".cell_<xsl:value-of select="$questionNumber"/>_3").imageradio();
                                                    $(".cell_<xsl:value-of select="$questionNumber"/>_5").imageradio();
                                                    $(".cell_<xsl:value-of select="$questionNumber"/>_6").imageradio();
                                                });
                                            </script>
                                          </xsl:when>
                                          <xsl:when test="$griddableType = '8-Column'">
                                            <table border="0" class="griddable_8_column" cellpadding="0" cellspacing="0">
                                            <xsl:call-template name="GR_8_Column">
                                                <xsl:with-param name="questionNumber" select="$questionNumber"/>
                                            </xsl:call-template>
                                            </table>
                                              <script language="javascript">
                                                $(document).ready(function() {
                                                    var answer = $('#q_answertext_<xsl:value-of select="$questionNumber"/>').text();
                                                    if (answer != null &amp;&amp; answer != '') {
                                                        for (var i = 0; i &lt; 8; i++) {
                                                            var items = document.getElementsByName('a<xsl:value-of select="$questionNumber"/>_' + i);
                                                            $('#l_a<xsl:value-of select="$questionNumber"/>_' + i).html(answer.charAt(i));
                                                            for (var j = 0; j &lt; items.length; j++) {
                                                                if (items[j].value == answer.charAt(i)) {
                                                                    items[j].checked = true;
                                                                }
                                                            }
                                                        }
                                                    }
                                                    $(".cell_<xsl:value-of select="$questionNumber"/>_0").imageradio();
                                                    $(".cell_<xsl:value-of select="$questionNumber"/>_1").imageradio();
                                                    $(".cell_<xsl:value-of select="$questionNumber"/>_2").imageradio();
                                                    $(".cell_<xsl:value-of select="$questionNumber"/>_3").imageradio();
                                                    $(".cell_<xsl:value-of select="$questionNumber"/>_4").imageradio();
                                                    $(".cell_<xsl:value-of select="$questionNumber"/>_5").imageradio();
                                                    $(".cell_<xsl:value-of select="$questionNumber"/>_6").imageradio();
                                                    $(".cell_<xsl:value-of select="$questionNumber"/>_7").imageradio();
                                                });
                                            </script>
                                          </xsl:when>
                                      </xsl:choose>
                                  </td>
                                  <td id="r{$questionNumber}" valign="top">

                                  </td>
                              </tr>
                          </table>

                    </td>
                </tr>

            </xsl:when>
            <xsl:when test="$type = 'ES'">
                <tr>
                    <td>&amp;nbsp;</td>
                    <td>
                        <div class="essay">
                            <textarea autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" class="dynamic_textbox screen" onclick="javascript:this.focus();" style="width:98%; vertical-align:top;height:{$rowNumberES*1.5}em;line-height:1.5em;" name="a{$questionNumber}" cols="100" rows="{$rowNumberES}" id="a{$questionNumber}"></textarea>
                            <img id="noscreen" style="width:98%" src="/sc-content/images/space_essay.png" />
                        </div>
                    </td>
                </tr>
            </xsl:when>
            <xsl:when test="$type = 'OE'">
                <tr>
                    <td>&amp;nbsp;</td>
                    <td>
                        <div class="essay">
                            <textarea autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" class="dynamic_textbox screen" onclick="javascript:this.focus();" style="width:98%; vertical-align:top;height:{$rowNumberOE*1.5}em;line-height:1.5em;" name="a{$questionNumber}" cols="100" rows="{$rowNumberOE}" id="a{$questionNumber}"></textarea>
                            <img id="noscreen" style="width:98%" src="/sc-content/images/space_open_ended.png" />
                        </div>
                    </td>
                </tr>
            </xsl:when>
            <xsl:when test="$type = 'FB'">
                <tr>
                    <td>
                    <xsl:if test="$hasQuestionText = 0">
                        <xsl:value-of select="$questionNumber"/>.&#160;
                    </xsl:if>
                    &#160;</td>
                    <td>
                        <input type="text" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" class="textbox" name="a{$questionNumber}" onclick="javascript:this.focus();" style="width:500px;"/>
                    </td>
                </tr>
            </xsl:when>
              <xsl:when test="$type = 'TS' or $type = 'TSO'">
                  <!--Do nothing-->
              </xsl:when>
              <xsl:when test="$type = 'TSE'">
                  <tr>
                      <td>&#160;</td>
                      <td>
                          <textarea autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" class="dynamic_textbox screen" onclick="javascript:this.focus();" style="width:98%; vertical-align:top;height:3em;line-height:1.5em;" name="a{$questionNumber}_e" cols="100" rows="2" id="a{$questionNumber}_e"></textarea>
                          <img id="noscreen" style="width:98%" src="/sc-content/images/space_open_ended.png" />
                      </td>
                  </tr>
              </xsl:when>
            <xsl:otherwise>
                <tr>
                    <td>&amp;nbsp;</td>
                    <td>
                        <input type="text" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" class="dynamic_textbox screen" name="a{$questionNumber}" onclick="javascript:this.focus();" style="width:500px;"/>
                        <img id="noscreen" style="width:98%" src="/sc-content/images/space_textbox.png" />
                    </td>
                </tr>
            </xsl:otherwise>
          </xsl:choose>
        </table>
     </xsl:template>
</xsl:stylesheet> 