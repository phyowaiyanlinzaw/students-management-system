package app.service;

import app.model.Course;
import app.util.JPAUtil;
import jakarta.persistence.EntityManager;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;

import java.util.ArrayList;

import java.util.List;

@Service("courseService")
@Component
public class CourseServiceImpl implements CourseService{
    @Override
    public int registerCourse(Course course) {
        int result = 0;
        try(
                EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager()
                ){
            em.getTransaction().begin();
            course.setAddedAt(new Timestamp(System.currentTimeMillis()));
            course.setStatus("active");
            em.persist(course);
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
    public int courseCount() {
        int count = 0;
        try(EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager()){
            em.getTransaction().begin();
            count = em.createQuery("select count (c) from Course c",Long.class)
                    .getSingleResult()
                    .intValue();
            em.getTransaction().commit();
        }   catch (Exception e){
            System.out.println(e.getMessage());
        }

        return count;
    }

    @Override
    public int updateCourse(Course course) {
        return 0;
    }

    @Override
    public int deleteCourse(String courseId) {
        return 0;
    }

    @Override
    public Course getOneCourse(String courseId) {
        return null;
    }

    @Override
    public List<Course> getAllCourses() {
        List<Course> courses = new ArrayList<>();
        try(EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager()){
            em.getTransaction().begin();
            courses = em.createQuery("SELECT c FROM Course c where c.status=:status", Course.class)
                    .setParameter("status","active")
                    .getResultList();
            em.getTransaction().commit();
        }

        return courses;
    }
}
