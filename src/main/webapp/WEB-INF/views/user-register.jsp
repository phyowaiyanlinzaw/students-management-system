<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>USER REGISTER</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
          integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        * {
            font-family: 'Segoe UI', sans-serif;
        }

        .container {
            height: 100%;
        }

        .form-control, .input-group .btn {
            border: none;
            border-bottom: 1px solid #1e1b4b;
            border-radius: 0;
        }

        #passwordIcon {
            border: none;
        }

        #passwordIcon:hover {
            border: none;
        }

        .form-control:focus {
            box-shadow: none;
            border-color: #1e1b4b;
        }

        .form-control:focus + label {
            color: #1e1b4b;
        }

        .btn-primary {
            color: #1e1b4b;
            background-color: #ffffff;
            border: 1px solid #1e1b4b
        }

        .btn-primary:hover {
            background-color: #1e1b4b;
            color: #ffffff;
        }

        #login-link {
            color: #1e1b4b;
            text-decoration: none;
        }

        #login-link:hover {
            color: #1e1b4b;
            cursor: pointer;
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center align-items-center vh-100">
        <div class="col-8">
            <h1 class="display-6 text-center">REGISTER</h1>
            <form:form action="${pageContext.request.contextPath}/user/register" method="post" class="row g-3"
                       modelAttribute="user">
                <div class="col-md-6">
                    <div class=" form-floating">
                        <form:input type="email" class="form-control" id="inputEmail4" placeholder="Email"
                                    path="userEmail"/>
                        <label for="inputEmail4" class="form-label">Email</label>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-floating">
                        <form:input type="text" class="form-control" id="userName" placeholder="Username"
                                    path="userName"/>
                        <label for="userName" class="form-label">Username</label>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="input-group">
                        <div class="form-floating ">
                            <form:input type="password" class="form-control" id="password" name="password"
                                        placeholder="Enter Password" path="userPassword"/>
                            <label for="password" class="form-label" style="color: #1e1b4b">Password</label>
                        </div>
                        <button class="btn btn-outline-secondary" type="button" id="passwordToggle">
                            <i id="passwordIcon" class="fa fa-eye-slash" style="color: #1e1b4b"></i>
                        </button>
                    </div>
                    <div id="passwordHelp" class="form-text">Password must be at least 8 characters, contain at least
                        one uppercase letter, one lowercase letter, and one digit
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="input-group">
                        <div class="form-floating ">
                            <form:input type="password" class="form-control" id="cPassword" name="cPassword"
                                        placeholder="Enter Password" path="userConfirmPassword"/>
                            <label for="cPassword" class="form-label" style="color: #1e1b4b">Confirm Password</label>
                        </div>

                        <button class="btn btn-outline-secondary" type="button" id="cPasswordToggle">
                            <i id="cPasswordIcon" class="fa fa-eye-slash" style="color: #1e1b4b"></i>
                        </button>
                    </div>
                    <div id="cPasswordHelp" class="form-text">Type the same password as Password Field</div>
                </div>
                <div class="col-4 d-grid gap-2 mx-auto mt-5">
                    <button type="submit" class="btn btn-primary">REGISTER</button>
                </div>
                <div class="col-12 d-grid gap-4 mx-auto">
                    <a href="${pageContext.request.contextPath}/user/login" class="btn btn-link" id="login-link">LOG
                        IN</a>
                </div>
            </form:form>
        </div>
    </div>
</div>
<c:choose>
    <c:when test="${message eq 'emptyError'}">
        <div aria-live="polite" aria-atomic="true" class="position-relative"></div>
        <div class="position-fixed end-0 p-3" style="top:80px">
            <div class="toast text-bg-danger" role="alert" aria-live="assertive" aria-atomic="true"
                 data-autohide="false">
                <div class="toast-header">
                    <i class="fas fa-triangle-exclamation"></i>
                    <strong class="me-auto">Error</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body">
                    Fields Cannot be Empty!!!
                </div>
            </div>
        </div>
    </c:when>
    <c:when test="${message eq 'emailDupeError'}">
        <div aria-live="polite" aria-atomic="true" class="position-relative"></div>
        <div class="position-fixed end-0 p-3" style="top:80px">
            <div class="toast text-bg-danger" role="alert" aria-live="assertive" aria-atomic="true"
                 data-autohide="false">
                <div class="toast-header">
                    <i class="fas fa-triangle-exclamation"></i>
                    <strong class="me-auto">Error</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body">
                    This Email Already Exists! Try Logging In.
                </div>
            </div>
        </div>
    </c:when>
    <c:when test="${message eq 'registerError'}">
        <div aria-live="polite" aria-atomic="true" class="position-relative"></div>
        <div class="position-fixed end-0 p-3" style="top:80px">
            <div class="toast text-bg-danger" role="alert" aria-live="assertive" aria-atomic="true"
                 data-autohide="false">
                <div class="toast-header">
                    <i class="fas fa-triangle-exclamation"></i>
                    <strong class="me-auto">Error</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body">
                    User Creation Failed! Check Your Input Fields Again!
                </div>
            </div>
        </div>
    </c:when>
    <c:when test="${message eq 'passwordNotMatch'}">
        <div aria-live="polite" aria-atomic="true" class="position-relative">
            <div class="position-fixed end-0 p-3" style="top:80px">
                <div class="toast text-bg-danger" role="alert" aria-live="assertive" aria-atomic="true"
                     data-autohide="false">
                    <div class="toast-header">
                        <i class="fas fa-triangle-exclamation"></i>
                        <strong class="me-auto">Error</strong>
                        <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                    </div>
                    <div class="toast-body">
                        Passwords do not match!
                    </div>
                </div>
            </div>
        </div>
    </c:when>
</c:choose>
</body>
<script>
    // Password toggle logic
    const passwordToggle = document.getElementById('passwordToggle');
    const passwordInput = document.getElementById('password');
    const passwordIcon = document.getElementById('passwordIcon');

    passwordToggle.addEventListener('click', function () {
        if (passwordInput.type === 'password') {
            passwordInput.type = 'text';
            passwordIcon.classList.remove('fa-eye-slash');
            passwordIcon.classList.add('fa-eye');
        } else {
            passwordInput.type = 'password';
            passwordIcon.classList.remove('fa-eye');
            passwordIcon.classList.add('fa-eye-slash');
        }
    });

    //Password Validation
    const password = document.getElementById("password")
    const cPassword = document.getElementById("cPassword")
    const submitBtn = document.getElementById("submitBtn")
    const pwHelp = document.getElementById("passwordHelp")
    const cPwHelp = document.getElementById("cPasswordHelp")

    password.addEventListener("input", validatePassword)
    cPassword.addEventListener("input", validateConfirmPassword)

    function validatePassword() {
        const passwordValue = password.value.trim()
        const lengthRequirement = 8
        const uppercaseRegex = /[A-Z]/;
        const lowercaseRegex = /[a-z]/;
        const digitRegex = /[0-9]/;

        let message = '';

        if (passwordValue.length < lengthRequirement) {
            message = "Password must be at least 8 characters"
        } else if (!uppercaseRegex.test(passwordValue)) {
            message = "Password must contain at least one uppercase letter"
        } else if (!lowercaseRegex.test(passwordValue)) {
            message = "Password must contain at least one lowercase letter"
        } else if (!digitRegex.test(passwordValue)) {
            message = "Password must contain at least one digit"
        }

        if (message) {
            pwHelp.innerText = message
            pwHelp.classList.add("text-danger")
            submitBtn.disabled = true
        } else {
            pwHelp.innerText = "Password is super strong."
            pwHelp.classList.remove("text-danger")
            submitBtn.disabled = false
        }

        if (cPassword.value.trim() !== "") {
            validateConfirmPassword()
        }
    }

    function validateConfirmPassword() {
        const passwordValue = password.value.trim()
        const cPasswordValue = cPassword.value.trim()

        if (passwordValue !== cPasswordValue) {
            cPwHelp.innerText = "Passwords do not match!"
            cPwHelp.classList.add("text-danger")
            submitBtn.disabled = true
        } else {
            cPwHelp.innerText = "Passwords match!"
            cPwHelp.classList.remove("text-danger")
            submitBtn.disabled = false
        }
    }

    //Confirm Password Toggle
    const cPasswordToggle = document.getElementById('cPasswordToggle');
    const cPasswordInput = document.getElementById('cPassword');
    const cPasswordIcon = document.getElementById('cPasswordIcon');

    cPasswordToggle.addEventListener('click', function () {
        if (cPasswordInput.type === 'password') {
            cPasswordInput.type = 'text';
            cPasswordIcon.classList.remove('fa-eye-slash');
            cPasswordIcon.classList.add('fa-eye');
        } else {
            cPasswordInput.type = 'password';
            cPasswordIcon.classList.remove('fa-eye');
            cPasswordIcon.classList.add('fa-eye-slash');
        }
    });

    //Toast
    $(document).ready(function () {
        $('.toast').toast('show');
    });
</script>
</html>
