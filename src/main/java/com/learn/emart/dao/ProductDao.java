package com.learn.emart.dao;

import com.learn.emart.entities.Product;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

public class ProductDao {

    private SessionFactory factory;

    public ProductDao(SessionFactory factory) {
        this.factory = factory;
    }

    // Save Product
    public boolean saveProduct(Product product) {

        boolean f = false;

        try {

            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();

            session.save(product);

            tx.commit();
            session.close();

            f = true;

        } catch (Exception e) {
            e.printStackTrace();
            f = false;
        }

        return f;
    }

    // Get All Products
    public List<Product> getAllProducts() {

        Session session = this.factory.openSession();

        Query query = session.createQuery("from Product");

        List<Product> list = query.list();

        session.close();

        return list;
    }
    //get all products of given category 
    public List<Product> getAllProductsById(int cid) {

        Session session = this.factory.openSession();

        Query query = session.createQuery("from Product as p where p.category.categoryId=:id");
         query.setParameter("id", cid);
        List<Product> list = query.list();

        session.close();

        return list;
    }

    // Get Product by Id
    public Product getProductById(int pId) {

        Session session = this.factory.openSession();

        Product product = session.get(Product.class, pId);

        session.close();

        return product;
    }

    // Update Product
    public boolean updateProduct(Product product) {

        boolean f = false;

        try {

            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();

            session.update(product);

            tx.commit();
            session.close();

            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }

    // Delete Product
    public boolean deleteProduct(Product product) {

        boolean f = false;

        try {

            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();

            session.delete(product);

            tx.commit();
            session.close();

            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }

}