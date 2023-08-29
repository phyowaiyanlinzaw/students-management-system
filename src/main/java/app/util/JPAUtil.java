package app.util;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JPAUtil {

    static EntityManagerFactory emFactory = null;

    public static EntityManagerFactory getEntityManagerFactory() {
        return emFactory = Persistence.createEntityManagerFactory("StudentsJPA");
    }
}
