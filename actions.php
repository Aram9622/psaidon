<?php
	//IMathAS:  Basic Actions
	//(c) 20006 David Lippman
	if (isset($_GET['greybox'])) {
		$isgb = true;
		$gb = '&greybox=true';
		$flexwidth = true;
		$nologo = true;
	} else {
		$isgb = false;
		$gb = '';
	}
	if((isset($_SERVER['HTTPS']) && $_SERVER['HTTPS']=='on') || (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO']=='https'))  {
		 $urlmode = 'https://';
	} else {
		 $urlmode = 'http://';
	}
	require_once("includes/password.php");
	
	if ($_GET['action']=="newuser") {
		require_once("config.php");
		$error = '';
		if (isset($studentTOS) && !isset($_POST['agree'])) {
			$error = "<p>You must agree to the Terms and Conditions to set up an account</p>";
		}
		$_POST['SID'] = trim($_POST['SID']);
		if ($loginformat!='' && !preg_match($loginformat,$_POST['SID'])) {
			$error .= "<p>$loginprompt is invalid.</p>";
		}
		$query = "SELECT id FROM imas_users WHERE SID='{$_POST['SID']}'";
		$result = mysql_query($query) or die("Query failed : " . mysql_error());
		if (mysql_num_rows($result)>0) {
			$error .= "<p>$loginprompt '{$_POST['SID']}' is used. </p>";
		}
		//
		if (!preg_match('/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/',$_POST['email'])) {
			$error .= "<p>Invalid email address.</p>";
		}
		if ($_POST['pw1'] != $_POST['pw2']) {
			$error .= "<p>Passwords don't match. </p>";
		}
		if ($_POST['SID']=="" || $_POST['firstname']=="" || $_POST['lastname']=="" || $_POST['email']=="" || $_POST['pw1']=="") {
			$error .= "<p>Please include all information.</p>";
		}
		if ($error != '') {
			require("header.php");
			if ($gb == '') {
				echo "<div class=breadcrumb><a href=\"index.php\">Home</a> &gt; New User Signup</div>\n";
			}
			echo '<div id="headerforms" class="pagetitle"><h2>New User Signup</h2></div>';
			echo $error;
			echo '<p><a href="forms.php?action=newuser">Try Again</a></p>';
			require("footer.php");
			exit;
		}
		
		if (isset($CFG['GEN']['newpasswords'])) {
			$md5pw = password_hash($_POST['pw1'], PASSWORD_DEFAULT);
		} else {
			$md5pw = md5($_POST['pw1']);
		}
		if ($emailconfirmation) {$initialrights = 0;} else {$initialrights = 10;}
		if (isset($_POST['msgnot'])) {
			$msgnot = 1;
		} else {
			$msgnot = 0;
		}
		if (isset($CFG['GEN']['homelayout'])) {
			$homelayout = $CFG['GEN']['homelayout'];
		} else {
			$homelayout = '|0,1,2||0,1';
		}
		if (isset($_POST['courseselect']) && $_POST['courseselect']>0) {
			$_POST['courseid'] = $_POST['courseselect'];
			$_POST['ekey'] = '';
		}
		if (!isset($_GET['confirmed'])) {
			$query = "SELECT SID FROM imas_users WHERE email='{$_POST['email']}'";
			$result = mysql_query($query) or die("Query failed : " . mysql_error());
			if (mysql_num_rows($result)>0) {
				$nologo = true;
				require("header.php");
				echo '<form method="post" action="actions.php?action=newuser&amp;confirmed=true'.$gb.'">';
				echo '<input type="hidden" name="SID" value="'.stripslashes($_POST['SID']).'" />';
				echo '<input type="hidden" name="firstname" value="'.stripslashes($_POST['firstname']).'" />';
				echo '<input type="hidden" name="lastname" value="'.stripslashes($_POST['lastname']).'" />';
				echo '<input type="hidden" name="email" value="'.stripslashes($_POST['email']).'" />';
				echo '<input type="hidden" name="pw1" value="'.stripslashes($_POST['pw1']).'" />';
				echo '<input type="hidden" name="pw2" value="'.stripslashes($_POST['pw2']).'" />';
				echo '<input type="hidden" name="courseid" value="'.stripslashes($_POST['courseid']).'" />';
				echo '<input type="hidden" name="ekey" value="'.stripslashes($_POST['ekey']).'" />';
				if (isset($_POST['agree'])) {
					echo '<input type="hidden" name="agree" value="1" />';
				}
				echo '<p> </p>';
				echo '<p>It appears an account already exists with the same email address you just entered. ';
				echo 'If you are creating an account because you forgot your username, you can ';
				echo '<a href="forms.php?action=lookupusername">look up your username</a> instead.</p>';
				echo '<input type="submit" value="Create new account anyways"/>';
				echo '</form>';
				require("footer.php");
				exit;
			}
		}
		$query = "INSERT INTO imas_users (SID, password, rights, FirstName, LastName, email, msgnotify, homelayout) ";
		$query .= "VALUES ('{$_POST['SID']}','$md5pw',$initialrights,'{$_POST['firstname']}','{$_POST['lastname']}','{$_POST['email']}',$msgnot,'$homelayout');";
		mysql_query($query) or die("Query failed : " . mysql_error());
		$newuserid = mysql_insert_id();
		if ($emailconfirmation) {
			$id = mysql_insert_id();
			$headers  = 'MIME-Version: 1.0' . "\r\n";
			$headers .= 'Content-type: text/html; charset=iso-8859-1' . "\r\n";
			$headers .= "From: $sendfrom\r\n";
			$message  = "<h4>This is an automated message from $installname.  Do not respond to this email</h4>\r\n";
			$message .= "<p>To complete your $installname registration, please click on the following link, or copy ";
			$message .= "and paste it into your webbrowser:</p>\r\n";
			$message .= "<a href=\"" . $urlmode . $_SERVER['HTTP_HOST'] . rtrim(dirname($_SERVER['PHP_SELF']), '/\\') . "/actions.php?action=confirm&id=$id\">";
			$message .= $urlmode . $_SERVER['HTTP_HOST'] . rtrim(dirname($_SERVER['PHP_SELF']), '/\\') . "/actions.php?action=confirm&id=$id</a>\r\n";
			mail($_POST['email'],'IMathAS Confirmation',$message,$headers);
			require("header.php");
			if ($gb == '') {
				echo "<div class=breadcrumb><a href=\"index.php\">Home</a> &gt; New User Signup</div>\n";
			}
			echo '<div id="headerforms" class="pagetitle"><h2>New User Signup</h2></div>';
			echo "Registration recorded.  You should shortly receive an email with confirmation instructions.";
			echo "<a href=\"$imasroot/index.php\">Back to main login page</a>\n";
			require("footer.php");
			exit;
			
		} else {
			$pagetitle = 'Account Created';
			require("header.php");
			echo "<div class=breadcrumb><a href=\"index.php\">Home</a> &gt; New User Signup</div>\n";
			echo '<div id="headerforms" class="pagetitle"><h2>New User Signup</h2></div>';
			echo "<p>Your account with username <b>{$_POST['SID']}</b> has been created.  If you forget your password, you can ask your ";
			echo "instructor to reset your password or use the forgotten password link on the login page.</p>\n";
			if (trim($_POST['courseid'])!='') {
				$error = '';
				
				if (!is_numeric($_POST['courseid'])) {
					$error = 'Invalid course id';
				} else {
					$query = "SELECT enrollkey,allowunenroll,deflatepass FROM imas_courses WHERE id = '{$_POST['courseid']}' AND (available=0 OR available=2)";
					$result = mysql_query($query) or die("Query failed : " . mysql_error());
					$line = mysql_fetch_array($result, MYSQL_ASSOC);
					if ($line==null) {
						$error = 'Course not found';
					} else if (($line['allowunenroll']&2)==2) {
						$error = 'Course is closed for self enrollment';
					} else if ($_POST['ekey']=="" && $line['enrollkey'] != '') {
						$error = 'No enrollment key provided';
					} else {
						$keylist = array_map('strtolower',array_map('trim',explode(';',$line['enrollkey'])));
						if (!in_array(strtolower(trim($_POST['ekey'])), $keylist)) {
							$error = 'Incorrect enrollment key';
						} else {
							if (count($keylist)>1) {
								$query = "INSERT INTO imas_students (userid,courseid,section,latepass) VALUES ('$newuserid','{$_POST['courseid']}','{$_POST['ekey']}','{$line['deflatepass']}');";
							} else {
								$query = "INSERT INTO imas_students (userid,courseid,latepass) VALUES ('$newuserid','{$_POST['courseid']}','{$line['deflatepass']}');";
							}
							mysql_query($query) or die("Query failed : " . mysql_error());
							echo '<p>You have been enrolled in course ID '.$_POST['courseid'].'</p>';
						}
					}
				}
				if ($error != '') {
					echo "<p>$error, so we were not able to enroll you in your course.  After you log in, you can ";
					echo 'try enrolling again.  You do <b>not</b> need to create another account.</p>';
				}
			}
					
				
			echo "You can now <a href=\"";
			echo $urlmode . $_SERVER['HTTP_HOST'] . rtrim(dirname($_SERVER['PHP_SELF']), '/\\') . "/index.php";
			echo "\">return to the login page</a> and login with your new username and password</p>";
			require("footer.php");
		}
		//header('Location: ' . $urlmode  . $_SERVER['HTTP_HOST'] . rtrim(dirname($_SERVER['PHP_SELF']), '/\\') . "/index.php");
		exit;
	} else if ($_GET['action']=="confirm") {
		require_once("config.php");
		$query = "UPDATE imas_users SET rights=10 WHERE id='{$_GET['id']}' AND rights=0";
		mysql_query($query) or die("Query failed : " . mysql_error());
		if (mysql_affected_rows()>0) {
			require("header.php");
			echo "Confirmed.  Please <a href=\"index.php\">Log In</a>\n";
			require("footer.php");	
			exit;
		} else {
			require("header.php");
			echo "Error.\n";
			require("footer.php");
		}
	} else if ($_GET['action']=="resetpw") {
		require_once("config.php");
		if (isset($_POST['username'])) {
			$query = "SELECT id,email,rights FROM imas_users WHERE SID='{$_POST['username']}'";
			$result = mysql_query($query) or die("Query failed : " . mysql_error());
			if (mysql_num_rows($result)>0) {
				list($id,$email,$rights) = mysql_fetch_row($result);
				
				$chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
				$code = '';
				for ($i=0;$i<10;$i++) {
					$code .= substr($chars,rand(0,61),1);
				}	
				$query = "UPDATE imas_users SET remoteaccess='$code' WHERE id=$id";
				mysql_query($query) or die("Query failed : " . mysql_error());
				
				$headers  = 'MIME-Version: 1.0' . "\r\n";
				$headers .= 'Content-type: text/html; charset=iso-8859-1' . "\r\n";
				$headers .= "From: $sendfrom\r\n";
				$message  = "<h4>This is an automated message from $installname.  Do not respond to this email</h4>\r\n";
				$message .= "<p>Your username was entered in the Reset Password page.  If you did not do this, you may ignore and delete this message. ";
				$message .= "If you did request a password reset, click the link below, or copy and paste it into your browser's address bar.  You ";
				$message .= "will then be prompted to choose a new password.</p>";
				$message .= "<a href=\"" .$urlmode. $_SERVER['HTTP_HOST'] . rtrim(dirname($_SERVER['PHP_SELF']), '/\\') . "/actions.php?action=resetpw&id=$id&code=$code\">";
				$message .= $urlmode . $_SERVER['HTTP_HOST'] . rtrim(dirname($_SERVER['PHP_SELF']), '/\\') . "/actions.php?action=resetpw&id=$id&code=$code</a>\r\n";
				mail( $email,'Password Reset Request',$message,$headers);
				
				require("header.php");
				echo '<p>An email with a password reset link has been sent your email address on record: <b>'.$email.'.</b><br/> ';
				echo 'If you do not see it in a few minutes, check your spam or junk box to see if the email ended up there.<br/>';
				echo 'It may help to add <b>'.$sendfrom.'</b> to your contacts list.</p>';
				echo '<p>If you still have trouble or the wrong email address is on file, contact your instructor - they can reset your password for you.</p>';
				require("footer.php");
				exit;
			} else {
				echo "Invalid Username.  <a href=\"index.php$gb\">Try again</a>";
				exit;
			}
			header('Location: ' . $urlmode  . $_SERVER['HTTP_HOST'] . rtrim(dirname($_SERVER['PHP_SELF']), '/\\') . "/index.php");
		} else if (isset($_POST['pw1'])) {
			if ($_POST['pw1']!=$_POST['pw2']) {
				echo 'Passwords do not match.  <a href="actions.php?action=resetpw&code='.$_POST['code'].'&id='.$_POST['id'].'">Try again</a>';
				exit;
			}
			$query = "SELECT remoteaccess FROM imas_users WHERE id='{$_POST['id']}'";
			$result = mysql_query($query) or die("Query failed : " . mysql_error());
			$realcode = mysql_result($result,0,0);
			if (mysql_num_rows($result)>0 && $_POST['code']===$realcode && $realcode!='') {
				if (isset($CFG['GEN']['newpasswords'])) {
					$newpw = password_hash($_POST['pw1'], PASSWORD_DEFAULT);
				} else {
					$newpw = md5($_POST['pw1']);
				}
				$query = "UPDATE imas_users SET password='$newpw',remoteaccess='' WHERE id='{$_POST['id']}' LIMIT 1";
				mysql_query($query) or die("Query failed : " . mysql_error());
				echo "Password Reset.  ";
				echo "<a href=\"index.php\">Login with your new password</a>";
			} else {
				echo 'Invalid code';
			}
			exit;
		} else if (isset($_GET['code'])) {
			$query = "SELECT remoteaccess FROM imas_users WHERE id='{$_GET['id']}'";
			$result = mysql_query($query) or die("Query failed : " . mysql_error());
			$realcode = mysql_result($result,0,0);
			if (mysql_num_rows($result)>0 && $_GET['code']===$realcode && $realcode!='') {
				echo '<html><body><form method="post" action="actions.php?action=resetpw">';
				echo '<input type="hidden" name="code" value="'.$_GET['code'].'"/>';
				echo '<input type="hidden" name="id" value="'.$_GET['id'].'"/>';
				echo '<p>Please select a new password:</p>';
				echo '<p>Enter new password:  <input type="password" size="25" name="pw1"/><br/>';
				echo '<p>Verify new password:  <input type="password" size="25" name="pw2"/></p>';
				echo '<p><input type="submit" value="Submit"/></p>';
				echo '</form>';
				echo '</body></html>';
				exit;
			} else {
				echo '<html><body>Invalid reset code.  If you have requested a password reset multiple times, you need the link from ';
				echo 'the most recent email.</body></html>';
				exit;
			}
				
		}
	} else if ($_GET['action']=="lookupusername") {    
		require_once("config.php");
		$query = "SELECT SID,lastaccess FROM imas_users WHERE email='{$_POST['email']}'";
		$result = mysql_query($query) or die("Query failed : " . mysql_error());
		if (mysql_num_rows($result)>0) {
			echo mysql_num_rows($result);
			echo " usernames match this email address and were emailed.  <a href=\"index.php\">Return to login page</a>";
			$headers  = 'MIME-Version: 1.0' . "\r\n";
			$headers .= 'Content-type: text/html; charset=iso-8859-1' . "\r\n";
			$headers .= "From: $sendfrom\r\n";
			$message  = "<h4>This is an automated message from $installname.  Do not respond to this email</h4>\r\n";
			$message .= "<p>Your email was entered in the Username Lookup page on $installname.  If you did not do this, you may ignore and delete this message.  ";
			$message .= "All usernames using this email address are listed below</p><p>";
			while ($row = mysql_fetch_row($result)) {
				if ($row[1]==0) {
					$lastlogin = "Never";
				} else {
					$lastlogin = date("n/j/y g:ia",$row[1]);
				}
				$message .= "Username: <b>{$row[0]}</b>.  Last logged in: $lastlogin<br/>";
			}
			$message .= "</p><p>If you forgot your password, use the Lost Password link at the login page.</p>";
			mail($_POST['email'],"$installname Username Request",$message,$headers);
			exit;
		} else {
			echo "No usernames match this email address.  <a href=\"index.php\">Return to login page</a>";
			exit;
		}
	}
	
	require("validate.php");
	if ($_GET['action']=="logout") {
		$sessionid = session_id();
		$query = "DELETE FROM imas_sessions WHERE sessionid='$sessionid'";
		mysql_query($query) or die("Query failed : " . mysql_error());
		$_SESSION = array();
		if (isset($_COOKIE[session_name()])) {
			setcookie(session_name(), '', time()-42000, '/');
		}
		session_destroy();
	} else if ($_GET['action']=="chgpwd") {
		$query = "SELECT password FROM imas_users WHERE id = '$userid'";
		$result = mysql_query($query) or die("Query failed : " . mysql_error());
		$line = mysql_fetch_array($result, MYSQL_ASSOC);  
		if ((md5($_POST['oldpw'])==$line['password'] || (isset($CFG['GEN']['newpasswords']) && password_verify($_POST['oldpw'],$line['password']))) && ($_POST['newpw1'] == $_POST['newpw2']) && $myrights>5) {
			if (isset($CFG['GEN']['newpasswords'])) {
				$md5pw = password_hash($_POST['newpw1'], PASSWORD_DEFAULT);
			} else {
				$md5pw =md5($_POST['newpw1']);
			}
			$query = "UPDATE imas_users SET password='$md5pw' WHERE id='$userid'";
			mysql_query($query) or die("Query failed : " . mysql_error()); 
		} else {
			echo "<html><body>Password change failed.  <A HREF=\"forms.php?action=chgpwd$gb\">Try Again</a>\n";
			echo "</body></html>\n";
			exit;
		}
		
	} else if ($_GET['action']=="enroll") {
		if ($myrights < 6) {
			echo "<html><body>\nError: Guests can't enroll in courses</body></html";
			exit;
		}
		if (isset($_POST['courseselect']) && $_POST['courseselect']>0) {
			$_POST['cid'] = $_POST['courseselect'];
			$_POST['ekey'] = '';
		}
		$pagetopper = '';
		if ($gb == '') {
			$pagetopper .= "<div class=breadcrumb><a href=\"index.php\">Home</a> &gt; Enroll in a Course</div>\n";
		}
		$pagetopper .= '<div id="headerforms" class="pagetitle"><h2>Enroll in a Course</h2></div>';
		if ($_POST['cid']=="" || !is_numeric($_POST['cid'])) {
			require("header.php");
			echo $pagetopper;
			echo "Please include Course ID.  <a href=\"forms.php?action=enroll$gb\">Try Again</a>\n";
			require("footer.php");
			exit;
		}
		$query = "SELECT enrollkey,allowunenroll,deflatepass FROM imas_courses WHERE id = '{$_POST['cid']}' AND (available=0 OR available=2)";
		$result = mysql_query($query) or die("Query failed : " . mysql_error());
		$line = mysql_fetch_array($result, MYSQL_ASSOC);
		if ($line == null) {
			require("header.php");
			echo $pagetopper;
			echo "Course not found.  <a href=\"forms.php?action=enroll$gb\">Try Again</a>\n";
			require("footer.php");
			exit;
		} else if (($line['allowunenroll']&2)==2) {
			require("header.php");
			echo $pagetopper;
			echo "Course is closed for self enrollment.  Contact your instructor for access.  <a href=\"index.php\">Return to home page.</a>\n";
			require("footer.php");
			exit;
		} else if ($_POST['ekey']=="" && $line['enrollkey'] != '') {
			require("header.php");
			echo $pagetopper;
			echo "Please include Enrollment Key.  <a href=\"forms.php?action=enroll$gb\">Try Again</a>\n";
			require("footer.php");
			exit;
		}  else {
			$query = "SELECT * FROM imas_teachers WHERE userid='$userid' AND courseid='{$_POST['cid']}'";
			$result = mysql_query($query) or die("Query failed : " . mysql_error());
			if (mysql_num_rows($result)>0) {
				require("header.php");
				echo $pagetopper;
				echo "You are a teacher for this course, and can't enroll as a student.  Use Student View to see ";
				echo "the class from a student's perspective, or create a dummy student account.  ";
				echo "Click on the course name on the <a href=\"index.php\">main page</a> to access the course\n";
				require("footer.php");
				exit;
			}
			$query = "SELECT * FROM imas_tutors WHERE userid='$userid' AND courseid='{$_POST['cid']}'";
			$result = mysql_query($query) or die("Query failed : " . mysql_error());
			if (mysql_num_rows($result)>0) {
				require("header.php");
				echo $pagetopper;
				echo "You are a tutor for this course, and can't enroll as a student. ";
				echo "Click on the course name on the <a href=\"index.php\">main page</a> to access the course\n";
				require("footer.php");
				exit;
			}
			$query = "SELECT * FROM imas_students WHERE userid='$userid' AND courseid='{$_POST['cid']}'";
			$result = mysql_query($query) or die("Query failed : " . mysql_error());
			if (mysql_num_rows($result)>0) {
				require("header.php");
				echo $pagetopper;
				echo "You are already enrolled in the course.  Click on the course name on the <a href=\"index.php\">main page</a> to access the course\n";
				require("footer.php");
				exit;
			} else {
				$keylist = array_map('strtolower',array_map('trim',explode(';',$line['enrollkey'])));
				if (!in_array(strtolower(trim($_POST['ekey'])), $keylist)) {		
					require("header.php");
					echo $pagetopper;
					echo "Incorrect Enrollment Key.  <a href=\"forms.php?action=enroll$gb\">Try Again</a>\n";
					require("footer.php");
					exit;
				} else {
					if (count($keylist)>1) {
						$query = "INSERT INTO imas_students (userid,courseid,section,latepass) VALUES ('$userid','{$_POST['cid']}','{$_POST['ekey']}','{$line['deflatepass']}');";
					} else {
						$query = "INSERT INTO imas_students (userid,courseid,latepass) VALUES ('$userid','{$_POST['cid']}','{$line['deflatepass']}');";
					}
					mysql_query($query) or die("Query failed : " . mysql_error());
					require("header.php");
					echo $pagetopper;
					echo '<p>You have been enrolled in course ID '.$_POST['cid'].'</p>';
					echo "<p>Return to the <a href=\"index.php\">main page</a> and click on the course name to access the course</p>";
					require("footer.php");
					exit;
				}
				
				
				//$query = "INSERT INTO imas_students (userid,courseid) VALUES ('$userid','{$_POST['cid']}');";
				//mysql_query($query) or die("Query failed : " . mysql_error());
			}
		}	
	} else if ($_GET['action']=="unenroll") {
		if ($myrights < 6) {
			echo "<html><body>\nError: Guests can't unenroll from courses</body></html";
			exit;
		}
		if (!isset($_GET['cid'])) {
			require("header.php");
			echo "Course ID not specified.  <a href=\"index.php\">Try Again</a>\n";
			require("footer.php");
			exit;
		}
		$cid = $_GET['cid'];
		$query = "SELECT allowunenroll FROM imas_courses WHERE id='$cid'";
		$result = mysql_query($query) or die("Query failed : " . mysql_error());
		if (mysql_result($result,0,0)==1) {
			$query = "DELETE FROM imas_students WHERE userid='$userid' AND courseid='$cid'";
			mysql_query($query) or die("Query failed : " . mysql_error());
			$query = "SELECT id FROM imas_assessments WHERE courseid='$cid'";
			$result = mysql_query($query) or die("Query failed : " . mysql_error());
			while ($row = mysql_fetch_row($result)) {
				$query = "DELETE FROM imas_assessment_sessions WHERE assessmentid='{$row[0]}' AND userid='$userid'";
				mysql_query($query) or die("Query failed : " . mysql_error());
				$query = "DELETE FROM imas_exceptions WHERE assessmentid='{$row[0]}' AND userid='$userid'";
				mysql_query($query) or die("Query failed : " . mysql_error());
			}
			
			$query = "DELETE FROM imas_drillassess_sessions WHERE drillassessid IN (SELECT id FROM imas_drillassess WHERE courseid='$cid') AND userid='$userid'";
			mysql_query($query) or die("Query failed : $query" . mysql_error());
			
			$query = "SELECT id FROM imas_gbitems WHERE courseid='$cid'";
			$result = mysql_query($query) or die("Query failed : " . mysql_error());
			while ($row = mysql_fetch_row($result)) {
				$query = "DELETE FROM imas_grades WHERE gradetype='offline' AND gradetypeid='{$row[0]}' AND userid='$userid'";
				mysql_query($query) or die("Query failed : " . mysql_error());
			}
			$query = "SELECT id FROM imas_forums WHERE courseid='$cid'";
			$result = mysql_query($query) or die("Query failed : " . mysql_error());
			while ($row = mysql_fetch_row($result)) {
				$q2 = "SELECT threadid FROM imas_forum_posts WHERE forumid='{$row[0]}'";
				$r2 = mysql_query($q2) or die("Query failed : " . mysql_error());
				while ($rw2 = mysql_fetch_row($r2)) {
					$query = "DELETE FROM imas_forum_views WHERE threadid='{$rw2[0]}' AND userid='$userid'";
					mysql_query($query) or die("Query failed : " . mysql_error());
				}
			}
		}
	} else if ($_GET['action']=="chguserinfo") {
		$pagetopper = '';
		if ($gb == '') {
			$pagetopper .= "<div class=breadcrumb><a href=\"index.php\">Home</a> &gt; Modify User Profile</div>\n";
		}
		$pagetopper .= '<div id="headerforms" class="pagetitle"><h2>Modify User Profile</h2></div>';
		require('includes/userpics.php');
		if (isset($_POST['msgnot'])) {
			$msgnot = 1;
		} else {
			$msgnot = 0;
		}
		if (isset($_POST['qrd']) || $myrights<20) {
			$qrightsdef = 0;
		} else {
			$qrightsdef = 2;
		}
		if (isset($_POST['usedeflib'])) {
			$usedeflib = 1;
		} else {
			$usedeflib = 0;
		}
		if ($myrights<20) {
			$deflib = 0;
		} else {
			$deflib = $_POST['libs'];
		}
		$homelayout[0] = array();
		$homelayout[1] = array(0,1,2);
		$homelayout[2] = array();
		if (isset($_POST['homelayout10'])) {
			$homelayout[2][] = 10;
		}
		if (isset($_POST['homelayout11'])) {
			$homelayout[2][] = 11;
		}
		$homelayout[3] = array();
		if (isset($_POST['homelayout3-0'])) {
			$homelayout[3][] = 0;
		}
		if (isset($_POST['homelayout3-1'])) {
			$homelayout[3][] = 1;
		}
		foreach ($homelayout as $k=>$v) {
			$homelayout[$k] = implode(',',$v);
		}
		$perpage = intval($_POST['perpage']);
		if (isset($CFG['GEN']['fixedhomelayout']) && $CFG['GEN']['homelayout']) {
			$deflayout = explode('|',$CFG['GEN']['homelayout']);
			foreach ($CFG['GEN']['fixedhomelayout'] as $k) {
				$homelayout[$k] = $deflayout[$k];
			}
		}
				
		$layoutstr = implode('|',$homelayout);
		if (is_uploaded_file($_FILES['stupic']['tmp_name'])) {
			processImage($_FILES['stupic'],$userid,200,200);
			processImage($_FILES['stupic'],'sm'.$userid,40,40);
			$chguserimg = ",hasuserimg=1";
		} else if (isset($_POST['removepic'])) {
			deletecoursefile('userimg_'.$userid.'.jpg');
			deletecoursefile('userimg_sm'.$userid.'.jpg');
			$chguserimg = ",hasuserimg=0";
		} else {
			$chguserimg = '';
		}
		$query = "UPDATE imas_users SET FirstName='{$_POST['firstname']}',LastName='{$_POST['lastname']}',email='{$_POST['email']}',msgnotify=$msgnot,qrightsdef=$qrightsdef,deflib='$deflib',usedeflib='$usedeflib',homelayout='$layoutstr',listperpage='$perpage'$chguserimg ";
		$query .= "WHERE id='$userid'";
		mysql_query($query) or die("Query failed : " . mysql_error());
		
		if (isset($_POST['dochgpw'])) {
			$query = "SELECT password FROM imas_users WHERE id = '$userid'";
			$result = mysql_query($query) or die("Query failed : " . mysql_error());
			$line = mysql_fetch_array($result, MYSQL_ASSOC);
			if ((md5($_POST['oldpw'])==$line['password'] || (isset($CFG['GEN']['newpasswords']) && password_verify($_POST['oldpw'],$line['password']))) && ($_POST['newpw1'] == $_POST['newpw2']) && $myrights>5) {
				if (isset($CFG['GEN']['newpasswords'])) {
					$md5pw = password_hash($_POST['newpw1'], PASSWORD_DEFAULT);
				} else {
					$md5pw =md5($_POST['newpw1']);
				}
				$query = "UPDATE imas_users SET password='$md5pw' WHERE id='$userid'";
				mysql_query($query) or die("Query failed : " . mysql_error()); 
			} else {
				require("header.php");
				echo $pagetopper;
				echo "Password change failed.  <a href=\"forms.php?action=chguserinfo$gb\">Try Again</a>\n";
				require("footer.php");
				exit;
			}
		}

		if (isset($_POST['settimezone'])) {
			if (date_default_timezone_set($_POST['settimezone'])) {
				$tzname = $_POST['settimezone'];
				$query = "UPDATE imas_sessions SET tzname='$tzname' WHERE sessionid='$sessionid'";
				mysql_query($query) or die("Query failed : " . mysql_error()); 
			}
		}
	} else if ($_GET['action']=="forumwidgetsettings") {
		$checked = $_POST['checked'];
		$all = explode(',',$_POST['allcourses']);
		foreach ($all as $k=>$v) {
			$all[$k] = intval($v);
		}
		$tohide = array_diff($all,$checked);
		$hidelist = implode(',', $tohide);
		$query = "UPDATE imas_users SET hideonpostswidget='$hidelist' WHERE id='$userid'";
		mysql_query($query) or die("Query failed : " . mysql_error()); 
		
	} else if ($_GET['action']=="googlegadget") {
		if (isset($_GET['clear'])) {
			$query = "UPDATE imas_users SET remoteaccess='' WHERE id='$userid'";
			mysql_query($query) or die("Query failed : " . mysql_error());
		}
	}
	if ($isgb) {
		echo '<html><body>Changes Recorded.  <input type="button" onclick="top.GB_hide()" value="Done" /></body></html>';		
	} else {
	header('Location: ' . $urlmode  . $_SERVER['HTTP_HOST'] . rtrim(dirname($_SERVER['PHP_SELF']), '/\\') . "/index.php");
	}
	
	
	

?>
