package app.model;

import lombok.Data;

import jakarta.persistence.*;
import org.eclipse.persistence.internal.platform.database.oracle.TIMESTAMPHelper;

import java.sql.Timestamp;
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

    private String status;

    @ManyToMany(mappedBy = "courses")
    private List<Student> students;

    @ManyToOne
    @JoinColumn(name = "USERID")  // This should match the actual column name in your table
    private User addedBy;

    private Timestamp addedAt;

}
