package app.service;

import app.model.Course;
import app.model.User;
import app.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
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
        System.out.println(course.getCourseDescription());
        int result = 0;
        try(EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager()){
            em.getTransaction().begin();
            Query query = em.createQuery("update Course c set c.courseDescription=:courseDescription,c.courseName=:courseName,c.addedAt=:addedAt,c.addedBy=:addedBy where c.displayCourseId=:courseId");
            query.setParameter("courseDescription",course.getCourseDescription());
            query.setParameter("courseName",course.getCourseName());
            query.setParameter("addedAt",new Timestamp(System.currentTimeMillis()));
            query.setParameter("addedBy",course.getAddedBy());
            query.setParameter("courseId",course.getDisplayCourseId());
            System.out.println("in try");
            result = query.executeUpdate();
            em.getTransaction().commit();
        }
        return result;
    }

    @Override
    public int deleteCourse(String courseId) {
        int result = 0;
        try(EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager()){
            em.getTransaction().begin();
            Query query = em.createQuery("update Course c set c.status=:status where c.displayCourseId=:courseId");
            query.setParameter("status","deleted");
            query.setParameter("courseId",courseId);
            result = query.executeUpdate();
            em.getTransaction().commit();
        }
        return result;
    }

    @Override
    public Course getOneCourse(String courseId) {
        Course course = new Course();
        try (EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager()) {
            em.getTransaction().begin();
            course = em.createQuery("select c from Course c where c.displayCourseId=:courseId", Course.class)
                    .setParameter("courseId", courseId)
                    .getSingleResult();
            em.getTransaction().commit();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return course;
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

    @Override
    public Course getCourseByName(String courseName) {
        Course course = new Course();
        System.out.println(courseName);
        try(EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager()) {
            em.getTransaction().begin();
            course = em.createQuery("select c from Course c where c.courseName=:courseName",Course.class)
                            .setParameter("courseName",courseName)
                                    .getSingleResult();
            em.getTransaction().commit();
        }catch (Exception e){
            System.out.println(e.getMessage());
        }

        return course;
    }
}
