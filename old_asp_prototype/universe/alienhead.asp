<HTML>
<HEAD>

<TITLE>Alien Head</TITLE>
<META NAME="FILENAME" CONTENT="alienhead_JS.HTM">

<STYLE>
  A:link { color:#003399; text-decoration:none; }
  A:visited { color:#6699CC; text-decoration:none; }
  A:hover { text-decoration:underline; }
</STYLE>

<SCRIPT LANGUAGE="JavaScript">
      var curElement;
      function doMouseMove() {
        var newleft=0, newTop = 0
        if ((event.button==1) && (curElement!=null)) {
          // position alien
          newleft=event.clientX-document.all.OuterDiv.offsetLeft-(curElement.offsetWidth/2)
          if (newleft<0) newleft=0
          curElement.style.pixelLeft= newleft
          newtop=event.clientY -document.all.OuterDiv.offsetTop-(curElement.offsetHeight/2)
          if (newtop<0) newtop=0
          curElement.style.pixelTop= newtop
          event.returnValue = false
          event.cancelBubble = true
        }
      }

      function doDragStart() {
        // Don't do default drag operation.
        if ("IMG"==event.srcElement.tagName)
          event.returnValue=false;
      }

      function doMouseDown() {
        if ((event.button==1) && (event.srcElement.tagName=="IMG"))
          curElement = event.srcElement
      }

      document.ondragstart = doDragStart;
      document.onmousedown = doMouseDown;
      document.onmousemove = doMouseMove;
      document.onmouseup = new Function("curElement=null")
</SCRIPT>
	
<SCRIPT FOR="alienhead" EVENT="onmousedown" LANGUAGE="JavaScript">
      // Do not move the alienhead or allow it to be dragged
      event.cancelBubble=true
</SCRIPT>
    
</HEAD>

<BODY TOPMARGIN=20 LEFTMARGIN="40" BGCOLOR="#FFFFFF" LINK="#000066" VLINK="#666666" TEXT="#000000">
<!--TOOLBAR_START-->
<!--TOOLBAR_EXEMPT-->
<!--TOOLBAR_END-->
<FONT FACE="verdana,arial,helvetica" SIZE="2">
  
<H2>Alien Head</H2>

<FONT FACE="verdana,arial,helvetica" SIZE=1>
<A href="#" onclick=self.close()><IMG ALIGN="middle" SRC="demo.gif" WIDTH="16" HEIGHT="16" BORDER="0" ALT="Click to Close Sample"></A>
 <A href="#" onclick=self.close()>Close This Sample</A> 
</FONT>
<HR>

<P>
<P>
<FONT FACE="verdana,arial,helvetica" SIZE=2>

<FONT FACE="Verdana, Arial, Helvetica" SIZE="3"><B>Use the mouse to create an alien!</B></FONT>
<BR><BR>

<DIV id="OuterDiv" style="position:relative;width:100%;height:400px">
    <IMG ID="alienhead" STYLE="position:absolute;TOP:83pt;LEFT:142pt;width: 230px; height=150px; Z-INDEX:2;" src="images/alienhead.gif" WIDTH="135" HEIGHT="86">
    <IMG ID="hair1" STYLE="position:absolute;TOP:8pt;LEFT:0pt;WIDTH:63pt;HEIGHT:38pt;Z-INDEX:22;" src="images/hair1.gif" WIDTH="84" HEIGHT="51">
    <IMG ID="hair2" STYLE="position:absolute;TOP:116pt;LEFT:8pt;WIDTH:56pt;HEIGHT:33pt;Z-INDEX:21;" src="images/hair2.gif" WIDTH="74" HEIGHT="44">
    <IMG ID="hair3" STYLE="position:absolute;TOP:58pt;LEFT:0pt;WIDTH:68pt;HEIGHT:50pt;Z-INDEX:20;" src="images/hair3.gif" WIDTH="90" HEIGHT="67">
    <IMG ID="ears1" STYLE="position:absolute;TOP:8pt;LEFT:190pt;WIDTH:89pt;HEIGHT:45pt;Z-INDEX:19;" src="images/ears1.gif" WIDTH="119" HEIGHT="60">
    <IMG ID="ears2" STYLE="position:absolute;TOP:8pt;LEFT:297pt;WIDTH:93pt;HEIGHT:48pt;Z-INDEX:18;" src="images/ears2.gif" WIDTH="124" HEIGHT="64">
    <IMG ID="ears3" STYLE="position:absolute;TOP:8pt;LEFT:99pt;WIDTH:85pt;HEIGHT:44pt;Z-INDEX:17;" src="images/ears3.gif" WIDTH="113" HEIGHT="58">
    <IMG ID="nose1" STYLE="position:absolute;TOP:99pt;LEFT:327pt;WIDTH:29pt;HEIGHT:35pt;Z-INDEX:16;" src="images/nose1.gif" WIDTH="39" HEIGHT="46">
    <IMG ID="nose2" STYLE="position:absolute;TOP:58pt;LEFT:327pt;WIDTH:26pt;HEIGHT:41pt;Z-INDEX:15;" src="images/nose2.gif" WIDTH="54" HEIGHT="54">
    <IMG ID="nose3" STYLE="position:absolute;TOP:140pt;LEFT:327pt;WIDTH:29pt;HEIGHT:29pt;Z-INDEX:14;" src="images/nose3.gif" WIDTH="39" HEIGHT="38">
    <IMG ID="mouth1" STYLE="position:absolute;TOP:107pt;LEFT:368pt;WIDTH:59pt;HEIGHT:20pt;Z-INDEX:13;" src="images/mouth1.gif" WIDTH="78" HEIGHT="26">
    <IMG ID="mouth2" STYLE="position:absolute;TOP:140pt;LEFT:368pt;WIDTH:50pt;HEIGHT:23pt;Z-INDEX:12;" src="images/mouth2.gif" WIDTH="66" HEIGHT="30">
    <IMG ID="mouth3" STYLE="position:absolute;TOP:74pt;LEFT:368pt;WIDTH:47pt;HEIGHT:23pt;Z-INDEX:11;" src="images/mouth3.gif" WIDTH="62" HEIGHT="30">
    <IMG ID="eyes1" STYLE="position:absolute;TOP:66pt;LEFT:91pt;WIDTH:47pt;HEIGHT:18pt;Z-INDEX:10;" src="images/eyes1.gif" WIDTH="62" HEIGHT="24">
    <IMG ID="eyes2" STYLE="position:absolute;TOP:99pt;LEFT:91pt;WIDTH:38pt;HEIGHT:19pt;Z-INDEX:9;" src="images/eyes2.gif" WIDTH="50" HEIGHT="25">
    <IMG ID="eyes3" STYLE="position:absolute;TOP:124pt;LEFT:83pt;WIDTH:50pt;HEIGHT:18pt;Z-INDEX:8;" src="images/eyes3.gif" WIDTH="66" HEIGHT="24">
    <IMG ID="shoe1" STYLE="position:absolute;TOP:173pt;LEFT:335pt;WIDTH:71pt;HEIGHT:21pt;Z-INDEX:7;" src="images/shoes1.gif" WIDTH="94" HEIGHT="28">
    <IMG ID="shoe2" STYLE="position:absolute;TOP:206pt;LEFT:335pt;WIDTH:74pt;HEIGHT:22pt;Z-INDEX:6;" src="images/shoes2.gif" WIDTH="99" HEIGHT="29">
    <IMG ID="shoes3" STYLE="position:absolute;TOP:231pt;LEFT:335pt;WIDTH:79pt;HEIGHT:20pt;Z-INDEX:5;" src="images/shoes3.gif" WIDTH="105" HEIGHT="26">
    <IMG ID="hands1" STYLE="position:absolute;TOP:157pt;LEFT:8pt;WIDTH:119pt;HEIGHT:32pt;Z-INDEX:4;" src="images/hands1.gif" WIDTH="159" HEIGHT="42">
    <IMG ID="hands3" STYLE="position:absolute;TOP:190pt;LEFT:0pt;WIDTH:141pt;HEIGHT:26pt;Z-INDEX:3;" src="images/hands3.gif" WIDTH="188" HEIGHT="34">
</DIV>

<TABLE CELLSPACING="0" CELLPADDING="0" BORDER="0">

  <TR>
    <TD ALIGN="LEFT" VALIGN="TOP" COLSPAN="2"><FONT FACE="Verdana, Arial, Helvetica" SIZE="2"><b>Description</b></FONT></TD>
  </TR>

  <TR>
    <TD ALIGN="LEFT" VALIGN="TOP" COLSPAN="2"><FONT FACE="Verdana, Arial, Helvetica" SIZE="2">Users can position the various fruits and nuts on the alien head to make their favorite alien face. Behind this light-hearted demo is some very serious technology.</FONT></TD>
 </TR>

  <TR>
    <TD ALIGN="LEFT" VALIGN="TOP" COLSPAN="2"><FONT FACE="Verdana, Arial, Helvetica" SIZE="2"><p><br><b>1. CSS 2-D Positioning</b><br></FONT></TD>
  </TR>

  <TR>
    <TD ALIGN="LEFT" VALIGN="TOP"><FONT FACE="Verdana, Arial, Helvetica" SIZE="2">All of the images on the page are arranged in 2-D space.</FONT></TD>
  </TR>

  <TR>
    <TD ALIGN="LEFT" VALIGN="TOP" COLSPAN="2"><FONT FACE="Verdana, Arial, Helvetica" SIZE="2"><p><br><b>2. Event bubbling</b><br></FONT></TD>
  </TR>

  <TR>
    <TD ALIGN="LEFT" VALIGN="TOP"><FONT FACE="Verdana, Arial, Helvetica" SIZE="2">The code that allows elements to be positioned is only 15 lines long. Each individual graphic does not require a separate event handler—instead, the events are captured at the document level.</FONT></TD>
  </TR>

  <TR>
    <TD ALIGN="LEFT" VALIGN="TOP"><FONT FACE="Verdana, Arial, Helvetica" SIZE="2"><p></FONT></TD>
  </TR>
  <P>
 </TABLE>
 
</FONT>
<P>
<P>
<P>
<HR>
<FONT FACE="MS SANS SERIF" SIZE="1" COLOR="BLACK">
© <A HREF="http://msdn.microsoft.com/isapi/gomscom.asp?TARGET=/misc/cpyright.htm"
 TARGET="_top">2000 Microsoft Corporation. All rights reserved. Terms of use</A>.
</FONT>

</BODY>
</HTML>
