<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="input" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>COURSE ADD</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        *{
            font-family: 'Segoe UI', sans-serif;
        }
        .container{
            height: 100%;
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
        .btn-primary{
            color: #1e1b4b;
            background-color: #ffffff;
            border:1px solid #1e1b4b
        }
        .btn-primary:hover {
            background-color: #1e1b4b;
            color: #ffffff;
        }
    </style>
</head>
<body class="m-0 border-0 bd-example m-0 border-0" style="padding-top: 100px;">
<jsp:include page="navbar.jsp"/>
<div class="container">
    <div class="row">
        <div class="col-md-6 offset-md-3">
            <h2 class="display-4">Course Registration</h2>
            <form:form class="row g-3 mt-4" action="${pageContext.request.contextPath}/course/register" method="post" modelAttribute="course">
                <div class="col-md-10">
                    <div class="form-floating">
                        <form:input type="text" class="form-control" id="courseId" name="courseId"  path="displayCourseId" readonly="true" value="COURSE_${courseCount}"/>
                    </div>
                </div>
                <div class="col-md-10">
                    <div class="form-floating">
                        <form:input type="text" class="form-control" id="courseName" name="courseName"  path="courseName" placeholder="Course Name"/>
                        <label for="courseName" class="form-label">Course Name</label>
                    </div>
                </div>
                <div class="col-md-10">
                    <div class="form-floating">
                        <form:textarea type="textarea" class="form-control" id="courseDescription" name="courseDescription"  path="courseDescription" placeholder="Course Description" cssStyle="height: 200px"/>
                        <label for="courseDescription" class="form-label">Course Description</label>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary">Register</button>
            </form:form>
        </div>
    </div>
</div>
<c:choose>
    <c:when test="${message eq 'courseDupe'}">
        <div aria-live="polite" aria-atomic="true" class="position-relative"></div>
        <div class="position-fixed top-100 end-0 p-3">
            <div class="toast text-bg-danger" role="alert" aria-live="assertive" aria-atomic="true" data-autohide="false">
                <div class="toast-header">
                    <i class="fas fa-triangle-exclamation"></i>
                    <strong class="me-auto">Error</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body">
                    This course already exists
                </div>
            </div>
        </div>
    </c:when>
    <c:when test="${message eq 'emptyError'}">
        <div aria-live="polite" aria-atomic="true" class="position-relative"></div>
        <div class="position-fixed top-100 end-0 p-3">
            <div class="toast text-bg-danger" role="alert" aria-live="assertive" aria-atomic="true" data-autohide="false">
                <div class="toast-header">
                    <i class="fas fa-triangle-exclamation"></i>
                    <strong class="me-auto">Error</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body">
                    Please fill all the fields
                </div>
            </div>
        </div>
    </c:when>
    <c:when test="${message eq 'courseAddError'}">
        <div aria-live="polite" aria-atomic="true" class="position-relative"></div>
        <div class="position-fixed top-0 end-100 p-3">
            <div class="toast text-bg-danger" role="alert" aria-live="assertive" aria-atomic="true" data-autohide="false">
                <div class="toast-header">
                    <i class="fas fa-triangle-exclamation"></i>
                    <strong class="me-auto">Error</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body">
                    Error while adding course
                </div>
            </div>
        </div>
    </c:when>
</c:choose>
</body>
<script>
    $(document).ready(function(){
        $('.toast').toast('show');
    });
</script>
</html>
