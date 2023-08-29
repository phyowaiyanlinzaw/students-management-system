<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>STUDENTS LIST</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .btn-primary,.btn-success{
            color: #1e1b4b;
            background-color: #ffffff;
            border:1px solid #1e1b4b
        }
        .btn-success:hover,.btn-primary:hover{
            background-color: #1e1b4b;
            color: #ffffff;
        }
    </style>
</head>
<body class="m-0 border-0 bd-example m-0 border-0" style="padding-top: 100px;">
<jsp:include page="navbar.jsp"/>
<div class="container mt-4">
    <h2>Students</h2>
    <div class="mb-3">
        <div class="row">
            <div class="col-auto">
                <label for="studentId" class="visually-hidden">Student ID</label>
                <input type="text" class="form-control" id="studentId" placeholder="Student ID">
            </div>

            <div class="col-auto">
                <label for="studentName" class="visually-hidden">Student Name</label>
                <input type="text" class="form-control" id="studentName" placeholder="Student Name">
            </div>

            <div class="col-auto">
                <label for="studentEducation" class="visually-hidden">Student Education</label>
                <input type="text" class="form-control" id="studentEducation" placeholder="Student Education">
            </div>

            <div class="col-auto">
                <label for="studentCourse" class="visually-hidden">Student Course</label>
                <input type="text" class="form-control" id="studentCourse" placeholder="Student Course">
            </div>

            <div class="col-auto">
                <button type="submit" class="btn btn-primary mb-3" id="search-btn">Search</button>
            </div>
        </div>
    </div>
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>#</th>
            <th>Student Name</th>
            <th>Student Education</th>
            <th>Student Course</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${students}" var="student" varStatus="i">
            <tr>
                <td>${i.index+1}</td>
                <td>${student.studentName}</td>
                <td>${student.studentEducation}</td>
                <td>${student.studentCourse}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/student/edit?studentId=${student.studentId}" style="text-decoration: none">
                        <button class="btn btn-sm btn-success">Update</button>
                    </a>

                    <button class="btn btn-sm btn-danger delete-btn" data-course-id="${student.studentId}" >Delete</button>
                </td>
            </tr>
        </c:forEach>

        </tbody>
    </table>
</div>
<div class="delete-modal modal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteModalLabel">DO YOU WANT TO DELETE THIS STUDENT?</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <button class="delete-yes-btn btn btn-danger">DELETE</button>
                <button class="delete-no-btn btn btn-secondary" data-bs-dismiss="modal">CANCEL</button>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    $(document).ready(function() {
        const deleteButton = $(".delete-btn");
        const deleteModal = $(".delete-modal");
        const deleteYesButton = $(".delete-yes-btn");
        const deleteNoButton = $(".delete-no-btn");
        let studentIdToDelete = null;

        deleteButton.click(function() {
            studentIdToDelete = $(this).data("course-id");
            deleteModal.show();
        });

        deleteYesButton.click(function() {
            if (studentIdToDelete) {
                window.location.href = "${pageContext.request.contextPath}/student/delete?studentId=" + studentIdToDelete;
            }
        });

        deleteNoButton.click(function() {
            studentIdToDelete = null;
            deleteModal.hide();
        });

        $("#search-btn").click(function (event) {
            event.preventDefault();

            const idInput = $("#studentId").val();
            const nameInput = $("#studentName").val().toUpperCase();
            const educationInput = $("#studentEducation").val().toUpperCase();
            const courseInput = $("#studentCourse").val().toUpperCase();

            $("table tbody tr").each(function () {
                const idValue = $(this).find("td:eq(0)").text();
                const nameValue = $(this).find("td:eq(1)").text().toUpperCase();
                const educationValue = $(this).find("td:eq(2)").text().toUpperCase();
                const courseValue = $(this).find("td:eq(3)").text().toUpperCase();

                if (
                    idValue.indexOf(idInput) > -1 &&
                    nameValue.indexOf(nameInput) > -1 &&
                    educationValue.indexOf(educationInput) > -1 &&
                    courseValue.indexOf(courseInput) > -1
                ) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        });
    });

</script>

</html>
