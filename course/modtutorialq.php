<?php 
require("../validate.php");
require("../includes/htmlutil.php");

function stripsmartquotes($text) {
		$text = str_replace(
			array("\xe2\x80\x98", "\xe2\x80\x99", "\xe2\x80\x9c", "\xe2\x80\x9d", "\xe2\x80\x93", "\xe2\x80\x94", "\xe2\x80\xa6"),
			array("'", "'", '"', '"', '-', '--', '...'),
			$text);
		// Next, replace their Windows-1252 equivalents.
		$text = str_replace(
			array(chr(145), chr(146), chr(147), chr(148), chr(150), chr(151), chr(133)),
			array("'", "'", '"', '"', '-', '--', '...'),
			$text);
		return $text;
 	}

$isadmin = false;
$isgrpadmin = false;
if (!isset($_GET['aid'])) {
	if ($_GET['cid']=="admin") {
		if ($myrights == 100) {
			$isadmin = true;
		} else if ($myrights==75) {
			$isgrpadmin = true;
		}
	}
}
$now = time();
$editmsg = '';

if (isset($_POST['text'])) {
	if (!isset($_GET['id'])) {
		$id = 'new';
	} else {
		$id = $_GET['id'];
	}
	$_POST = stripslashes_deep($_POST);
	$qtext = stripsmartquotes($_POST['text']);
	$nparts = intval($_POST['nparts']);
	$qparts = array();
	$questions = array();
	$feedback = array();
	$answer = array();
	$partial = array();
	for ($n=0;$n<$nparts;$n++) {
		$questions[$n] = array(); $feedback[$n] = array();
		$qparts[$n] = intval($_POST['qparts'.$n]);
		$answer[$n] = $_POST['ans'.$n];
		for ($i=0;$i<$qparts[$n];$i++) {
			$questions[$n][$i] = $_POST['txt'.$n.'-'.$i];
			$feedbacktxt[$n][$i] = $_POST['fb'.$n.'-'.$i];
			$partial[$n][$i] = floatval($_POST['pc'.$n.'-'.$i]);
		}
	}
	$nhints = intval($_POST['nhints']);
	$hinttext = array();
	for ($n=0;$n<$nhints;$n++) {
		if (!empty($_POST['hint'.$n])) {
			$hinttext[] = $_POST['hint'.$n];
		}
	}
	$nhints = count($hinttext);
	
	//generate question code
	//this part stores the values in the question code, in form that makes
	//them easy to recover later.
	$code = '';
	if ($nparts==1) {
		$qtype = 'choices';
		$partialout = array();
		for ($i=0;$i<$qparts[0];$i++) {
			$code .= '$questions['.$i.'] = "'.str_replace('"','&quot;',$questions[0][$i]).'"'."\n";
			$code .= '$feedbacktxt['.$i.'] = "'.str_replace('"','&quot;',$feedbacktxt[0][$i]).'"'."\n";
			if ($partial[0][$i]!=0) {
				$partialout[] = $i;
				$partialout[] = $partial[0][$i];
			}
		}
		if (count($partialout)>0) {
			$code .= '$partialcredit = array('.implode(',',$partialout).')'."\n";
		}
		$code .= '$displayformat = "'.$_POST['qdisp0'].'"'."\n";
		$code .= '$answer = '.$answer[0]."\n\n";
	} else {
		$qtype = 'multipart';
		$code .= '$anstypes = "'.implode(',',array_fill(0,$nparts,"choices")).'"'."\n\n";
		for ($n=0;$n<$nparts;$n++) {
			$partialout = array();
			for ($i=0;$i<$qparts[$n];$i++) {
				$code .= '$questions['.$n.']['.$i.'] = "'.str_replace('"','&quot;',$questions[$n][$i]).'"'."\n";
				$code .= '$feedbacktxt['.$n.']['.$i.'] = "'.str_replace('"','&quot;',$feedbacktxt[$n][$i]).'"'."\n";
				if ($partial[$n][$i]!=0) {
					$partialout[] = $i;
					$partialout[] = $partial[$n][$i];
				}
			}
			if (count($partialout)>0) {
				$code .= '$partialcredit['.$n.'] = array('.implode(',',$partialout).')'."\n";
			}
			$code .= '$displayformat['.$n.'] = "'.$_POST['qdisp'.$n].'"'."\n";
			$code .= '$answer['.$n.'] = '.$answer[$n]."\n\n";
		}
	}
	for ($i=0;$i<$nhints;$i++) {
		$code .= '$hinttext['.$i.'] = "'.str_replace('"','&quot;',$hinttext[$i]).'"'."\n";
	}
	
	$code .= "\n//end stored values - Tutorial Style question\n\n";
	
	$code .= '$noshuffle = "all"'."\n";
	
	//now we convert as needed
	$qtextpre = '';
	
	//form hoverovers for hints
	if ($nhints>0) {
		$qtextpre .= '<p style="text-align: right">';
		for ($i=0;$i<$nhints;$i++) {
			$code .= '$hintlink['.$i.'] = formhoverover("Hint '.($i+1).'",$hinttext['.$i.'])'."\n";
			$qtextpre .= '$hintlink['.$i.'] ';
		}
		$qtextpre .= '</p>';
	}
	$code .= "\n";
	
	//form feedback text
	if ($nparts==1) {
		$code .= '$feedback = getfeedbacktxt($stuanswers[$thisq], $feedbacktxt, $answer)'."\n";
	} else {
		for ($n=0;$n<$nparts;$n++) {
			$code .= '$feedback['.$n.'] = getfeedbacktxt($stuanswers[$thisq]['.$n.'], $feedbacktxt['.$n.'], $answer['.$n.'])'."\n";
		}
	}
	$qtext = $qtextpre . $qtext;
	$code = addslashes($code);
	$qtext = addslashes($qtext);
	
	if ($id=='new') {
		$mt = microtime();
		$uqid = substr($mt,11).substr($mt,2,6);
		$ancestors = '';
		if (isset($_GET['templateid'])) {
			$query = "SELECT ancestors FROM imas_questionset WHERE id='{$_GET['templateid']}'";
			$result = mysql_query($query) or die("Query failed :$query " . mysql_error());
			$ancestors = mysql_result($result,0,0);
			if ($ancestors!='') {
				$ancestors = $_GET['templateid'] . ','. $ancestors;
			} else {
				$ancestors = $_GET['templateid'];
			}
		}
		$query = "INSERT INTO imas_questionset (uniqueid,adddate,lastmoddate,description,ownerid,author,userights,qtype,control,qtext,ancestors) VALUES ";
		$query .= "($uqid,$now,$now,'{$_POST['description']}','$userid','{$_POST['author']}','{$_POST['userights']}','$qtype','$code',";
		$query .= "'$qtext','$ancestors');";
		$result = mysql_query($query) or die("Query failed :$query " . mysql_error());
		$id = mysql_insert_id();
		$_GET['id'] = $id;
		if (isset($_GET['makelocal'])) {
			$query = "UPDATE imas_questions SET questionsetid='$qsetid' WHERE id='{$_GET['makelocal']}'";
			mysql_query($query) or die("Query failed :$query " . mysql_error());
			$editmsg .= " Local copy of Question Created ";
			$frompot = 0;
		} else {
			$editmsg .= " Question Added to QuestionSet. ";
			$frompot = 1;
		}
	} else {
		$isok = true;
		if ($isgrpadmin) {
			$query = "SELECT iq.id FROM imas_questionset AS iq,imas_users ";
			$query .= "WHERE iq.id='{$_GET['id']}' AND iq.ownerid=imas_users.id AND (imas_users.groupid='$groupid' OR iq.userights>2)";
			$result = mysql_query($query) or die("Query failed :$query " . mysql_error());
			if (mysql_num_rows($result)==0) {
				$isok = false;
			}
			//$query = "UPDATE imas_questionset AS iq,imas_users SET iq.description='{$_POST['description']}',iq.author='{$_POST['author']}',iq.userights='{$_POST['userights']}',";
			//$query .= "iq.qtype='{$_POST['qtype']}',iq.control='{$_POST['control']}',iq.qcontrol='{$_POST['qcontrol']}',";
			//$query .= "iq.qtext='{$_POST['qtext']}',iq.answer='{$_POST['answer']}',iq.lastmoddate=$now ";
			//$query .= "WHERE iq.id='{$_GET['id']}' AND iq.ownerid=imas_users.id AND (imas_users.groupid='$groupid' OR iq.userights>2)";
		}
		if (!$isadmin && !$isgrpadmin) {  //check is owner or is allowed to modify
			$query = "SELECT iq.id FROM imas_questionset AS iq,imas_users ";
			$query .= "WHERE iq.id='{$_GET['id']}' AND iq.ownerid=imas_users.id AND (iq.ownerid='$userid' OR (iq.userights=3 AND imas_users.groupid='$groupid') OR iq.userights>3)";
			$result = mysql_query($query) or die("Query failed :$query " . mysql_error());
			if (mysql_num_rows($result)==0) {
				$isok = false;
			}
		}
		if ($isok) {
			$_POST = addslashes_deep($_POST);
			
			$query = "UPDATE imas_questionset SET description='{$_POST['description']}',author='{$_POST['author']}',userights='{$_POST['userights']}',";
			$query .= "qtype='$qtype',control='$code',qtext='$qtext',lastmoddate=$now WHERE id='$id'";
			mysql_query($query) or die("Query failed :$query " . mysql_error());
		} 
	}
	if (!isset($_GET['aid'])) {
		$editmsg .=  "<a href=\"manageqset.php?cid=$cid\">Return to Question Set Management</a>\n";
	} else {
		if ($frompot==1) {
			$editmsg .=  "<a href=\"modquestion.php?qsetid=$id&cid=$cid&aid={$_GET['aid']}&process=true&usedef=true\">Add Question to Assessment using Defaults</a> | \n";
			$editmsg .=  "<a href=\"modquestion.php?qsetid=$id&cid=$cid&aid={$_GET['aid']}\">Add Question to Assessment</a> | \n";
		}
		$editmsg .=  "<a href=\"addquestions.php?cid=$cid&aid={$_GET['aid']}\">Return to Assessment</a>\n";
	}
	//update libraries
	$newlibs = explode(",",$_POST['libs']);
			
	if (in_array('0',$newlibs) && count($newlibs)>1) {
		array_shift($newlibs);
	}
	$qsetid = $id;
	if ($_POST['libs']=='') {
		$newlibs = array();
	}
	if ($isgrpadmin) {
		$query = "SELECT ili.libid FROM imas_library_items AS ili,imas_users WHERE ili.ownerid=imas_users.id ";
		$query .= "AND (imas_users.groupid='$groupid' OR ili.libid=0) AND ili.qsetid='$qsetid'";
	} else {
		/*
		$query = "SELECT libid FROM imas_library_items WHERE qsetid='$qsetid'";
		if (!$isadmin) {
			$query .= " AND (ownerid='$userid' OR libid=0)";
		}
		*/
		$query = "SELECT ili.libid FROM imas_library_items AS ili JOIN imas_libraries AS il ON ";
		$query .= "ili.libid=il.id OR ili.libid=0 WHERE ili.qsetid='$qsetid'";
		if (!$isadmin) {
			//unassigned, or owner and lib not closed or mine
			$query .= " AND ((ili.ownerid='$userid' AND (il.ownerid='$userid' OR il.userights%3<>1)) OR ili.libid=0)";
		}
	}
	$result = mysql_query($query) or die("Query failed :$query " . mysql_error());
	$existing = array();
	while($row = mysql_fetch_row($result)) { 
		$existing[] = $row[0]; 
	}  
	
	$toadd = array_values(array_diff($newlibs,$existing)); 
	$toremove = array_values(array_diff($existing,$newlibs));
	
	
	
	while(count($toremove)>0 && count($toadd)>0) { 
		$tochange = array_shift($toremove); 
		$torep = array_shift($toadd); 
		$query = "UPDATE imas_library_items SET libid='$torep' WHERE qsetid='$qsetid' AND libid='$tochange'";
		mysql_query($query) or die("Query failed :$query " . mysql_error());
	} 
	if (count($toadd)>0) { 
		foreach($toadd as $libid) { 
			$query = "INSERT INTO imas_library_items (libid,qsetid,ownerid) VALUES ('$libid','$qsetid','$userid')";
			mysql_query($query) or die("Query failed :$query " . mysql_error());
		} 
	} else if (count($toremove)>0) { 
		foreach($toremove as $libid) { 
			$query = "DELETE FROM imas_library_items WHERE libid='$libid' AND qsetid='$qsetid'";
			mysql_query($query) or die("Query failed :$query " . mysql_error());
		} 
	} 
	if (count($newlibs)==0) {
		$query = "SELECT id FROM imas_library_items WHERE qsetid='$qsetid'";
		$result = mysql_query($query) or die("Query failed :$query " . mysql_error());
		if (mysql_num_rows($result)==0) {
			$query = "INSERT INTO imas_library_items (libid,qsetid,ownerid) VALUES (0,'$qsetid','$userid')";
			mysql_query($query) or die("Query failed :$query " . mysql_error());
		}
	}
	
	$editmsg .= "<script>addr = '$imasroot/course/testquestion.php?cid=$cid&qsetid=$id';";
			//echo "function previewit() {";
	$editmsg .= "previewpop = window.open(addr,'Testing','width='+(.4*screen.width)+',height='+(.8*screen.height)+',scrollbars=1,resizable=1,status=1,top=20,left='+(.6*screen.width-20));\n";
	$editmsg .=  "previewpop.focus();";
	$editmsg .=  "</script>";
	
}

//return array (nparts, qparts, nhints, qdisp, questions, feedbacktxt, answer, hinttext)
function getqvalues($code,$type) {
	$partialcredit = array();
	$code = substr($code, 0, strpos($code,'//end stored'));
	eval(interpret('control',$type,$code));
	
	if (!isset($hinttext)) {
		$nhints = 0;
	} else {
		$nhints = count($hinttext);
	}
	if ($type=='multipart') {
		$nparts = count($questions);
		$qparts = array();
		for ($n=0;$n<$nparts;$n++) {
			$qparts[$n] = count($questions[$n]);
		}
		
		return array($nparts, $qparts, $nhints, $displayformat, $questions, $feedbacktxt, $answer, $hinttext, $partialcredit);
	} else {
		$qparts = array(count($questions));
		return array(1, $qparts, $nhints, array($displayformat), array($questions), array($feedbacktxt), array($answer), $hinttext, array($partialcredit));
	}
}

$query = "SELECT firstName,lastName FROM imas_users WHERE id='$userid'";
$result = mysql_query($query) or die("Query failed : $query" . mysql_error());
$row = mysql_fetch_row($result);
$myname = $row[1].','.$row[0];
	
if (isset($_GET['id']) && $_GET['id']!='new') {
	$id = intval($_GET['id']);
	
	$query = "SELECT imas_questionset.*,imas_users.groupid FROM imas_questionset,imas_users WHERE ";
	$query .= "imas_questionset.ownerid=imas_users.id AND imas_questionset.id='{$_GET['id']}'";
	$result = mysql_query($query) or die("Query failed : $query" . mysql_error());
	$line = mysql_fetch_array($result, MYSQL_ASSOC);
	
	$myq = ($line['ownerid']==$userid);
	if ($isadmin || ($isgrpadmin && $line['groupid']==$groupid) || ($line['userights']==3 && $line['groupid']==$groupid) || $line['userights']>3) {
		$myq = true;
	}
	$namelist = explode(", mb ",$line['author']);
	if ($myq && !in_array($myname,$namelist)) {
		$namelist[] = $myname;
	}
	if (isset($_GET['template'])) {
		$author = $myname;
		$myq = true;
	} else {
		$author = implode(", mb ",$namelist);
	}
	foreach ($line as $k=>$v) {
		$line[$k] = str_replace('&','&amp;',$v);
	}
	
	$inlibs = array();
	
	if (isset($_GET['template'])) {
		$query = "SELECT deflib,usedeflib FROM imas_users WHERE id='$userid'";
		$result = mysql_query($query) or die("Query failed : $query " . mysql_error());
		list($deflib,$usedeflib) = mysql_fetch_row($result);
		
		if (isset($_GET['makelocal'])) {
			$inlibs[] = $deflib;
			$line['description'] .= " (local for $userfullname)";
		} else {
			$line['description'] .= " (copy by $userfullname)";
			if ($usedeflib==1) {
				$inlibs[] = $deflib;
			} else {
				$query = "SELECT imas_libraries.id,imas_libraries.ownerid,imas_libraries.userights,imas_libraries.groupid ";
				$query .= "FROM imas_libraries,imas_library_items WHERE imas_library_items.libid=imas_libraries.id ";
				$query .= "AND imas_library_items.qsetid='{$_GET['id']}'";
				$result = mysql_query($query) or die("Query failed : $query " . mysql_error());
				while ($row = mysql_fetch_row($result)) {
					if ($row[2] == 8 || ($row[3]==$groupid && ($row[2]%3==2)) || $row[1]==$userid) {
						$inlibs[] = $row[0];
					}
				}
			}
		}
		/*$query = "SELECT imas_library_items.libid FROM imas_library_items,imas_libraries WHERE ";
		$query .= "imas_library_items.libid=imas_libraries.id AND (imas_libraries.ownerid=$userid OR imas_libraries.userights=2) ";
		$query .= "AND qsetid='{$_GET['id']}'";
		$result = mysql_query($query) or die("Query failed : $query" . mysql_error());
		while ($row = mysql_fetch_row($result)) {
			$inlibs[] = $row[0];	
		}*/
		$locklibs = array();
		$addmod = "Add";
		
		$query = "SELECT qrightsdef FROM imas_users WHERE id='$userid'";
		$result = mysql_query($query) or die("Query failed : " . mysql_error());
		$line['userights'] = mysql_result($result,0,0);
	
	} else {
		if ($isgrpadmin) {
			$query = "SELECT DISTINCT ili.libid FROM imas_library_items AS ili,imas_users WHERE ili.ownerid=imas_users.id ";
			$query .= "AND imas_users.groupid='$groupid' AND ili.qsetid='{$_GET['id']}'";
		} else {
			$query = "SELECT DISTINCT libid FROM imas_library_items WHERE qsetid='{$_GET['id']}'";
			if (!$isadmin) {
				$query .= " AND ownerid='$userid'";
			}
		}
		//$query = "SELECT libid FROM imas_library_items WHERE qsetid='{$_GET['id']}' AND imas_library_items.ownerid='$userid'";
		$result = mysql_query($query) or die("Query failed : $query" . mysql_error());
		while ($row = mysql_fetch_row($result)) {
			$inlibs[] = $row[0];	
		}
		
		$locklibs = array();
		if (!$isadmin) {
			if ($isgrpadmin) {
				$query = "SELECT ili.libid FROM imas_library_items AS ili,imas_users WHERE ili.ownerid=imas_users.id ";
				$query .= "AND imas_users.groupid!='$groupid' AND ili.qsetid='{$_GET['id']}'";
			} else if (!$isadmin) {
				$query = "SELECT libid FROM imas_library_items WHERE qsetid='{$_GET['id']}' AND imas_library_items.ownerid!='$userid'";
			}
			//$query = "SELECT libid FROM imas_library_items WHERE qsetid='{$_GET['id']}' AND imas_library_items.ownerid!='$userid'";
			$result = mysql_query($query) or die("Query failed : $query" . mysql_error());
			while ($row = mysql_fetch_row($result)) {
				$locklibs[] = $row[0];	
			}
		}
		$addmod = "Modify";
		
		$query = "SELECT count(imas_questions.id) FROM imas_questions,imas_assessments,imas_courses WHERE imas_assessments.id=imas_questions.assessmentid ";
		$query .= "AND imas_assessments.courseid=imas_courses.id AND imas_questions.questionsetid='{$_GET['id']}' AND imas_courses.ownerid<>'$userid'";
		$result = mysql_query($query) or die("Query failed : $query" . mysql_error());
		$inusecnt = mysql_result($result,0,0);
	}
	
	if (count($inlibs)==0 && count($locklibs)==0) {
		$inlibs = array(0);
	}
	$inlibs = implode(",",$inlibs);
	$locklibs = implode(",",$locklibs);
	
	
	
	$code = $line['control'];
	$type = $line['qtype'];
	$qtext = $line['qtext'];
	
	if (strpos($code,'//end stored')===false) {
		echo 'This question is not formatted in a way that allows it to be editted with this tool.';
		exit;
	}
	
	$mathfuncs = array("sin","cos","tan","sinh","cosh","tanh","arcsin","arccos","arctan","arcsinh","arccosh","sqrt","ceil","floor","round","log","ln","abs","max","min","count");
	$allowedmacros = $mathfuncs;
	require_once("../assessment/interpret5.php");
	list($nparts, $qparts, $nhints, $qdisp, $questions, $feedbacktxt, $answer, $hinttext, $partialcredit) = getqvalues($code,$type);
	$partial = array();
	for ($n=0;$n<$nparts;$n++) {
		$parial[$n] = array();
		for ($i=0;$i<count($partialcredit[$n]);$i+=2) {
			$partial[$n][$partialcredit[$n][$i]] = $partialcredit[$n][$i+1];
		}
	}
	if ($nhints>0) { //strip out hints para
		$qtext = substr($qtext, strpos($qtext,'</p>')+4);
	}
	
} else {
	$myq = true;
	$id = 'new';
	//new question
	$nparts = 1;
	$qparts = array(4,4,4,4,4);
	$answer = array(0,0,0,0,0);
	$qdisp = array("vert","vert","vert","vert","vert");
	$nhints = 1;
	$questions = array();
	$feedbacktxt = array();
	$hinttext = array();
	$qtext = "";
	
	$line['description'] = "Enter description here";
	$query = "SELECT qrightsdef FROM imas_users WHERE id='$userid'";
	$result = mysql_query($query) or die("Query failed : $query " . mysql_error());
	$line['userights'] = mysql_result($result,0,0);
	$line['author'] = $myname;
	$line['deleted'] = 0;
	if (isset($_GET['aid']) && isset($sessiondata['lastsearchlibs'.$_GET['aid']])) {
		$inlibs = $sessiondata['lastsearchlibs'.$_GET['aid']];
	} else if (isset($sessiondata['lastsearchlibs'.$cid])) {
		//$searchlibs = explode(",",$sessiondata['lastsearchlibs']);
		$inlibs = $sessiondata['lastsearchlibs'.$cid];
	} else {
		$inlibs = $userdeflib;
	}
	$locklibs='';
	
	$author = $myname;
	
	$inlibssafe = "'".implode("','",explode(',',$inlibs))."'";
	if (!isset($_GET['id']) || isset($_GET['template'])) {
		$query = "SELECT id,ownerid,userights,groupid FROM imas_libraries WHERE id IN ($inlibssafe)";
		$result = mysql_query($query) or die("Query failed : $query " . mysql_error());
		while ($row = mysql_fetch_row($result)) {
			if ($row[2] == 8 || ($row[3]==$groupid && ($row[2]%3==2)) || $row[1]==$userid) {
				$oklibs[] = $row[0];
			}
		}
		if (count($oklibs)>0) {
			$inlibs = implode(",",$oklibs);
		} else {$inlibs = '0';}
	}	
	
	$addmod = "Add";

}
$inlibssafe = "'".implode("','",explode(',',$inlibs))."'";
	
$lnames = array();
if (substr($inlibs,0,1)==='0') {
	$lnames[] = "Unassigned";
} 
$inlibssafe = "'".implode("','",explode(',',$inlibs))."'";
$query = "SELECT name FROM imas_libraries WHERE id IN ($inlibssafe)";
$result = mysql_query($query) or die("Query failed : " . mysql_error());
while ($row = mysql_fetch_row($result)) {
	$lnames[] = $row[0];
}
$lnames = implode(", ",$lnames);



function prepd($v) {
	$v = str_replace('&quot;','"',$v);
	return htmlentities($v, ENT_COMPAT | ENT_HTML401,"UTF-8", false );
}
$dispval = array("vert","horiz","select","inline","2column");
$displbl = array("Vertical list", "Horizontal list", "Pull-down", "Inline with text", "2 column");

$useeditor = "text";
require("../header.php");

if (isset($_GET['aid'])) {
	echo "<div class=breadcrumb>$breadcrumbbase <a href=\"course.php?cid={$_GET['cid']}\">$coursename</a> ";
	echo "&gt; <a href=\"addquestions.php?aid={$_GET['aid']}&cid={$_GET['cid']}\">Add/Remove Questions</a> &gt; Modify Questions</div>";

} else if (isset($_GET['daid'])) {
	echo "<div class=breadcrumb>$breadcrumbbase <a href=\"course.php?cid={$_GET['cid']}\">$coursename</a> ";
	echo "&gt; <a href=\"adddrillassess.php?daid={$_GET['daid']}&cid={$_GET['cid']}\">Add Drill Assessment</a> &gt; Modify Questions</div>";
} else {
	if ($_GET['cid']=="admin") {
		echo "<div class=breadcrumb>$breadcrumbbase <a href=\"../admin/admin.php\">Admin</a>";
		echo "&gt; <a href=\"manageqset.php?cid=admin\">Manage Question Set</a> &gt; Modify Question</div>\n";
	} else {
		echo "<div class=breadcrumb><a href=\"../index.php\">Home</a> ";
		if ($cid>0) {
			echo "&gt; <a href=\"course.php?cid=$cid\">$coursename</a>";
		}
		echo " &gt; <a href=\"manageqset.php?cid=$cid\">Manage Question Set</a> &gt; Modify Question</div>\n";
	}
	
}

echo '<div id="headermoddataset" class="pagetitle">';
echo "<h2>$addmod Tutorial Question</h2>\n";
echo '</div>';

if ($editmsg != '') {
	echo '<p>'.$editmsg.'</p>';
}
if ($line['deleted']==1) {
	echo '<p style="color:red;">This question has been marked for deletion.  This might indicate there is an error in the question. ';
	echo 'It is recommended you discontinue use of this question when possible</p>';
}

if (isset($inusecnt) && $inusecnt>0) {
	echo '<p style="color:red;">This question is currently being used in ';
	if ($inusecnt>1) {
		echo $inusecnt.' assessments that are not yours.  ';
	} else {
		echo 'one assessment that is not yours.  ';
	}
	echo 'In consideration of the other users, if you want to make changes other than minor fixes to this question, consider creating a new version of this question instead.  </p>';
	
}
if (isset($_GET['qid'])) {
	echo "<p><a href=\"moddataset.php?id={$_GET['id']}&cid=$cid&aid={$_GET['aid']}&template=true&makelocal={$_GET['qid']}\">Template this question</a> for use in this assessment.  ";
	echo "This will let you modify the question for this assessment only without affecting the library version being used in other assessments.</p>";
}
if (!$myq) {
	echo "<p>This question is not set to allow you to modify the code.  You can only view the code and make additional library assignments</p>";
}

?>

<script type="text/javascript">
function changenparts(el) {
	var np = el.value;
	for (var i=0;i<5;i++) {
		if (i<np) { 
			document.getElementById("partwrapper"+i).style.display="";
		} else {
			document.getElementById("partwrapper"+i).style.display="none";
		}
	}
	if (np==1) {
		document.getElementById("anstipsingle").style.display="";
		document.getElementById("anstipmult").style.display="none";
	} else {
		document.getElementById("anstipsingle").style.display="none";
		document.getElementById("anstipmult").style.display="";
	}
}
function changeqparts(n,el) {
	var np = el.value;
	for (var i=0;i<6;i++) {
		if (i<np) { 
			document.getElementById("qc"+n+"-"+i).style.display="";
		} else {
			document.getElementById("qc"+n+"-"+i).style.display="none";
		}
	}
}
function changehparts(el) {
	var np = el.value;
	for (var i=0;i<4;i++) {
		if (i<np) { 
			document.getElementById("hintwrapper"+i).style.display="";
		} else {
			document.getElementById("hintwrapper"+i).style.display="none";
		}
	}
}
</script>

<form enctype="multipart/form-data" method=post action="modtutorialq.php?process=true<?php 
	if (isset($_GET['cid'])) {
		echo "&cid=$cid";
	} 
	if (isset($_GET['aid'])) {
		echo "&aid={$_GET['aid']}";
	}
	if (isset($_GET['id']) && !isset($_GET['template'])) {
		echo "&id={$_GET['id']}";
	}
	if (isset($_GET['template'])) {
		echo "&templateid={$_GET['id']}";
	}
	if (isset($_GET['makelocal'])) {
		echo "&makelocal={$_GET['makelocal']}";
	}
	if ($frompot==1) {
		echo "&frompot=1";
	}
?>">

<p>
Description:<BR> 
<textarea cols=60 rows=4 name=description <?php if (!$myq) echo "readonly=\"readonly\"";?>><?php echo $line['description'];?></textarea>
</p>
<p>
Author: <?php echo $line['author']; ?> <input type="hidden" name="author" value="<?php echo $author; ?>">
</p>
<p>
<?php
if (!isset($line['ownerid']) || isset($_GET['template']) || $line['ownerid']==$userid || ($line['userights']==3 && $line['groupid']==$groupid) || $isadmin || ($isgrpadmin && $line['groupid']==$groupid)) {
	echo "Use Rights <select name=userights>\n";
	echo "<option value=\"0\" ";
	if ($line['userights']==0) {echo "SELECTED";}
	echo ">Private</option>\n";
	echo "<option value=\"2\" ";
	if ($line['userights']==2) {echo "SELECTED";}
	echo ">Allow use, use as template, no modifications</option>\n";
	echo "<option value=\"3\" ";
	if ($line['userights']==3) {echo "SELECTED";}
	echo ">Allow use by all and modifications by group</option>\n";
	echo "<option value=\"4\" ";
	if ($line['userights']==4) {echo "SELECTED";}
	echo ">Allow use and modifications by all</option>\n";
}
?>
</select>
</p>
<script>
var curlibs = '<?php echo $inlibs;?>';
var locklibs = '<?php echo $locklibs;?>';
function libselect() {
	window.open('libtree.php?libtree=popup&cid=<?php echo $cid;?>&selectrights=1&libs='+curlibs+'&locklibs='+locklibs,'libtree','width=400,height='+(.7*screen.height)+',scrollbars=1,resizable=1,status=1,top=20,left='+(screen.width-420));
}
function setlib(libs) {
	if (libs.charAt(0)=='0' && libs.indexOf(',')>-1) {
		libs = libs.substring(2);
	}
	document.getElementById("libs").value = libs;
	curlibs = libs;
}
function setlibnames(libn) {
	if (libn.indexOf('Unassigned')>-1 && libn.indexOf(',')>-1) {
		libn = libn.substring(11);
	}
	document.getElementById("libnames").innerHTML = libn;
}
</script>
<p>
My library assignments: <span id="libnames"><?php echo $lnames;?></span><input type=hidden name="libs" id="libs" size="10" value="<?php echo $inlibs;?>">
<input type=button value="Select Libraries" onClick="libselect()">
</p>

<p>This question has 
<?php
	writeHtmlSelect("nparts",range(1,5),range(1,5), $nparts,null,null,'onchange="changenparts(this)"');
?>
parts.</p>

<?php
for ($n=0;$n<5;$n++) {
	if (!isset($qparts[$n])) { $qparts[$n] = 4;}
	echo '<div id="partwrapper'.$n.'"';
	if ($n>=$nparts) {echo ' style="display:none;"';};
	echo '>';
	
	echo '<h4>Part '.($n).' Question</h4>';
	echo '<p>This part has ';
	writeHtmlSelect("qparts$n",range(2,6),range(2,6), $qparts[$n],null,null,'onchange="changeqparts('.$n.',this)"');
	echo 'choices.  Display those ';
	writeHtmlSelect("qdisp$n",$dispval,$displbl, $qdisp[$n]);
	echo '</p>';
	echo '<table class="choicetbl"><thead><tr><th>Correct</th><th>Choice</th><th>Feedback</th><th>Partial Credit (0-1)</th></tr></thead><tbody>';
	for ($i=0;$i<6;$i++) {
		echo '<tr id="qc'.$n.'-'.$i.'" ';
		if ($i>=$qparts[$n]) {echo ' style="display:none;"';};
		echo '><td><input type="radio" name="ans'.$n.'" value="'.$i.'" ';
		if ($i==$answer[$n]) {echo 'checked="checked"';}
		echo '/></td>';
		echo '<td><input autocomplete="off" name="txt'.$n.'-'.$i.'" type="text" size="60" value="'.(isset($questions[$n][$i])?prepd($questions[$n][$i]):"").'"/></td>';
		echo '<td><input autocomplete="off" name="fb'.$n.'-'.$i.'" type="text" size="60" value="'.(isset($feedbacktxt[$n][$i])?prepd($feedbacktxt[$n][$i]):"").'"/></td>';
		echo '<td><input autocomplete="off" name="pc'.$n.'-'.$i.'" type="text" size="3" value="'.(isset($partial[$n][$i])?$partial[$n][$i]:"").'"/></td>';
		
		echo '</tr>';
	}
	echo '</tbody></table>';
	echo '</div>';
}

echo '<h4>Hints</h4>';
echo '<p>This question has ';
writeHtmlSelect("nhints",range(0,4),range(0,4), $nhints,null,null,'onchange="changehparts(this)"');
echo 'hints.</p>';
for ($n=0;$n<4;$n++) {
	echo '<p id="hintwrapper'.$n.'"';
	if ($n>=$nhints) {echo ' style="display:none;"';};
	echo '>Hint '.($n+1).':';
	echo '<input autocomplete="off" name="hint'.$n.'" type="text" size="80" value="'.(isset($hinttext[$n])?prepd($hinttext[$n]):"").'"/></p>';
}

echo '<h4>Question Text</h4>';
echo '<p>In the question text, enter <span id="anstipsingle" ';
if ($nparts!=1) {echo 'style="display:none;" ';}
echo '><b>$answerbox</b> to place the question list into the question.  Enter <b>$feedback</b> to indicate where the feedback should be displayed.</span> <span id="anstipmult" ';
if ($nparts==1) {echo 'style="display:none;" ';}
echo '><b>$answerbox[0]</b> to place the question list for Part 0, <b>$answerbox[1]</b> to place the question list for Part 1, and so on.  Similarly, ';
echo 'enter <b>$feedback[0]</b> to indicate where the feedback for Part 0 should be displayed, and so on.</span></p>';

?>

<div class=editor>
	<textarea cols="60" rows="20" id="text" name="text" style="width: 100%"><?php echo htmlentities($qtext);?></textarea>
</div>

<p><input type="submit" value="Save and Test"/></p>
<p>&nbsp;</p>

</form>
<?php
	require("../footer.php");
?>
