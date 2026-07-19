package com.learn.emart.dao;

import com.learn.emart.entities.Orders;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class OrderDao {

    private SessionFactory factory;

    public OrderDao(SessionFactory factory) {
        this.factory = factory;
    }

    // Save Order
    public boolean saveOrder(Orders order) {

        boolean flag = false;

        try {

            Session session = factory.openSession();
            Transaction tx = session.beginTransaction();

            session.save(order);

            tx.commit();
            session.close();

            flag = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return flag;
    }

    // Get All Orders
    public List<Orders> getAllOrders() {

        Session session = factory.openSession();

        Query<Orders> query = session.createQuery("from Orders", Orders.class);

        List<Orders> list = query.list();

        session.close();

        return list;
    }

    // Get Order By ID
    public Orders getOrderById(int orderId) {

        Session session = factory.openSession();

        Orders order = session.get(Orders.class, orderId);

        session.close();

        return order;
    }

    // Update Order
    public boolean updateOrder(Orders order) {

        boolean flag = false;

        try {

            Session session = factory.openSession();
            Transaction tx = session.beginTransaction();

            session.update(order);

            tx.commit();
            session.close();

            flag = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return flag;
    }

    // Delete Order
    public boolean deleteOrder(Orders order) {

        boolean flag = false;

        try {

            Session session = factory.openSession();
            Transaction tx = session.beginTransaction();

            session.delete(order);

            tx.commit();
            session.close();

            flag = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return flag;
    }

    // Get Orders of Particular User
    public List<Orders> getOrdersByUser(int userId) {

        Session session = factory.openSession();

        Query<Orders> query = session.createQuery(
                "from Orders where user.userId = :uid",
                Orders.class);

        query.setParameter("uid", userId);

        List<Orders> list = query.list();

        session.close();

        return list;
    }
}
