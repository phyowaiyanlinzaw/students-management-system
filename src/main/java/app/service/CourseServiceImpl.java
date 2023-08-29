package app.service;

import app.model.Course;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("courseService")
@Component
public class CourseServiceImpl implements CourseService{
    @Override
    public int registerCourse(Course course) {
        return 0;
    }

    @Override
    public int updateCourse(Course course) {
        return 0;
    }

    @Override
    public int deleteCourse(String courseId) {
        return 0;
    }

    @Override
    public Course getOneCourse(String courseId) {
        return null;
    }

    @Override
    public List<Course> getAllCourse() {
        return null;
    }
}
