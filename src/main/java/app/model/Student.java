package app.model;

import jakarta.persistence.*;
import lombok.Data;

import java.util.List;
import java.util.Objects;
import java.util.Set;

@Entity
@Data
public class Student {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int studentId;

    private String displayStudentId;

    private String studentName;

    private String studentGender;

    private String studentDob;

    private String studentEducation;

    private String studentPhone;

    @Transient
    private String studentCourse;

    @Lob
    private byte[] studentPhoto;

    private String studentPhotoName;

    private String status;

    @ManyToMany
    @JoinTable(
            name = "student_course",
            joinColumns = @JoinColumn(name = "studentId"),
            inverseJoinColumns = @JoinColumn(name = "courseId")
    )
    private List<Course> studentCourses;

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof Student) {
            Student student = (Student) obj;
            return student.getStudentId() == this.getStudentId();
        }
        return false;
    }

    @Override
    public int hashCode() {
        return Objects.hash(studentId);
    }


}
