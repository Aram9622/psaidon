<?php
if (!isset($imasroot)) { //don't allow direct access to loginpage.php
    header("Location: index.php");
    exit;
}
//any extra CSS, javascript, etc needed for login page
$placeinhead = "<link rel=\"stylesheet\" href=\"$imasroot/homepage.css\" type=\"text/css\" />\n";
$placeinhead .= "<link rel=\"stylesheet\" href=\"$imasroot/popUps.css\" type=\"text/css\" />\n";
$placeinhead .= "<script type=\"text/javascript\" src=\"$imasroot/javascript/jstz_min.js\" ></script>";
$nologo = true;
require("header.php");
if (!empty($_SERVER['QUERY_STRING'])) {
    $querys = '?' . $_SERVER['QUERY_STRING'];
} else {
    $querys = '';
}
$loginFormAction = $GLOBALS['basesiteurl'] . substr($_SERVER['SCRIPT_NAME'], strlen($imasroot)) . Sanitize::encodeStringForDisplay($querys);
if (!empty($_SESSION['challenge'])) {
    $challenge = $_SESSION['challenge'];
} else {
    //use of microtime guarantees no challenge used twice
    $challenge = base64_encode(microtime() . rand(0, 9999));
    $_SESSION['challenge'] = $challenge;
}
$pagetitle = "About Us";
include("infoheader.php");
?>

<main class="main-block">
    <div class="main-block__text">
        <p class="account-info"> We are an open-source <span>learning management</span> platform </p>
        <p class="account-text"> Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy
            eirmod. </p>
        <button class="account-btn"><span>Create an account</span></button>
    </div>
    <div class="main-block__image">
        <img src="<?php echo $imasroot ?>banner.png" alt="bannerImg">
    </div>
</main>

<!--<div id="loginbox">-->
<!--<form method="post" action="--><?php //echo $loginFormAction;?><!--">-->
<?php
//	if ($haslogin) {
//		if ($badsession) {
//			if (isset($_COOKIE[session_name()])) {
//				echo 'Problems with session storage';
//			}  else {
//				echo '<p>Unable to establish a session.  Check that your browser is set to allow session cookies</p>';
//			}
//		} else if (substr($line['password'],0,8)=='cleared_') {
//			echo '<p>Your password has expired since your account has been unused. Use the Reset Password link below to reset your password.</p>';
//		} else {
//			echo "<p>Login Error.  Try Again</p>\n";
//		}
//	}
//?>
<!--<b>Login</b>-->
<!---->
<!--<div><noscript>JavaScript is not enabled.  JavaScript is required for --><?php //echo $installname; ?><!--.  Please enable JavaScript and reload this page</noscript></div>-->
<!---->
<!--<table>-->
<!--<tr><td><label for="username">--><?php //echo $loginprompt;?><!--</label>:</td><td><input type="text" size="15" id="username" name="username" /></td></tr>-->
<!--<tr><td><label for="password">Password</label>:</td><td><input type="password" size="15" id="password" name="password" /></td></tr>-->
<!--</table>-->
<!--<div class=textright><input type="submit" value="Login"></div>-->
<!---->
<!--<div class="textright"><a href="--><?php //echo $imasroot; ?><!--/forms.php?action=newuser">Register as a new student</a></div>-->
<!--<div class="textright"><a href="--><?php //echo $imasroot; ?><!--/forms.php?action=resetpw">Forgot Password</a><br/>-->
<!--<a href="--><?php //echo $imasroot; ?><!--/forms.php?action=lookupusername">Forgot Username</a></div>-->
<!---->
<!--<input type="hidden" id="tzoffset" name="tzoffset" value="">-->
<!--<input type="hidden" id="tzname" name="tzname" value="">-->
<!--<input type="hidden" id="challenge" name="challenge" value="--><?php //echo $challenge; ?><!--" />-->
<!--<script type="text/javascript">-->
<!--$(function() {-->
<!--        var thedate = new Date();-->
<!--        document.getElementById("tzoffset").value = thedate.getTimezoneOffset();-->
<!--        var tz = jstz.determine();-->
<!--        document.getElementById("tzname").value = tz.name();-->
<!--        $("#username").focus();-->
<!--});-->
<!--</script>-->
<!---->
<!--</form>-->
<!--</div>-->
<!--<div class="text">-->
<!--<p>--><?php //echo $installname; ?><!-- is a web based mathematics assessment and course management platform.  </p>-->
<!-- <img style="float: left; margin-right: 20px;" src="--><?php //echo $imasroot; ?><!--/img/screens.jpg" alt="Computer screens"/>-->
<!---->
<!--<p>This system is designed for mathematics, providing delivery of homework, quizzes, tests, practice tests,-->
<!--and diagnostics with rich mathematical content.  Students can receive immediate feedback on algorithmically generated questions with-->
<!--numerical or algebraic expression answers.-->
<!--</p>-->
<!---->
<!--<p>If you already have an account, you can log on using the box to the right.</p>-->
<!--<p>If you are a new student to the system, <a href="--><?php //echo $imasroot; ?><!--/forms.php?action=newuser">Register as a new student</a></p>-->
<!--<p>If you are an instructor, you can <a href="--><?php //echo $imasroot;?><!--/newinstructor.php">request an account</a></p>-->
<!---->
<!--<p>Also available:-->
<!--<ul>-->
<!--<li><a href="--><?php //echo $imasroot;?><!--/info/enteringanswers.php">Help for student with entering answers</a></li>-->
<!--<li><a href="--><?php //echo $imasroot;?><!--/docs/docs.php">Instructor Documentation</a></li>-->
<!--</ul>-->

<!--<br class=clear>-->
<!--<p class="textright">--><?php //echo $installname;?><!-- is powered by <a href="http://www.imathas.com">IMathAS</a> &copy; 2006-2013 David Lippman</p>-->
<!--</div>-->

<div class="about_active">
    <a href="#" class="about__link"> About us </a>
    <a href="#" class="about__link"> Contact </a>
    <a href="#" class="about__link"> How It Works </a>
    <a href="#" class="about__link about__link_color log-in"> Login </a>
    <a href="#" class="about__link about__link_background sign-up"> Sign up </a>
</div>
<!-- Pop Up Pages -->
<div class="pop-up">
    <div class="pop-up__sign-up">
        <form action="actions.php?action=newuser" class="" method="post">
            <input type="hidden" name=hval>
            <p class="title"> Sign up </p>
            <p class="subtitle"> <span class="text">as a student</span> <span class="text text_color">as a Teacher</span> </p>
            <div class="form-list">
                <p> Enter a username </p>
                <input class="form" type="text" size=12 id=SID name=SID placeholder="Enter a username">
            </div>
            <div class="form-list">
                <p> First Name </p>
                <input name="firstname" type="text" placeholder="Full Name">
            </div>
            <div class="form-list">
                <p> Last Name </p>
                <input name="lastname" type="text" placeholder="Last Name">
            </div>
            <div class="form-list">
                <p> Email Address </p>
                <input name="email" type="email" placeholder="Email Address">
            </div>
            <div class="form-list">
                <p> Password </p>
                <input name="pw1" type="password" placeholder="********">
            </div>
            <div class="form-list">
                <p> Confirm Password </p>
                <input name="pw2" type="password" placeholder="********">
            </div>
            <div class="accept">
                <input name="" type="checkbox" class="read-and-accept"> <span>I read and accept</span> <a href="#">Terms and Conditions</a>
            </div>
            <button  class="submit-btn" type="submit" disabled> Sign Up </button>
            <p class="form-question"> Already have an account? <a class="login" href="#">Login</a> </p>
        </form>
        <div class="footer-color"></div>
    </div>
    <div class="pop-up__login">
        <form action="<?php echo $loginFormAction;?>" class="" method="post">
            <p class="title"> Login </p>
            <div class="form-list">
                <p> Username </p>
                <input name="username" type="text" placeholder="Username">
            </div>
            <div class="form-list">
                <p> Password </p>
                <input name="password" type="password" placeholder="********">
            </div>
            <div class="accept accept_block">
                <p> <input name=" " type="checkbox"> Keep Me Logged In </p> <a class="accept__link password" href="#">Forgot Password ?</a>
            </div>
            <button type="submit" class="submit-btn"> Login </button>
            <p class="form-question"> Don't Have An Account? <a class="signup" href="#">Sign Up</a> </p>
            <input type="hidden" id="tzoffset" name="tzoffset" value="">
            <input type="hidden" id="tzname" name="tzname" value="">
            <input type="hidden" id="challenge" name="challenge" value="<?php echo $challenge; ?>" />
            <script type="text/javascript">
                $(function() {
                    var thedate = new Date();
                    document.getElementById("tzoffset").value = thedate.getTimezoneOffset();
                    var tz = jstz.determine();
                    document.getElementById("tzname").value = tz.name();
                    $("#username").focus();
                });
            </script>
        </form>
        <div class="footer-color"></div>
    </div>
    <div class="pop-up__forgot-password">
        <form action="actions.php?action=resetpw" method="post" class="">
            <p class="title"> Forgot Password? </p>
            <p class="info"> Enter your email address and we’ll send you a link to reset your password </p>
            <div class="form-list">
                <p> Username </p>
                <input name="username" type="text" placeholder="Username">
            </div>
            <div class="submit-cancel">
                <input class="cancel-btn" type="reset" value="Cancel">
                <input class="sub-btn" type="submit" value="Send">
            </div>
            <p class="form-question form-question_margin"> Don't Have An Account? <a class="sign-up" href="#">Sign Up</a> </p>
        </form>
        <div class="footer-color"></div>
    </div>
    <div class="pop-up__reset-password">
        <form action="#" class="">
            <p class="title"> Reset Your Password </p>
            <div class="form-list">
                <p> Password </p>
                <input name=" " type="password" placeholder="********">
            </div>
            <div class="form-list">
                <p> Retype Password </p>
                <input name=" " type="password" placeholder="********">
            </div>
            <input class="submit-btn" type="submit" value="Save">
            <p class="form-question form-question_margin"> Don't Have An Account? <a class="sign_up" href="#">Sign Up</a> </p>
        </form>
        <div class="footer-color"></div>
    </div>
</div>
<?php
require("footer.php");
?>
