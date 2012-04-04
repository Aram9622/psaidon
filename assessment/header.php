<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

<title><?php echo $installname;?> Assessment</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<?php
$start_time = microtime(true); 
//load filter
$curdir = rtrim(dirname(__FILE__), '/\\');
$loadgraphfilter = true;
require("$curdir/../filter/filter.php");
?>
<script type="text/javascript">
function init() {
	for (var i=0; i<initstack.length; i++) {
		var foo = initstack[i]();
	}
}
initstack = new Array();
window.onload = init;
var imasroot = '<?php echo $imasroot; ?>';
</script>
<link rel="stylesheet" href="<?php echo $imasroot . "/assessment/mathtest.css?ver=012612";?>" type="text/css"/>
<?php
echo "<script type=\"text/javascript\" src=\"$imasroot/javascript/general.js?ver=011312\"></script>\n";
if (isset($sessiondata['coursetheme'])) {
	if (isset($flexwidth)) {
		$coursetheme = str_replace('_fw','',$sessiondata['coursetheme']);
	} else {
		$coursetheme = $sessiondata['coursetheme'];
	}
	echo "<link rel=\"stylesheet\" type=\"text/css\" href=\"$imasroot/themes/$coursetheme\"/>\n";
}
if ($isdiag) {
	echo "<link rel=\"stylesheet\" type=\"text/css\" href=\"$imasroot/diag/print.css\" media=\"print\"/>\n";
} else {
	echo "<link rel=\"stylesheet\" type=\"text/css\" href=\"$imasroot/assessment/print.css\" media=\"print\"/>\n";
}
if (!isset($sessiondata['mathdisp'])) {
	echo '<script type="text/javascript">var AMnoMathML = true;var ASnoSVG = true;var AMisGecko = 0;var AMnoTeX = false;</script>';
	echo "<script src=\"$imasroot/javascript/mathgraphcheck.js?v=091311\" type=\"text/javascript\"></script>\n";
} else if ($sessiondata['mathdisp']==1) {
	echo "<script type=\"text/javascript\" src=\"$imasroot/javascript/ASCIIMathML_min.js?v=100411\"></script>\n";
	echo "<script type=\"text/javascript\">var usingASCIIMath = true;</script>";
} else if ($sessiondata['mathdisp']==2) {
	echo '<script type="text/javascript">var AMTcgiloc = "'.$mathimgurl.'";</script>'; 
	echo "<script src=\"$imasroot/javascript/ASCIIMathTeXImg_min.js?v=082911\" type=\"text/javascript\"></script>\n";
	echo "<script type=\"text/javascript\">var usingASCIIMath = false;</script>";
} else if ($sessiondata['mathdisp']==0) {
	echo '<script type="text/javascript">var noMathRender = true; var usingASCIIMath = false;</script>';	
}

if ($sessiondata['graphdisp']==1) {
	echo "<script src=\"$imasroot/javascript/ASCIIsvg_min.js?v=040312\" type=\"text/javascript\"></script>\n";
	echo "<script type=\"text/javascript\">var usingASCIISvg = true;</script>";
} else {
	echo "<script src=\"$imasroot/javascript/mathjs.js?v=022112\" type=\"text/javascript\"></script>\n";
	echo "<script type=\"text/javascript\">var usingASCIISvg = false;</script>";
}
?>
<!--[if lte IE 6]> 
<style type="text/css"> 
div { zoom: 1; } 
.clear { line-height: 0;}
#mqarea { height: 2em;}
#GB_overlay, #GB_window { 
 position: absolute; 
 top: expression(0+((e=document.documentElement.scrollTop)?e:document.body.scrollTop)+'px'); 
 left: expression(0+((e=document.documentElement.scrollLeft)?e:document.body.scrollLeft)+'px');} 
}
</style> 
<![endif]--> 
<script src="<?php echo $imasroot . "/javascript/AMhelpers_min.js?v=011912";?>" type="text/javascript"></script>
<script src="<?php echo $imasroot . "/javascript/confirmsubmit.js";?>" type="text/javascript"></script>
<!--[if lt IE 9]><script type="text/javascript" src="<?php echo $imasroot;?>/javascript/excanvas_min.js?v=120811"></script><![endif]-->
<script type="text/javascript" src="<?php echo $imasroot;?>/javascript/drawing_min.js?v=031312"></script>
<?php
echo "<script type=\"text/javascript\">imasroot = '$imasroot';</script>";
if (isset($useeditor) && $sessiondata['useed']==1) {
	echo '<script type="text/javascript" src="'.$imasroot.'/editor/tiny_mce.js?v=082911"></script>';
	echo "\n";
	echo '<script type="text/javascript">';
	echo 'var usingTinymceEditor = true;';
	if (isset($sessiondata['coursetheme'])) {
		echo 'var coursetheme = "'.$sessiondata['coursetheme'].'";';
	} else {
		echo 'var coursetheme = "'.$coursetheme.'";';
	}
	if (!isset($CFG['GEN']['noFileBrowser'])) {
		echo 'var fileBrowserCallBackFunc = "fileBrowserCallBack";';
	} else {
		echo 'var fileBrowserCallBackFunc = null;';
	}
	echo 'initeditor("textareas","mceEditor");';
	echo '</script>';
} else {
	echo '<script type="text/javascript">var usingTinymceEditor = false;</script>';
}

$curdir = rtrim(dirname(__FILE__), '/\\');
if (isset($placeinhead)) {
	echo $placeinhead;
}
if (isset($CFG['GEN']['headerscriptinclude'])) {
	require("$curdir/../{$CFG['GEN']['headerscriptinclude']}");
}
echo '</head><body>';

$insertinheaderwrapper = ' ';
echo '<div class=mainbody>';
if (isset($insertinheaderwrapper)) {
	//echo '<div class="headerwrapper">'.$insertinheaderwrapper.'</div>';
}
if (!isset($flexwidth)) {
	echo '<div class="headerwrapper">';
}

if (isset($CFG['GEN']['headerinclude']) && !isset($flexwidth)) {
	require("$curdir/../{$CFG['GEN']['headerinclude']}");
}
if (!isset($coursetopbar)) {
	$coursetopbar = explode('|',$sessiondata['coursetopbar']);
	$coursetopbar[0] = explode(',',$coursetopbar[0]);
	$coursetopbar[1] = explode(',',$coursetopbar[1]);
	if (!isset($coursetopbar[2])) { $coursetopbar[2] = 0;}
	if ($coursetopbar[0][0] == null) {unset($coursetopbar[0][0]);}
	if ($coursetopbar[1][0] == null) {unset($coursetopbar[1][0]);}
}		

if (isset($cid) && !isset($flexwidth) && $sessiondata['isteacher'] && $coursetopbar[2]==1 && count($coursetopbar[1])>0) {
	echo '<div id="navlistcont">';
	echo '<ul id="navlist">';
	echo "<li><a href=\"$imasroot/course/course.php?cid=$cid\">Course</a></li> ";
	if (in_array(0,$coursetopbar[1]) && $msgset<4) { //messages
		echo "<li><a href=\"$imasroot/msgs/msglist.php?cid=$cid\">Messages</a></li> ";
	}
	if (in_array(6,$coursetopbar[1])) { //Forums
		echo "<li><a href=\"$imasroot/forums/forums.php?cid=$cid\">Forums</a></li>";
	}
	if (in_array(1,$coursetopbar[1])) { //Stu view
		echo "<li><a href=\"$imasroot/course/course.php?cid=$cid&stuview=0\">Student View</a></li>";
	}
	if (in_array(3,$coursetopbar[1])) { //List stu
		echo "<li><a href=\"$imasroot/course/listusers.php?cid=$cid\">Roster</a></li>\n";
	}
	if (in_array(2,$coursetopbar[1])) { //Gradebook
		echo "<li><a href=\"$imasroot/course/gradebook.php?cid=$cid\">Gradebook</a>$gbnewflag</li>";
	}
	if (in_array(7,$coursetopbar[1])) { //Groups
		echo "<li><a href=\"$imasroot/course/managestugrps.php?cid=$cid\">Groups</a></li>\n";
	}
	if (in_array(4,$coursetopbar[1])) { //Calendar
		echo "<li><a href=\"$imasroot/course/showcalendar.php?cid=$cid\">Calendar</a></li>\n";
	}
	if (in_array(5,$coursetopbar[1])) { //Quickview
		echo "<li><a href=\"$imasroot/course/course.php?cid=$cid&quickview=on\">Quick View</a></li>\n";
	}
	
	if (in_array(9,$coursetopbar[1])) { //Log out
		echo "<li><a href=\"$imasroot/actions.php?action=logout\">Log Out</a></li>";
	}
	echo '</ul>';
	echo '<br class="clear" />';
	echo '</div>';
} else if (isset($cid) && !isset($flexwidth) && $sessiondata['isteacher'] && $coursetopbar[2]==1 && count($coursetopbar[0])>0) {
	echo '<div id="navlistcont">';
	echo '<ul id="navlist">';
	echo "<li><a href=\"$imasroot/course/course.php?cid=$cid\">Course</a></li> ";
	if (in_array(0,$coursetopbar[0]) && $msgset<4) { //messages
		echo "<li><a href=\"$imasroot/msgs/msglist.php?cid=$cid\">Messages</a></li> ";
	}
	if (in_array(3,$coursetopbar[0])) { //forums
		echo "<li><a href=\"$imasroot/forums/forums.php?cid=$cid\">Forums</a></li> ";
	}
	if (in_array(1,$coursetopbar[0])) { //Gradebook
		echo "<li><a href=\"$imasroot/course/gradebook.php?cid=$cid\">Gradebook</a></li> ";
	}
	if (in_array(2,$coursetopbar[0])) { //Calendar
		echo "<li><a href=\"$imasroot/course/showcalendar.php?cid=$cid\">Calendar</a></li>\n";
	}
	if (in_array(9,$coursetopbar[0])) { //Log out
		echo "<li><a href=\"$imasroot/actions.php?action=logout\">Log Out</a></li>";
	}
	echo '</ul>';
	echo '<br class="clear" />';
	echo '</div>';
}
if (!isset($flexwidth)) {
	echo '</div>';
}
echo '<div class="midwrapper">';


?>
