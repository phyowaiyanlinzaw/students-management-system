<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>COURSE LIST</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        * {
            box-sizing: border-box;
        }
        .delete-modal{
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0,0,0);
            background-color: rgba(0,0,0,0.4);
        }
        .btn-success,.btn-primary{
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
    <h2>Courses</h2>
    <div class="mb-3">
        <div class="row">
            <div class="col-auto">
                <label for="courseId" class="visually-hidden">Course ID</label>
                <input type="text" class="form-control" id="courseId" placeholder="Course ID">
            </div>

            <div class="col-auto">
                <label for="courseName" class="visually-hidden">Course Name</label>
                <input type="text" class="form-control" id="courseName" placeholder="Course Name">
            </div>

            <div class="col-auto">
                <label for="addedBy" class="visually-hidden">Added By</label>
                <input type="text" class="form-control" id="addedBy" placeholder="Added By">
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
            <th>Course Name</th>
<%--            <th>Added By</th>--%>
            <th>Added At</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${courses}" var="course" varStatus="i">
            <tr>
                <td>${i.index+1}</td>
                <td>${course.courseName}</td>
<%--                <td>${course.addedBy}</td>--%>
                <td>${course.addedAt}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/course/edit/${course.displayCourseId}" style="text-decoration: none">
                        <button class="btn btn-sm btn-success">Update</button>
                    </a>

                    <button class="btn btn-sm btn-danger delete-btn" data-course-id="${course.displayCourseId}" >Delete</button>
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
                <h5 class="modal-title" id="deleteModalLabel">DO YOU WANT TO DELETE THIS COURSE?</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <button class="delete-yes-btn btn btn-danger">DELETE</button>
                <button class="delete-no-btn btn btn-secondary" data-bs-dismiss="modal">CANCEL</button>
            </div>
        </div>
    </div>
</div>

<c:choose>
    <c:when test="${message eq 'courseDeleteError'}">
        <div aria-live="polite" aria-atomic="true" class="position-relative"></div>
        <div class="position-fixed top-0 end-0 p-3">
            <div class="toast text-bg-warning border-0" role="alert" aria-live="assertive" aria-atomic="true" data-autohide="false">
                <div class="toast-header">
                    <i class="fas fa-triangle-exclamation"></i>
                    <strong class="me-auto">Error</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body">
                    Error Deleting Course!!!
                </div>
            </div>
        </div>
    </c:when>
    <c:when test="${message eq 'courseDeleteSuccess'}">
        <div aria-live="polite" aria-atomic="true" class="position-relative"></div>
        <div class="position-fixed top-0 end-0 p-3">
            <div class="toast text-bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true" data-autohide="false">
                <div class="toast-header">
                    <i class="fas fa-triangle-exclamation"></i>
                    <strong class="me-auto">Success</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body">
                    Successfully Deleted Course!!!
                </div>
            </div>
        </div>
    </c:when>
    <c:when test="${message eq 'courseAddSuccess'}">
        <div aria-live="polite" aria-atomic="true" class="position-relative"></div>
        <div class="position-fixed top-0 end-0 p-3">
            <div class="toast text-bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true" data-autohide="false">
                <div class="toast-header">
                    <i class="fas fa-triangle-exclamation"></i>
                    <strong class="me-auto">Success</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body">
                    Successfully Added Course!!!
                </div>
            </div>
        </div>
    </c:when>
</c:choose>
</body>
<script>
    $(document).ready(function() {

        $('.toast').toast('show');

        const deleteButton = $(".delete-btn");
        const deleteModal = $(".delete-modal");
        const deleteYesButton = $(".delete-yes-btn");
        const deleteNoButton = $(".delete-no-btn");
        let courseIdToDelete = null;

        deleteButton.click(function() {
            courseIdToDelete = $(this).data("course-id");
            deleteModal.show();
        });

        deleteYesButton.click(function() {
            if (courseIdToDelete) {
                window.location.href = "${pageContext.request.contextPath}/course/delete?courseId=" + courseIdToDelete;
            }
        });

        deleteNoButton.click(function() {
            courseIdToDelete = null;
            deleteModal.hide();
        });

        $("#search-btn").click(function (event) {
            event.preventDefault();

            const idInput = $("#courseId").val();
            const nameInput = $("#courseName").val().toUpperCase();
            const addedByInput = $("#addedBy").val().toUpperCase();

            $("table tbody tr").each(function () {
                const idValue = $(this).find("td:eq(0)").text();
                const nameValue = $(this).find("td:eq(1)").text().toUpperCase();
                const addedByValue = $(this).find("td:eq(2)").text().toUpperCase();

                if (
                    idValue.indexOf(idInput) > -1 &&
                    nameValue.indexOf(nameInput) > -1 &&
                    addedByValue.indexOf(addedByInput) > -1
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
