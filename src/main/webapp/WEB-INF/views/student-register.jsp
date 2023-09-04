<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>STUDENTS REGISTER</title>
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
    <div class="row justify-content-center align-items-center">
        <div class="col-8">
            <h1 class="display-6 text-center">STUDENTS REGISTRATION</h1>
            <form:form action="${pageContext.request.contextPath}/student/register" method="post" modelAttribute="student" enctype="multipart/form-data">
                <div class="row mb-4 mt-5">
                    <label for="student-id" class="col-md-3 col-form-label">Student ID</label>
                    <div class="col-md-8">
                        <form:input type="text" class="form-control ms-2" id="student-id" path="displayStudentId" readonly="true" value="STUDENT_${studentCount}"/>
                    </div>
                </div>
                <div class="row mb-4">
                    <label for="studentName" class="col-md-3 col-form-label">Student Name</label>
                    <div class="col-md-8">
                        <form:input type="text" class="form-control ms-2" id="studentName" name="studentName"  path="studentName"/>
                    </div>
                </div>
                <div class="row mb-4">
                    <label for="student-dob" class="col-md-3 col-form-label">Student DateOfBirth</label>
                    <div class="col-md-8">
                        <form:input type="date" id="student-dob" placeholder="Select date range" path="studentDob" class="form-control ms-2"/>
                    </div>
                </div>
                <div class="row mb-4">
                    <label class="col-md-3 col-form-label">Student Gender</label>
                    <div class="col-md-8 d-flex align-items-center">
                        <div class="form-check d-inline-block">
                            <form:radiobutton path="studentGender" id="male" value="male" />
                            <label class="form-check-label" for="male">Male</label>
                        </div>
                        <div class="form-check d-inline-block ms-2">
                            <form:radiobutton path="studentGender" id="female" value="female" />
                            <label class="form-check-label" for="female">Female</label>
                        </div>
                    </div>
                </div>
                <div class="row mb-4">
                    <label for="student-phone" class="col-md-3 col-form-label">Student Phone</label>
                    <div class="col-md-8">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text" style="border: none;background-color: transparent">+95</span>
                            </div>
                            <form:input type="text" class="form-control" id="student-phone" name="studentPhone" path="studentPhone"/>
                        </div>
                        <small class="text-danger" id="phoneError" style="display: none;">Invalid phone number. Please enter a 10-digit numeric phone number.</small>
                    </div>
                </div>
                <div class="row mb-4">
                    <label for="student-education" class="col-md-3 col-form-label">Education Level</label>
                    <div class="col-md-8">
                        <div class="input-group">
                            <form:select class="form-control" id="student-education" name="studentEducation" path="studentEducation">
                                <option value="0"  disabled selected >Choose...</option>
                                <option value="Undergraduate">Undergraduate</option>
                                <option value="Diploma in IT">Diploma in IT</option>
                                <option value="Bachelor of Computer Science">Bachelor of Computer Science</option>
                                <option value="PhD">PhD</option>
                            </form:select>
                            <div class="input-group-append" >
              <span class="input-group-text" style="background-color: transparent;border: none">
               <i class="fas fa-graduation-cap" style="background-color: transparent"></i>
              </span>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="row mb-4">
                    <label class="col-md-3 col-form-label">Attend</label>
                    <div class="col-md-8">
                        <div class="form-check d-flex flex-wrap" >
                            <c:forEach items="${courses}" var="course">
                                <div class="form-check form-check-inline mb-2">
                                    <form:checkbox path="studentCourse" class="form-check-input" name="studentCourses" id="${course.courseName}" value="${course.courseName}"/>
                                    <label class="form-check-label" for="${course.courseName}">${course.courseName}</label>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <div class="row mb-4">
                    <label class="col-md-3 col-form-label">Student Photo</label>
                    <div class="col-md-8">
                        <div class="d-flex align-items-center">
                            <input type="file" class="form-control" id="student-photo" accept="image/*" name="photo"/>
                        </div>
                    </div>
                </div>
                <div class="row mb-4">
                    <div class="col-md-6 offset-md-3">
                        <button type="submit" class="btn btn-primary">Register</button>
                        <button type="reset" class="btn btn-danger">Reset</button>
                    </div>
                </div>
            </form:form>
        </div>
    </div>
</div>
${message}
<c:choose>
    <c:when test="${message eq 'emptyError'}">
        <div aria-live="polite" aria-atomic="true" class="position-relative"></div>
        <div class="position-fixed top-0 end-0 p-3">
            <div class="toast text-bg-danger border-0" role="alert" aria-live="assertive" aria-atomic="true" data-autohide="false">
                <div class="toast-header">
                    <i class="fas fa-triangle-exclamation"></i>
                    <strong class="me-auto">Error</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body">
                    Please Fill Out All The Fields
                </div>
            </div>
        </div>
    </c:when>
    <c:when test="${message eq 'studentAddError'}">
        <div aria-live="polite" aria-atomic="true" class="position-relative"></div>
        <div class="position-fixed top-0 end-0 p-3">
            <div class="toast text-bg-danger border-0" role="alert" aria-live="assertive" aria-atomic="true" data-autohide="false">
                <div class="toast-header">
                    <i class="fas fa-triangle-exclamation"></i>
                    <strong class="me-auto">Error</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body">
                    Error While Registering Student
                </div>
            </div>
        </div>
    </c:when>
    <c:when test="${message eq 'stuDupeError'}">
        <div aria-live="polite" aria-atomic="true" class="position-relative"></div>
        <div class="position-fixed top-0 end-0 p-3">
            <div class="toast text-bg-danger border-0" role="alert" aria-live="assertive" aria-atomic="true" data-autohide="false">
                <div class="toast-header">
                    <i class="fas fa-triangle-exclamation"></i>
                    <strong class="me-auto">Error</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body">
                    Student Already Exists
                </div>
            </div>
        </div>
    </c:when>
</c:choose>
</body>
<script>
    $(document).ready(function () {
        $('.toast').toast('show');
    });
</script>
</html>
