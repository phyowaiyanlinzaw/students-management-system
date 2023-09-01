<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>USERS LIST</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        *{
            margin: 0;
            padding: 0;
        }
        .btn-primary,.btn-success{
            color: #1e1b4b;
            background-color: #ffffff;
            border:1px solid #1e1b4b
        }
        .btn-primary:hover,.btn-success:hover{
            background-color: #1e1b4b;
            color: #ffffff;
        }
    </style>
</head>
<body class="m-0 border-0 bd-example m-0 border-0" style="padding-top: 100px;">
<jsp:include page="navbar.jsp"/>
<div class="container mt-4">
    <h2>Users</h2>
    <div class="mb-3">
        <div class="row">
            <div class="col-auto">
                <label for="userID" class="visually-hidden">User Id</label>
                <input type="text" class="form-control" id="userID" placeholder="User ID">
            </div>

            <div class="col-auto">
                <label for="userName" class="visually-hidden">User Name</label>
                <input type="text" class="form-control" id="userName" placeholder="User Name">
            </div>

            <div class="col-auto">
                <button type="submit" class="btn btn-primary mb-3" id="search-btn">Search</button>
            </div>
        </div>

    </div>
    <table class="table table-bordered" id="userTable">
        <thead>
        <tr>
            <th>#</th>
            <th>User Name</th>
            <th>User Role</th>
            <th>User Email</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${users}" var="user" varStatus="i">
            <tr>
                <td>${i.index+1}</td>
                <td>${user.userName}</td>
                <td>${user.userRole}</td>
                <td>${user.userEmail}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/user/edit?userId=${user.userId}" style="text-decoration: none">
                        <button class="btn btn-sm btn-success">Update</button>
                    </a>

                    <button class="btn btn-sm btn-danger delete-btn" data-user-id="${user.userId}" >Delete</button>
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
                <h5 class="modal-title" id="deleteModalLabel">DO YOU WANT TO DELETE THIS USER?</h5>
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
    <c:when test="${message eq 'deleteError'}">
        <div aria-live="polite" aria-atomic="true" class="position-relative"></div>
        <div class="position-fixed top-0 end-0 p-3">
            <div class="toast text-bg-warning border-0" role="alert" aria-live="assertive" aria-atomic="true" data-autohide="false">
                <div class="toast-header">
                    <i class="fas fa-triangle-exclamation"></i>
                    <strong class="me-auto">Error</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body">
                    Error Deleting User!!!
                </div>
            </div>
        </div>
    </c:when>
    <c:when test="${message eq 'deleteSuccess'}">
        <div aria-live="polite" aria-atomic="true" class="position-relative"></div>
        <div class="position-fixed top-0 end-0 p-3">
            <div class="toast text-bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true" data-autohide="false">
                <div class="toast-header">
                    <i class="fas fa-triangle-exclamation"></i>
                    <strong class="me-auto">Success</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body">
                    User Deleted Successfully!!!
                </div>
            </div>
        </div>
    </c:when>
</c:choose>
</body>
<script>
    $(document).ready(function() {
        const deleteButton = $(".delete-btn");
        const deleteModal = $(".delete-modal");
        const deleteYesButton = $(".delete-yes-btn");
        const deleteNoButton = $(".delete-no-btn");
        let userIdToDelete = null;

        deleteButton.click(function() {
            userIdToDelete = $(this).data("user-id");
            deleteModal.show();
        });

        deleteYesButton.click(function() {
            if (userIdToDelete) {
                window.location.href = "${pageContext.request.contextPath}/user/delete?userId=" + userIdToDelete;
            }
        });

        deleteNoButton.click(function() {
            userIdToDelete = null;
            deleteModal.hide();
        });

        $("#search-btn").click(function (event) {
            event.preventDefault();

            const idInput = $("#userID").val();
            const nameInput = $("#userName").val().toUpperCase();

            $("table tbody tr").each(function () {
                const idValue = $(this).find("td:eq(0)").text();
                const nameValue = $(this).find("td:eq(1)").text().toUpperCase();

                if (
                    idValue.indexOf(idInput) > -1 &&
                    nameValue.indexOf(nameInput) > -1
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
