package app.model;

import lombok.Data;

import jakarta.persistence.*;

import java.util.List;

@Entity
@Data
public class Course {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int courseId;

    private String displayCourseId;

    private String courseName;

    private String courseDescription;

    @ManyToMany(mappedBy = "courses")
    private List<Student> students;

}
