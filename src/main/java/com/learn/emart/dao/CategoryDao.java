package com.learn.emart.dao;

import com.learn.emart.entities.Category;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class CategoryDao {

    private SessionFactory factory;

    public CategoryDao(SessionFactory factory) {
        this.factory = factory;
    }

    // Save category
    public int saveCategory(Category cat) {

        Session session = this.factory.openSession();
        Transaction tx = session.beginTransaction();

        int categoryId = (int) session.save(cat);

        tx.commit();
        session.close();

        return categoryId;
    }

    // Get all categories
    public List<Category> getCategories() {

        Session session = this.factory.openSession();

        Query<Category> query = session.createQuery("from Category", Category.class);

        List<Category> list = query.list();

        session.close();

        return list;
    }
}