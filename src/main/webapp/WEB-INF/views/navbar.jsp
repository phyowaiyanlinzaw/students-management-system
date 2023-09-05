<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>NAV BAR</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
          integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        * {

        }

        #userDropdown {
            color: #1e1b4b;
            border: 2px solid #1e1b4b;
        }

        #userDropdown:hover {
            background-color: #1e1b4b;
            color: white;
            cursor: pointer;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-sm fixed-top bg-transparent"
     style="border: 2px solid #1e1b4b;border-radius: 10px;padding: 1rem 0;font-weight: 700;">
    <div class="container-fluid" style="color: #1e1b4b">
        <div class="d-flex align-items-center">
            <div>
                <a class="navbar-brand display-3" style="color: #1e1b4b" href="${pageContext.request.contextPath}/">STUDENT
                    MANAGEMENT SYSTEM</a>
            </div>
            <div>
                <span class="nav-link"><span id="currentTime"></span></span>
            </div>
        </div>
        <div class="d-flex justify-content-center align-items-center">
            <ul class="navbar-nav text-light">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" style="color: #1e1b4b;" href="#" id="studentsDropdown"
                       role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Students
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="studentsDropdown">
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/student/list">View
                            Students</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/student/register">Add
                            Student</a></li>
                    </ul>
                </li>
                <c:if test="${currentUser.userRole eq 'admin'}">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" style="color: #1e1b4b;" href="#" id="usersDropdown"
                           role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Users
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="usersDropdown">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/list">View
                                Users</a></li>
                        </ul>
                    </li>
                </c:if>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" style="color: #1e1b4b;" href="#" id="coursesDropdown"
                       role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Courses
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="coursesDropdown">
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/course/list">View
                            Courses</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/course/register">Add
                            Course</a></li>
                    </ul>
                </li>
            </ul>
            <div class="dropdown">
                <button class="btn dropdown-toggle" type="button" id="userDropdown" data-bs-toggle="dropdown"
                        aria-expanded="false">
                    Current User
                </button>
                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/profile">Profile</a></li>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/logout">Logout</a></li>
                </ul>
            </div>
        </div>
    </div>
</nav>
</body>
<script>
    $(document).ready(function () {
            function updateCurrentTime() {
                const currentTimeElement = $('#currentTime'); // Using jQuery to select the element
                const currentTime = new Date().toLocaleTimeString();
                currentTimeElement.text(currentTime); // Using jQuery to set the text content
            }

            // Update the current time every second
            setInterval(updateCurrentTime, 1000);

            // Initial call to set the current time immediately
            updateCurrentTime();
        }
    );
</script>
</html>