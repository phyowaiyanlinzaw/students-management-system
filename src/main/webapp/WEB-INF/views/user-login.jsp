<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>USER LOGIN</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script><style>
    *{
        font-family: 'Segoe UI', sans-serif;
    }
    .container{
        height: 100%;
    }
    .row{
        height: 100%;
    }
    .form-control, .input-group .btn{
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
    .form-control:focus{
        box-shadow: none;
        border-color: #1e1b4b;
    }
    .form-control:focus+label{
        color: #1e1b4b;
    }
    .btn-primary{
        color: #1e1b4b;
        background-color: #ffffff;
        border:1px solid #1e1b4b
    }
    .btn-primary:hover {
        background-color: #1e1b4b;
        color: #ffffff;
    }
    #forget-password{
        color: #1e1b4b;
        text-decoration: none;
    }
    #forget-password:hover{
        text-decoration: underline;
        cursor: pointer;
    }
    #register-link{
        color: #1e1b4b;
        text-decoration: none;
    }
    #register-link:hover{
        text-decoration: underline;
        cursor: pointer;
    }
</style>
</head>
<body>
<div class="container" >
    <div class="row justify-content-center align-items-center vh-100">
        <div class="col-4 rounded p-4" style=" color: #1e1b4b;">
            <h1 class="display-6 text-center">LOG IN</h1>
            <form:form action="${pageContext.request.contextPath}/user/login" method="post" modelAttribute="user">
                <div class="form-floating mb-3">
                    <form:input type="text" class="form-control" id="userIdentifier" name="userIdentifier" placeholder="Enter Email or Username"  path="userIdentifier"/>
                    <label for="userIdentifier" class="form-label" style="color: #1e1b4b">Enter Email or Username</label>
                </div>
                <div class="mb-3">
                    <div class="input-group">
                        <div class="form-floating ">
                            <form:input type="password" class="form-control" id="password" name="password" placeholder="Enter Password" path="userPassword"/>
                            <label for="password" class="form-label" style="color: #1e1b4b">Password</label>
                        </div>

                        <button class="btn btn-outline-secondary" type="button" id="passwordToggle">
                            <i id="passwordIcon" class="fa fa-eye-slash" style="color: #1e1b4b"></i>
                        </button>
                    </div>
                </div>
                <%--                //TODO: Add remember me checkbox--%>
<%--                <div class="mb-3">--%>
<%--                    <div class="d-flex justify-content-between align-items-center">--%>
<%--                        <div class="form-check">--%>
<%--                            <input class="form-check-input" type="checkbox" id="rememberMe">--%>
<%--                            <label class="form-check-label" for="rememberMe">Remember Me</label>--%>
<%--                        </div>--%>
<%--                        <a href="" id="forget-password">Forgot Password?</a>--%>
<%--                    </div>--%>
<%--                </div>--%>

                <div class="col-6 d-grid gap-2 mx-auto">
                    <button type="submit" class="btn btn-primary">LOG IN</button>
                </div>

                <div class="col-12 d-grid gap-4 mx-auto">
                    <a href="${pageContext.request.contextPath}/user/register" class="btn btn-link" id="register-link">CREATE AN ACCOUNT</a>
                </div>

            </form:form>

        </div>
    </div>
</div>
<c:choose>
    <c:when test="${message eq 'registerSuccess'}">
        <div aria-live="polite" aria-atomic="true" class="position-relative"></div>
        <div class="position-fixed top-100 end-0 p-3">
            <div class="toast text-bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true" data-autohide="false">
                <div class="toast-header">
                    <i class="fas fa-triangle-exclamation"></i>
                    <strong class="me-auto">Success</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body">
                    Successfully Registered!!!
                </div>
            </div>
        </div>

    </c:when>
    <c:when test="${message eq 'loginError'}">
        <div aria-live="polite" aria-atomic="true" class="position-relative"></div>
        <div class="position-fixed top-0 end-0 p-3">
            <div class="toast text-bg-danger border-0" role="alert" aria-live="assertive" aria-atomic="true" data-autohide="false">
                <div class="toast-header">
                    <i class="fas fa-triangle-exclamation"></i>
                    <strong class="me-auto">Error</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body">
                    Invalid Email or Password!!!
                </div>
            </div>
        </div>
    </c:when>
    <c:when test="${message eq'emptyError'}">
        <div aria-live="polite" aria-atomic="true" class="position-relative"></div>
        <div class="position-fixed top-0 end-0 p-3">
            <div class="toast text-bg-danger border-0" role="alert" aria-live="assertive" aria-atomic="true" data-autohide="false">
                <div class="toast-header">
                    <i class="fas fa-triangle-exclamation"></i>
                    <strong class="me-auto">Error</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body">
                    Fields Cannot Be Empty
                </div>
            </div>
        </div>
    </c:when>
    <c:when test="${message eq 'notFoundError'}">
        <div aria-live="polite" aria-atomic="true" class="position-relative"></div>
        <div class="position-fixed top-0 end-0 p-3">
            <div class="toast text-bg-danger border-0" role="alert" aria-live="assertive" aria-atomic="true" data-autohide="false">
                <div class="toast-header">
                    <i class="fas fa-triangle-exclamation"></i>
                    <strong class="me-auto">Error</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body">
                    User with This Email or Username doesn't exist!!!
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

    // Toast logic
    $(document).ready(function(){
        $('.toast').toast('show');
    });
</script>
</html>
