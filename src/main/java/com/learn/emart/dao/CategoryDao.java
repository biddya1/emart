package com.learn.emart.dao;

import com.learn.emart.entities.Category;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

public class CategoryDao {

    private SessionFactory factory;

    public CategoryDao(SessionFactory factory) {
        this.factory = factory;
    }

    // Save category to database
    public int saveCategory(Category cat) {

        Session session = this.factory.openSession();
        Transaction tx = session.beginTransaction();

        int categoryId = (int) session.save(cat);

        tx.commit();
        session.close();

        return categoryId;
    }
}