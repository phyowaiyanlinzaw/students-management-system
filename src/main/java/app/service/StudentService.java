package app.service;

import app.model.Student;

import java.util.ArrayList;
import java.util.List;

public interface StudentService {

    int registerStudent(Student student);

    int updateStudent(Student student);

    int deleteStudent(String studentId);

    Student getOneStudent(String studentId);

    List<Student> getAllStudents();
}
