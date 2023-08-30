package app.model;

import lombok.Data;

import jakarta.persistence.*;
import org.eclipse.persistence.internal.platform.database.oracle.TIMESTAMPHelper;

import java.sql.Timestamp;
import java.util.List;
import java.util.Set;

@Entity
@Data
public class Course {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int courseId;

    private String displayCourseId;

    private String courseName;

    private String courseDescription;

    private String status;

    private int addedBy;

    private Timestamp addedAt;

    @ManyToMany(mappedBy = "studentCourses")
    private List<Student> students;

}
