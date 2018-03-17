<HTML>
<HEAD>

<TITLE>Short Range Sensors</TITLE>

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
<FONT FACE="verdana,arial,helvetica" SIZE="2">
  
<H2>Alien Head</H2>

<HR>

<P>
<P>
<FONT FACE="verdana,arial,helvetica" SIZE=2>

<FONT FACE="Verdana, Arial, Helvetica" SIZE="3"><B>Use the mouse to create an alien!</B></FONT>
<BR><BR>

<DIV id="OuterDiv" style="position:relative;width:100px;height:100px">
    <IMG ID="alienhead" STYLE="position:absolute;TOP:83pt;LEFT:142pt;width: 20px; height=20px; Z-INDEX:2;" src="images/alienhead.gif" WIDTH="20" HEIGHT="20">
    <IMG ID="hair1" STYLE="position:absolute;TOP:8pt;LEFT:0pt;WIDTH:63pt;HEIGHT:38pt;Z-INDEX:22;" src="images/hair1.gif" WIDTH="84" HEIGHT="51">
    <IMG ID="hair2" STYLE="position:absolute;TOP:116pt;LEFT:8pt;WIDTH:56pt;HEIGHT:33pt;Z-INDEX:21;" src="images/hair2.gif" WIDTH="74" HEIGHT="44">
    <IMG ID="hair3" STYLE="position:absolute;TOP:58pt;LEFT:0pt;WIDTH:68pt;HEIGHT:50pt;Z-INDEX:20;" src="images/hair3.gif" WIDTH="90" HEIGHT="67">
</DIV>


</BODY>
</HTML>
