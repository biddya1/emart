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

    // Save Category
    public int saveCategory(Category cat) {

        Session session = this.factory.openSession();
        Transaction tx = session.beginTransaction();

        int categoryId = (int) session.save(cat);

        tx.commit();
        session.close();

        return categoryId;
    }

    // Get All Categories
    public List<Category> getCategories() {

        Session session = this.factory.openSession();

        Query<Category> query = session.createQuery("from Category", Category.class);

        List<Category> list = query.list();

        session.close();

        return list;
    }

    // Delete Category
    public boolean deleteCategory(Category category) {

        boolean f = false;

        try {

            Session session = this.factory.openSession();

            Transaction tx = session.beginTransaction();

            session.delete(category);

            tx.commit();

            session.close();

            f = true;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return f;
    }

    // Get Category By ID
    public Category getCategoryById(int cid) {

        Category cat = null;

        try {

            Session session = this.factory.openSession();

            // ************ THIS WAS THE MISSING LINE ************
            cat = session.get(Category.class, cid);
            // ***************************************************

            session.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return cat;
    }

}