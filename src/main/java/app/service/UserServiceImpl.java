package app.service;

import app.model.User;
import app.util.JPAUtil;
import app.util.PasswordHelper;
import jakarta.persistence.EntityManager;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("userService")
@Component
public class UserServiceImpl implements UserService{
    @Override
    public int registerUser(User user) {
        int result = 0;
        try (EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager()) {
            em.getTransaction().begin();
            String hashedPassword = PasswordHelper.hashPassword(user.getUserPassword());
            user.setUserPassword(hashedPassword);
            user.setUserRole("user");
            user.setStatus("active");
            em.persist(user);
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
    public int updateUser(User user) {
        int result = 0;
        try (EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager()) {
            em.getTransaction().begin();
            em.merge(user);
            em.getTransaction().commit();
            result = 1;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return result;
    }

    @Override
    public int deleteUser(int userId) {
        int result = 0;
        try (EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager()) {
            em.getTransaction().begin();
            User user = em.find(User.class, userId);
            em.remove(user);
            em.getTransaction().commit();
            result = 1;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return result;
    }

    @Override
    public User getOneUser(int userId) {
        User user = null;
        try (EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager()) {
            em.getTransaction().begin();
            user = em.find(User.class, userId);
            em.getTransaction().commit();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return user;
    }

    @Override
    public List<User> getAllUsers() {
        List<User> userList = new ArrayList<>();
        try (EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager()) {
            em.getTransaction().begin();
            userList = em.createQuery("SELECT u FROM User u where u.userRole = :userRole and u.status=:status", User.class)
                    .setParameter("userRole", "user")
                    .setParameter("status","active")
                    .getResultList();
            em.getTransaction().commit();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return userList;
    }

    @Override
    public List<User> getAllUsersAndAdmin() {
        List<User> userList = new ArrayList<>();
        try (EntityManager em = JPAUtil.getEntityManagerFactory().createEntityManager()) {
            em.getTransaction().begin();
            userList = em.createQuery("SELECT u FROM User u where u.status=:userStatus", User.class)
                    .setParameter("userStatus","active")
                    .getResultList();
            em.getTransaction().commit();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return userList;
    }
}
