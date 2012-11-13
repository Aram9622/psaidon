//dropdown menu
var closetimer	= 0;
var ddmenuitem	= 0;
var homemenuloaded = 0;
// open hidden layer
function mopen(id,cid) {	
	if (id=='homemenu' && homemenuloaded==0) {
		basicahah(imasroot+'/gethomemenu.php?cid='+cid,'homemenu');
		homemenuloaded = 1;
	}
	mcancelclosetime();
	if(ddmenuitem) ddmenuitem.style.visibility = 'hidden';
	ddmenuitem = document.getElementById(id);
	ddmenuitem.style.visibility = 'visible';
}
// close showed layer
function mclose() {
	if(ddmenuitem) ddmenuitem.style.visibility = 'hidden';
}
// go close timer
function mclosetime() {
	closetimer = window.setTimeout(mclose, 250);
}
// cancel close timer
function mcancelclosetime() {
	if(closetimer)
	{
		window.clearTimeout(closetimer);
		closetimer = null;
	}
}

function basicahah(url, target, def) {
  if (def==null) { def =  ' Fetching data... ';}
  document.getElementById(target).innerHTML = def;
  var hasreq = false;
  if (window.XMLHttpRequest) { 
    req = new XMLHttpRequest();
    hasreq = true;
  } else if (window.ActiveXObject) { 
    req = new ActiveXObject("Microsoft.XMLHTTP");
    hasreq = true;
  } 
  if (hasreq) { 
    req.onreadystatechange = function() {basicahahDone(url, target);}; 
    req.open("GET", url, true); 
    req.send(""); 
  } 
}  

function basicahahDone(url, target) { 
  if (req.readyState == 4) { // only if req is "loaded" 
    if (req.status == 200) { // only if "OK" 
      document.getElementById(target).innerHTML = req.responseText; 
    } else { 
      document.getElementById(target).innerHTML=" AHAH Error:\n"+ req.status + "\n" +req.statusText; 
    } 
  } 
}

function arraysearch(needle,hay) {
      for (var i=0; i<hay.length;i++) {
            if (hay[i]==needle) {
                  return i;
            }
      }
      return -1;
   }
   
var tipobj = 0;
function tipshow(el,tip) {
	if (typeof tipobj!= 'object') {
		tipobj = document.createElement("div");
		tipobj.className = "tips";
		document.getElementsByTagName("body")[0].appendChild(tipobj);
	} 
	tipobj.innerHTML = tip;
	tipobj.style.display = "block";
	
	if (typeof AMnoMathML!='undefined' && typeof noMathRender != 'undefined') {
		if (!AMnoMathML && !noMathRender) {
			AMprocessNode(tipobj);
		}
	}
	var p = findPos(el);

	if (self.innerHeight) {
                x = self.innerWidth;
        } else if (document.documentElement && document.documentElement.clientHeight) {
                x = document.documentElement.clientWidth;
        } else if (document.body) {
                x = document.body.clientWidth;
        }
        var scrOfX = 0;
        if( typeof( window.pageYOffset ) == 'number' ) {
	    scrOfX = window.pageXOffset;
	  } else if( document.body && ( document.body.scrollLeft || document.body.scrollTop ) ) {
	    scrOfX = document.body.scrollLeft;
	  } else if( document.documentElement && ( document.documentElement.scrollLeft || document.documentElement.scrollTop ) ) {
	    scrOfX = document.documentElement.scrollLeft;
	  }

        x += scrOfX;
        if ((p[0] + tipobj.offsetWidth)>x) {
        	p[0] = x - tipobj.offsetWidth - 30;
        }
        
	tipobj.style.left = (p[0]+20) + "px";
	if (p[1] < 30) {
		tipobj.style.top = (p[1]+20) + "px";
	} else {
		tipobj.style.top = (p[1]-tipobj.offsetHeight) + "px";
	}
}

function popupwindow(id,content,width,height,scroll) {
	if (height=='fit') {
		height = window.height - 80;
	}
	var attr = "width="+width+",height="+height+",status=0,resizable=1,directories=0,menubar=0";
	if (scroll!=null && scroll==true) {
		attr += ",scrollbars=1";
	}
	if (content.match(/^http/)) {
		window.open(content,id,attr);
	} else {
		var win1 = window.open('',id,attr);
		win1.document.write('<html><head><title>Popup</title></head><body>');
		win1.document.write(content);
		win1.document.write('</body></html>');
		win1.document.close();
	}
}
function tipout(el) {
	tipobj.style.display = "none";	
}

function findPos(obj) { //from quirksmode.org
	var curleft = curtop = 0;
	if (obj.offsetParent) {
		do {
			curleft += obj.offsetLeft;
			curtop += obj.offsetTop;
			if (obj.offsetParent) {
				if (obj.parentNode && obj.offsetParent!=obj.parentNode) {
					curleft -= obj.parentNode.scrollLeft;
					curtop -= obj.parentNode.scrollTop;
				} else {
					curleft -= obj.offsetParent.scrollLeft;
					curtop -= obj.offsetParent.scrollTop;
				}
			}
		} while (obj = obj.offsetParent);
	}
	return [curleft,curtop];
}
function togglepic(el) {
	if (el.getAttribute("src").match("userimg_sm")) {
		el.setAttribute("src",el.getAttribute("src").replace("_sm","_"));
	} else {
		el.setAttribute("src",el.getAttribute("src").replace("_","_sm"));
	}
}


//from http://www.webreference.com/programming/javascript/onloads/
function addLoadEvent(func) { 
	  var oldonload = window.onload; 
	  if (typeof window.onload != 'function') { 
	    window.onload = func; 
	  } else { 
	    window.onload = function() { 
	      if (oldonload) { 
	        oldonload(); 
	      } 
	      func(); 
	    } 
	  } 
} 

function submitlimiter(e) {
	e = e || window.event;  
	var target = e.target || e.srcElement;
	if (target.className == 'submitted') {
		alert("You have already submitted this page.  Please be patient while your submission is processed.");
		target.className = "submitted2";
		e.preventDefault();
	} else if (target.className == 'submitted2') {
		e.preventDefault();
	} else {
		target.className = 'submitted';
	}
}
function setupFormLimiters() {
	var el = document.getElementsByTagName("form");
	for (var i=0;i<el.length;i++) {
		if (typeof el[i].onsubmit != 'function') {
			el[i].onsubmit = submitlimiter;
		}
	}
}
addLoadEvent(setupFormLimiters);


var GB_loaded = false;
//based on greybox redux, http://jquery.com/demo/grey/
function GB_show(caption,url,width,height) {
	if (GB_loaded == false) {
		var gb_overlay = document.createElement("div");
		gb_overlay.id = "GB_overlay";
		gb_overlay.onclick = GB_hide;
		document.getElementsByTagName("body")[0].appendChild(gb_overlay);
		var gb_window = document.createElement("div");
		gb_window.id = "GB_window";
		gb_window.innerHTML = '<div id="GB_caption"></div><div id="GB_loading">Loading...</div><div id="GB_frameholder" ></div>';
		document.getElementsByTagName("body")[0].appendChild(gb_window);
		GB_loaded  = true;
	}
	document.getElementById("GB_frameholder").innerHTML = '<iframe onload="GB_doneload()" id="GB_frame" src="'+url+'"></iframe>';
	if (url.match(/libtree/)) {
		var btnhtml = '<span class="floatright"><input type="button" value="Use Libraries" onClick="document.getElementById(\'GB_frame\').contentWindow.setlib()" /> ';
		btnhtml += '<span class="pointer" onclick="GB_hide()">[X]</span>&nbsp;</span>Select Libraries<div class="clear"></div>';
		document.getElementById("GB_caption").innerHTML = btnhtml;
	} else {
		document.getElementById("GB_caption").innerHTML = '<span class="floatright"><span class="pointer" onclick="GB_hide()">[X]</span></span>'+caption;
		document.getElementById("GB_caption").onclick = GB_hide;
	}
	document.getElementById("GB_window").style.display = "block";
	document.getElementById("GB_overlay").style.display = "block";
	document.getElementById("GB_loading").style.display = "block";
	
	var de = document.documentElement;
	var w = self.innerWidth || (de&&de.clientWidth) || document.body.clientWidth;
	var h = self.innerHeight || (de&&de.clientHeight) || document.body.clientHeight;
	document.getElementById("GB_window").style.width = width + "px";
	document.getElementById("GB_window").style.height = (h-30) + "px";
	document.getElementById("GB_window").style.left = ((w - width)/2)+"px";
	document.getElementById("GB_frame").style.height = (h - 30 -34)+"px";
}
function GB_doneload() {
	document.getElementById("GB_loading").style.display = "none";
}
function GB_hide() {
	document.getElementById("GB_window").style.display = "none";
	document.getElementById("GB_overlay").style.display = "none";
}

function chkAllNone(frmid, arr, mark) {
  var frm = document.getElementById(frmid);
  for (i = 0; i <= frm.elements.length; i++) {
   try{
     if ((arr=='all' && frm.elements[i].type=='checkbox') || frm.elements[i].name == arr) {
       frm.elements[i].checked = mark;
     }
   } catch(er) {}
  }
  return false;
}

function initeditor(edmode,edids) {
	var edsetup = {
	    mode : edmode,
	    theme : "advanced",
	    theme_advanced_buttons1 : "fontselect,fontsizeselect,formatselect,bold,italic,underline,strikethrough,separator,sub,sup,separator,cut,copy,paste,pasteword,undo,redo",
	    theme_advanced_buttons2 : "justifyleft,justifycenter,justifyright,justifyfull,separator,numlist,bullist,outdent,indent,separator,forecolor,backcolor,separator,hr,anchor,link,unlink,charmap,image,"+((fileBrowserCallBackFunc != null)?"attach,":"") + "table"+(document.documentElement.clientWidth<900?"":",tablecontrols,separator")+",code,separator,asciimath,asciimathcharmap,asciisvg",
	    theme_advanced_buttons3 : "",
	    theme_advanced_fonts : "Arial=arial,helvetica,sans-serif,Courier New=courier new,courier,monospace,Georgia=georgia,times new roman,times,serif,Tahoma=tahoma,arial,helvetica,sans-serif,Times=times new roman,times,serif,Verdana=verdana,arial,helvetica,sans-serif",
	    theme_advanced_toolbar_location : "top",
	    theme_advanced_toolbar_align : "left",
	    theme_advanced_statusbar_location : "bottom",
	    theme_advanced_source_editor_height: "500",
	    plugins : 'asciimath,asciisvg,dataimage,table,inlinepopups,paste,media,advlist'+((fileBrowserCallBackFunc != null)?",attach":""),
	    gecko_spellcheck : true,
	    extended_valid_elements : 'iframe[src|width|height|name|align],param[name|value],@[sscr]',
	    content_css : imasroot+'/imascore.css,'+imasroot+'/themes/'+coursetheme,
	    popup_css_add : imasroot+'/themes/'+coursetheme,
	    theme_advanced_resizing : true,
	    table_styles: "Gridded=gridded",
	    cleanup_callback : "imascleanup",
	    AScgiloc : imasroot+'/filter/graph/svgimg.php',
	    ASdloc : imasroot+'/javascript/d.svg',
	    file_browser_callback : fileBrowserCallBackFunc
	}
	if (edmode=="exact") {
		edsetup.elements = edids
	} else if (edmode=="textareas") {
		edsetup.editor_selector = edids;
	}
	    
	tinyMCE.init(edsetup);	
}

function fileBrowserCallBack(field_name, url, type, win) {
	var connector = imasroot+"/editor/file_manager.php";
	my_field = field_name;
	my_win = win;
	switch (type) {
		case "image":
			connector += "?type=img";
			break;
		case "file":
			connector += "?type=files";
			break;
	}
	tinyMCE.activeEditor.windowManager.open({
		file : connector,
		title : 'File Manager',
		width : 350,  
		height : 450,
		resizable : "yes",
		inline : "yes",  
		close_previous : "no"
	    }, {
		window : win,
		input : field_name
	    });

	//window.open(connector, "file_manager", "modal,width=450,height=440,scrollbars=1");
}
function imascleanup(type, value) {
	if (type=="get_from_editor") {
		//value = value.replace(/[\x84\x93\x94]/g,'"');
		//var rl = '\u2122,<sup>TM</sup>,\u2026,...,\u201c|\u201d,",\u2018|\u2019,\',\u2013|\u2014|\u2015|\u2212,-'.split(',');
		//for (var i=0; i<rl.length; i+=2) {
		//	value = value.replace(new RegExp(rl[i], 'gi'), rl[i+1]);
		//}
		value = value.replace(/<!--([\s\S]*?)-->|&lt;!--([\s\S]*?)--&gt;|<style>[\s\S]*?<\/style>/g, "");  // Word comments
		value = value.replace(/class="?Mso\w+"?/g,'');
		value = value.replace(/<p\s*>\s*<\/p>/gi,'');
		value = value.replace(/<script.*?\/script>/gi,'');
		value = value.replace(/<input[^>]*button[^>]*>/gi,'');
	}
	return value;
}

function readCookie(name) {
  var nameEQ = name + "=";
  var ca = document.cookie.split(';');
  for(var i = 0; i < ca.length; i++) {
    var c = ca[i];
    while (c.charAt(0) == ' ') c = c.substring(1, c.length);
    if (c.indexOf(nameEQ) == 0) return unescape(c.substring(nameEQ.length, c.length));
  }
  return null;
}

function selectByDivID(el) {
	var v = el.value;
	var c = el.value.split(":")[0];
	var els = document.getElementsByTagName("div");
	for (var i=0;i<els.length;i++) {
		if (els[i].className.match(c)) {
			els[i].style.display = (els[i].id==v)?"block":"none";
		}
	}
	var exdate=new Date();
	exdate.setDate(exdate.getDate() + 365);
	document.cookie = c+"store"+"="+escape(v) + ";expires="+exdate.toGMTString();
}
function setselectbycookie() {
	var els = document.getElementsByTagName("select");	
	for (var i=0;i<els.length;i++) {
		if (els[i].className.match("alts")) {
			var cl = els[i].className.replace(/alts/,'').replace(/\s/g,'');
			if ((co = readCookie(cl+"store"))!=null) { //has cookie
				co = co.replace('store','');
				els[i].value = co;
				selectByDivID(els[i]);
			}
		}
	}
}
addLoadEvent(setselectbycookie);
