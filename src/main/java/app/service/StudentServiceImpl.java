package app.service;

import app.model.Student;
import app.model.User;
import app.util.JPAUtil;
import app.util.PasswordHelper;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("studentService")
@Component
public class StudentServiceImpl implements StudentService {
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

        } finally {
            JPAUtil.getEntityManagerFactory().close();
        }
        return result;
    }

    @Override
    public int updateStudent(Student student) {
        int result = 0;
        try (EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager()) {
            em.getTransaction().begin();
            Student s = em.merge(student);
            em.getTransaction().commit();
            result = 1;
        }

        return result;
    }

    @Override
    public int deleteStudent(int studentId) {
        int result = 0;
        try (EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager()) {
            em.getTransaction().begin();
            Query query = em.createQuery("update Student s set s.status=:status where s.studentId=:studentId");
            query.setParameter("status", "inactive");
            query.setParameter("studentId", studentId);
            result = query.executeUpdate();
            em.getTransaction().commit();
        }
        return result;
    }

    @Override
    public Student getOneStudent(int studentId) {
        Student student = new Student();
        try (EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager()) {
            em.getTransaction().begin();
            student = em.createQuery("SELECT s FROM Student s where s.studentId=:studentId", Student.class)
                    .setParameter("studentId", studentId)
                    .getSingleResult();
            em.getTransaction().commit();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return student;
    }

    @Override
    public List<Student> getAllStudents() {
        List<Student> students = new ArrayList<>();
        try (EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager()) {
            em.getTransaction().begin();
            students = em.createQuery("SELECT s FROM Student s where s.status=:status", Student.class)
                    .setParameter("status", "active")
                    .getResultList();
            em.getTransaction().commit();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return students;
    }

    @Override
    public int getStudentCount() {
        int count = 0;
        try (EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager()) {
            em.getTransaction().begin();
            count = em.createQuery("select count (s) from Student s", Long.class)
                    .getSingleResult()
                    .intValue();
            em.getTransaction().commit();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return count;
    }
}
