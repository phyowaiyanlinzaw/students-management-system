<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>COURSE EDIT</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <style>
    *{
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }
  </style>
</head>
<body class="m-0 border-0 bd-example m-0 border-0" style="padding-top: 100px;">
<jsp:include page="navbar.jsp"/>
<div class="container">
  <div class="row">
    <div class="col-md-6 offset-md-3">
      <h2 class="display-4">Course Edit</h2>
      <form:form class="row g-3 mt-4" action="${pageContext.request.contextPath}/course/edit" method="post" modelAttribute="course">
        <div class="col-md-10">
          <div class="form-floating">
            <form:input type="text" class="form-control" id="courseId" name="courseId"  path="displayCourseId" readonly="true"/>
          </div>
        </div>
        <div class="col-md-10">
          <div class="form-floating">
            <form:input type="text" class="form-control" id="courseName" name="courseName"  path="courseName" placeholder="Course Name" value="${course.courseName}"/>
            <label for="courseName" class="form-label">Course Name</label>
          </div>
        </div>
        <div class="col-md-10">
          <div class="form-floating">
            <form:input type="textarea" class="form-control" id="courseDescription" name="courseDescription"  path="courseDescription" placeholder="Course Description" value="${course.courseDescription}" cssStyle="height: 200px"/>
            <label for="courseDescription" class="form-label">Course Description</label>
          </div>
        </div>
        <button type="submit" class="btn btn-primary">Register</button>
      </form:form>
    </div>
  </div>
</div>
</body>
</html>
