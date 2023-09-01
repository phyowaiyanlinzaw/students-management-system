<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>STUDENTS EDIT</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <style>
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
  </style>
</head>
<body class="m-0 border-0 bd-example m-0 border-0" style="padding-top: 100px;">
<jsp:include page="navbar.jsp"/>
<div class="container mt-4">
  <div class="row">
    <div class="col-4 d-flex flex-column align-items-center">
      <img src="${pageContext.request.contextPath}/student/photo?studentId=${studentId}" class="img-fluid" alt="Student Photo" width="300" height="300">
    </div>
    <div class="col-8">
      <form:form action="${pageContext.request.contextPath}/student/edit" method="post" enctype="multipart/form-data" modelAttribute="student">
            <form:input type="text" class="form-control" id="student-id" path="studentId" readonly="true" hidden="true"/>
        <div class="row mb-4 mt-5">
          <label for="student-id" class="col-md-3 col-form-label">Student ID</label>
          <div class="col-md-8">
            <form:input type="text" class="form-control" id="student-id" path="displayStudentId" readonly="true"/>
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
                <form:option value="Undergraduate">Undergraduate</form:option>
                <form:option value="Diploma in IT">Diploma in IT</form:option>
                <form:option value="Bachelor of Computer Science">Bachelor of Computer Science</form:option>
                <form:option value="PhD">PhD</form:option>
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
      <c:set var="isSelected" value="false" />
      <c:forEach items="${student.studentCourses}" var="selectedCourse">
        <c:if test="${course.courseName eq selectedCourse.courseName}">
          <c:set var="isSelected" value="true" />
        </c:if>
      </c:forEach>
      <input class="form-check-input" type="checkbox" name="studentCourse"
             id="${course.courseName}" value="${course.courseName}"
             <c:if test="${isSelected}">checked</c:if>
      >
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
            <button type="submit" class="btn btn-primary">Update</button>
            <button type="reset" class="btn btn-danger">Reset</button>
          </div>
        </div>
      </form:form>
    </div>
  </div>
</div>

</body>

</html>
