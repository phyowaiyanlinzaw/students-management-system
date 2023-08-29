package app.service;

import app.model.Student;
import app.model.User;
import app.util.JPAUtil;
import app.util.PasswordHelper;
import jakarta.persistence.EntityManager;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("studentService")
@Component
public class StudentServiceImpl implements StudentService{
    @Override
    public int registerStudent(Student student) {
        int result = 0;
        try (EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager()) {
            em.getTransaction().begin();
            student.setStatus("active");
            em.persist(student);
            em.getTransaction().commit();
            result = 1;
        } catch (Exception e) {
            System.out.println(e.getMessage());

        }finally {
            JPAUtil.getEntityManagerFactory().close();
        }
        return result;
    }

    @Override
    public int updateStudent(Student student) {
        int result = 0;

        return result;
    }

    @Override
    public int deleteStudent(String studentId) {
        int result = 0;

        return result;
    }

    @Override
    public Student getOneStudent(String studentId) {
        Student student = new Student();

        return student;
    }

    @Override
    public List<Student> getAllStudents() {
        List<Student> students = new ArrayList<>();
        try (EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager()) {
            em.getTransaction().begin();
            students = em.createQuery("SELECT s FROM Student s where s.status=:status", Student.class)
                    .setParameter("status","active")
                    .getResultList();
            em.getTransaction().commit();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return students;
    }
}
