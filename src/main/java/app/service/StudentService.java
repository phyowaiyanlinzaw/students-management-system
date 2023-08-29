package app.service;

import app.model.Student;

import java.util.ArrayList;

public interface StudentService {

    int registerStudent(Student student);

    int updateStudent(Student student);

    int deleteStudent(String studentId);

    Student getOneStudent(String studentId);

    ArrayList<Student> getAllStudents();
}
