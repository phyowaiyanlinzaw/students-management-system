package app.model;

import lombok.Data;

import jakarta.persistence.*;
import org.eclipse.persistence.internal.platform.database.oracle.TIMESTAMPHelper;

import java.sql.Timestamp;
import java.util.List;
import java.util.Objects;
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

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof Course) {
            Course course = (Course) obj;
            return course.getCourseId() == this.getCourseId();
        }
        return false;
    }

    @Override
    public int hashCode() {
        return Objects.hash(courseId);
    }

}
