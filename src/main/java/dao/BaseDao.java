package dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.orm.hibernate5.HibernateTemplate;

import com.mongodb.DB;

public class BaseDao {
    protected SessionFactory sessionFactory;
    protected HibernateTemplate hibernateTemplate;
    
    protected MongoTemplate mongoTemplate;

    /* ========================================================= */
    
    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }
    public SessionFactory getSessionFactory() {
        return this.sessionFactory;
    }
    
    public HibernateTemplate getHibernateTemplate() {
        return hibernateTemplate;
    }
    public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
        this.hibernateTemplate = hibernateTemplate;
    }
    
    public Session getSession() {
        return this.sessionFactory.getCurrentSession();
    }
    
    /* ===================== */
    
    public MongoTemplate getMongoTemplate() {
        return mongoTemplate;
    }
    public void setMongoTemplate(MongoTemplate mongoTemplate) {
        this.mongoTemplate = mongoTemplate;
    }
    public DB getMongoDb() {
        return this.mongoTemplate.getDb();
    }
}