<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>USER PROFILE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .profile-photo {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
        }
        *{
            margin: 0;
            padding: 0;
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
        .form-control{
            border: none;
            border-bottom: 1px solid #1e1b4b;
            border-radius: 0;
        }
        .form-control:focus{
            box-shadow: none;
            border-color: #1e1b4b;
        }
        .form-control:focus+label{
            color: #1e1b4b;
        }
        #editIcon:hover{
            cursor: pointer;
        }
        .avatar {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            background: #1e1b4b;
            color: #ffffff;
            font-size: 50px;
            line-height: 150px;
        }
    </style>
</head>
<body class="m-0 border-0 bd-example m-0 border-0" style="padding-top: 100px;">
<jsp:include page="nav-bar.jsp"/>
<div class="container mt-5">
    <div class="row">
        <div class="col-md-4">
            <div class="text-center">
                <div class="avatar">${user.userName}</div>
            </div>
        </div>
        <div class="col-md-8">
            <div class="d-flex align-items-center mb-3">
                <h3 class="me-2">User Profile</h3>
                <i class="fas fa-edit ms-2" id="editIcon" style="color: #1e1b4b"></i>
            </div>
            <form:form modelAttribute="userBean" enctype="multipart/form-data" method="post" action="${pageContext.request.contextPath}/user/edit?userId=${user.userId}">
                <div class="form-group mb-3">
                    <label for="name">Name</label>
                    <form:input type="text" class="form-control" id="name" readonly="true" path="userName"/>
                </div>
                <div class="form-group mb-3">
                    <label for="email">Email</label>
                    <form:input type="email" class="form-control" id="email" path="userEmail" readonly="true"/>
                </div>
                <div class="input-group mb-3">
                    <div class="form-floating ">
                        <input type="password" class="form-control" id="password" name="password" placeholder="Enter Password" required/>
                        <label for="password" class="form-label" style="color: #1e1b4b">Password</label>
                    </div>
                    <button class="btn btn-outline-secondary" type="button" id="passwordToggle">
                        <i id="passwordIcon" class="fa fa-eye-slash" style="color: #1e1b4b"></i>
                    </button>
                </div>
                <div id="passwordHelp" class="form-text">Password must be at least 8 characters, contain at least one uppercase letter, one lowercase letter, and one digit</div>
                <div class="input-group">
                    <div class="form-floating ">
                        <input type="password" class="form-control" id="cPassword" name="cPassword" placeholder="Enter Password" required >
                        <label for="cPassword" class="form-label" style="color: #1e1b4b">Confirm Password</label>
                    </div>
                    <button class="btn btn-outline-secondary" type="button" id="cPasswordToggle">
                        <i id="cPasswordIcon" class="fa fa-eye-slash" style="color: #1e1b4b"></i>
                    </button>
                </div>
                <div id="cPasswordHelp" class="form-text mb-4">Type the same password as Password Field</div>
                <button type="submit" class="btn btn-primary">Save Changes</button>
            </form:form>
        </div>
    </div>
</div>
</body>
<script>
    $(document).ready(function () {
        // Edit Icon Click Handler
        $("#editIcon").click(function () {
            $("#name, #email").prop("readonly", function (index, value) {
                return !value;
            });
        });

        // Toggle Password Visibility
        function togglePasswordVisibility($input, $icon) {
            const isPassword = $input.attr('type') === 'password';
            $input.attr('type', isPassword ? 'text' : 'password');
            $icon.toggleClass('fa-eye-slash fa-eye');
        }

        $('#passwordToggle').on('click', function () {
            togglePasswordVisibility($('#password'), $('#passwordIcon'));
        });

        $('#cPasswordToggle').on('click', function () {
            togglePasswordVisibility($('#cPassword'), $('#cPasswordIcon'));
        });

        // Password Validation
        const $password = $("#password");
        const $cPassword = $("#cPassword");
        const $submitBtn = $("#submitBtn");
        const $pwHelp = $("#passwordHelp");
        const $cPwHelp = $("#cPasswordHelp");

        $password.add($cPassword).on("input", function () {
            validatePassword();
            validateConfirmPassword();
        });

        function validatePassword() {
            const passwordValue = $password.val().trim();
            const lengthRequirement = 8;
            const uppercaseRegex = /[A-Z]/;
            const lowercaseRegex = /[a-z]/;
            const digitRegex = /[0-9]/;

            let message = '';

            if (passwordValue.length < lengthRequirement) {
                message = "Password must be at least 8 characters";
            } else if (!uppercaseRegex.test(passwordValue)) {
                message = "Password must contain at least one uppercase letter";
            } else if (!lowercaseRegex.test(passwordValue)) {
                message = "Password must contain at least one lowercase letter";
            } else if (!digitRegex.test(passwordValue)) {
                message = "Password must contain at least one digit";
            }

            $pwHelp.text(message || "Password is super strong.").toggleClass("text-danger", !!message);
            $submitBtn.prop("disabled", !!message || $cPassword.val().trim() !== "");
        }

        function validateConfirmPassword() {
            const passwordValue = $password.val().trim();
            const cPasswordValue = $cPassword.val().trim();

            $cPwHelp.text(passwordValue === cPasswordValue ? "Passwords match!" : "Passwords do not match!")
                .toggleClass("text-danger", passwordValue !== cPasswordValue);
            $submitBtn.prop("disabled", passwordValue !== cPasswordValue || !!$pwHelp.text());
        }
    });

</script>
</html>
