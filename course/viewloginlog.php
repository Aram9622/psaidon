<?php
//IMathAS:  View login record
//(c) 2011 David Lippman

require("../validate.php");
$cid = intval($_GET['cid']);
if (!isset($teacherid)) {
	$uid = $userid;
} else {
	$uid = intval($_GET['uid']);
}

$curBreadcrumb = "$breadcrumbbase <a href=\"course.php?cid=$cid\"> $coursename</a>\n";
if (isset($teacherid)) {
	$curBreadcrumb .= " &gt; <a href=\"listusers.php?cid=$cid\">Roster</a> ";
}
$curBreadcrumb .= "&gt; View Login Log\n";	
$pagetitle = "View Login Log";
require("../header.php");
echo "<div class=\"breadcrumb\">$curBreadcrumb</div>";
echo '<div id="headerloginlog" class="pagetitle"><h2>'.$pagetitle. '</h2></div>';

$query = "SELECT LastName,FirstName FROM imas_users WHERE id='$uid'";
$result = mysql_query($query) or die("Query failed : " . mysql_error());
$row = mysql_fetch_row($result);
echo '<h3>Login Log for '.$row[1].', '.$row[0].'</h3>';
echo '<ul class="nomark">';

$query = "SELECT logintime FROM imas_login_log WHERE userid='$uid' AND courseid='$cid' ORDER BY logintime DESC";
$result = mysql_query($query) or die("Query failed : " . mysql_error());
while ($row = mysql_fetch_row($result)) {
	echo '<li>'.tzdate("l, F j, Y, g:i a",$row[0]).'</li>';
}

echo '</ul>';
require("../footer.php");

?>
