package app.service;

import app.model.Course;
import app.model.Student;

import java.util.List;

public interface StudentService {

    int registerStudent(Student student);

    int getStudentCount();

    int updateStudent(Student student);

    int deleteStudent(int studentId);

    Student getOneStudent(int studentId);

    List<Student> getAllStudents();

}
