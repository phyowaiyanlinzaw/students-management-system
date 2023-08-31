package app.service;

import app.model.Course;

import java.util.List;

public interface CourseService {

    int registerCourse(Course course);

    int courseCount();

    int updateCourse(Course course);

    int deleteCourse(String courseId);

    Course getOneCourse(String courseId);

    List<Course> getAllCourses();

    Course getCourseByName(String courseName);

    List<Course> getCoursesOfStudent(int studentId);
}
