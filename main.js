"use strict";

const root = document.querySelector(".root");
const popUps = document.querySelector(".pop-up");
const showDisplay = (popUp) => {
    popUps.style.display = "flex";
    popUp.style.display = "flex";
};
const hideDisplay = (popUp) => {
    popUps.addEventListener("click", (e) => {
        if(e.target === popUps) {
            popUps.style.display = "none";
            popUp.style.display = "none";
        }
    });
};
const hidePrevious = (popUp) => {
    popUp.style.display = "none";
};
const menuLinks = document.querySelector(".about_active");
const signUpBtns = document.querySelectorAll(".sign-up");
signUpBtns.forEach(signUpBtn => {
    signUpBtn.addEventListener("click", (e) => {
        e.preventDefault();
        menuLinks.style.transform = "scale(0)";
        const signPopUp = popUps.querySelector(".pop-up__sign-up");
        showDisplay(signPopUp);
        hideDisplay(signPopUp);
        const logInBtn = signPopUp.querySelector(".login");
        logInBtn.addEventListener("click", (e) => {
            e.preventDefault();
            const loginPopUp = popUps.querySelector(".pop-up__login");
            showDisplay(loginPopUp);
            hidePrevious(signPopUp);
            const fgtPsword = loginPopUp.querySelector(".password");
            fgtPsword.addEventListener("click", (e) => {
                e.preventDefault();
                const fgtPswordPopUp = popUps.querySelector(".pop-up__forgot-password");
                showDisplay(fgtPswordPopUp);
                hidePrevious(loginPopUp);
                const cancelBtn = fgtPswordPopUp.querySelector(".cancel-btn");
                cancelBtn.addEventListener("click", (e) => {
                    e.preventDefault();
                    showDisplay(loginPopUp);
                    hidePrevious(fgtPswordPopUp);
                    hideDisplay(loginPopUp);
                });
                const sendBtn = fgtPswordPopUp.querySelector(".sub-btn");
                // sendBtn.addEventListener("click", (e) => {
                //     e.preventDefault();
                //     const resPasswordPopUp = popUps.querySelector(".pop-up__reset-password");
                //     showDisplay(resPasswordPopUp);
                //     hidePrevious(fgtPswordPopUp);
                //     const saveBtn = resPasswordPopUp.querySelector(".submit-btn");
                //     saveBtn.addEventListener("click", (e) => {
                //         e.preventDefault();
                //         showDisplay(loginPopUp);
                //         hidePrevious(resPasswordPopUp);
                //         hideDisplay(loginPopUp);
                //     });
                //     const signFromResPassword = resPasswordPopUp.querySelector(".sign_up");
                //     signFromResPassword.addEventListener("click", (e) => {
                //         e.preventDefault();
                //         showDisplay(signPopUp);
                //         hidePrevious(resPasswordPopUp);
                //         hideDisplay(signPopUp);
                //     });
                //     hideDisplay(resPasswordPopUp);
                // });
                const signFromPassword = fgtPswordPopUp.querySelector(".sign-up");
                signFromPassword.addEventListener("click", (e) => {
                    e.preventDefault();
                    showDisplay(signPopUp);
                    hidePrevious(fgtPswordPopUp);
                    hideDisplay(signPopUp);
                });
                hideDisplay(fgtPswordPopUp);
            });
            const signup = loginPopUp.querySelector(".signup");
            signup.addEventListener("click", (e) => {
                e.preventDefault();
                const signPopUp = popUps.querySelector(".pop-up__sign-up");
                showDisplay(signPopUp);
                hidePrevious(loginPopUp);
                hideDisplay(signPopUp);
            });
            hideDisplay(loginPopUp);
        });
    });
});
const loginButtons = document.querySelectorAll(".log-in");
loginButtons.forEach(loginButton => {
    loginButton.addEventListener("click", (e) => {
        e.preventDefault();
        const signPopUp = popUps.querySelector(".pop-up__sign-up");
        const loginPopUp = popUps.querySelector(".pop-up__login");
        showDisplay(loginPopUp);
        hidePrevious(signPopUp);
        hideDisplay(loginPopUp);
        const fgtPsword = loginPopUp.querySelector(".password");
        fgtPsword.addEventListener("click", (e) => {
            e.preventDefault();
            const fgtPswordPopUp = popUps.querySelector(".pop-up__forgot-password");
            showDisplay(fgtPswordPopUp);
            hidePrevious(loginPopUp);
            const cancelBtn = fgtPswordPopUp.querySelector(".cancel-btn");
            cancelBtn.addEventListener("click", (e) => {
                e.preventDefault();
                showDisplay(loginPopUp);
                hidePrevious(fgtPswordPopUp);
                hideDisplay(loginPopUp);
            });
            const sendBtn = fgtPswordPopUp.querySelector(".sub-btn");
            // sendBtn.addEventListener("click", (e) => {
            //     e.preventDefault();
            //     const resPasswordPopUp = popUps.querySelector(".pop-up__reset-password");
            //     showDisplay(resPasswordPopUp);
            //     hidePrevious(fgtPswordPopUp);
            //     const saveBtn = resPasswordPopUp.querySelector(".submit-btn");
            //     saveBtn.addEventListener("click", (e) => {
            //         e.preventDefault();
            //         showDisplay(loginPopUp);
            //         hidePrevious(resPasswordPopUp);
            //         hideDisplay(loginPopUp);
            //     });
            //     const signFromResPassword = resPasswordPopUp.querySelector(".sign_up");
            //     signFromResPassword.addEventListener("click", (e) => {
            //         e.preventDefault();
            //         showDisplay(signPopUp);
            //         hidePrevious(resPasswordPopUp);
            //         hideDisplay(signPopUp);
            //     });
            //     hideDisplay(resPasswordPopUp);
            // });
            const signFromPassword = fgtPswordPopUp.querySelector(".sign-up");
            signFromPassword.addEventListener("click", (e) => {
                e.preventDefault();
                showDisplay(signPopUp);
                hidePrevious(fgtPswordPopUp);
                hideDisplay(signPopUp);
            });
            hideDisplay(fgtPswordPopUp);
        });
        const signup = loginPopUp.querySelector(".signup");
        signup.addEventListener("click", (e) => {
            e.preventDefault();
            const signPopUp = popUps.querySelector(".pop-up__sign-up");
            showDisplay(signPopUp);
            hidePrevious(loginPopUp);
            hideDisplay(signPopUp);
            const logInBtn = signPopUp.querySelector(".login");
            logInBtn.addEventListener("click", (e) => {
                e.preventDefault();
                const loginPopUp = popUps.querySelector(".pop-up__login");
                showDisplay(loginPopUp);
                hidePrevious(signPopUp);
                hideDisplay(loginPopUp);
            });
        });
    });
});


const menuBox = document.querySelector(".menu__box");
const menuIcon = menuBox.querySelector(".menu-icon");
menuLinks.style.transform = "scale(0)";
menuIcon.addEventListener("click", () => {
    if(menuLinks.style.transform === "scale(0)") {
        menuLinks.style.transform = "scale(1)";
    } else {
        menuLinks.style.transform = "scale(0)";
    }
});

const readAndAccept = popUps.querySelector(".read-and-accept");
const signupOnPopup = popUps.querySelector(".submit-btn");

readAndAccept.addEventListener("change", (e) => {
    if(e.target.checked) {
        signupOnPopup.disabled = false;
    } else {
        signupOnPopup.disabled = true;
    }
});

//signupOnPopup.addEventListener("click", (e) => {
//    e.preventDefault();
//    if(!signupOnPopup.disabled) {
//        location.href = "./dashboardPage.html";
//        readAndAccept.checked = false;
//    }
//});
