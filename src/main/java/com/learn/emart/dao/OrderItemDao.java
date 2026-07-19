package com.learn.emart.dao;

import com.learn.emart.entities.OrderItem;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class OrderItemDao {

    private SessionFactory factory;

    public OrderItemDao(SessionFactory factory) {
        this.factory = factory;
    }

    // Save single order item
    public boolean saveOrderItem(OrderItem item) {
        boolean flag = false;
        try {
            Session session = factory.openSession();
            Transaction tx = session.beginTransaction();
            session.save(item);
            tx.commit();
            session.close();
            flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }

    // Get all items belonging to a particular order
    public List<OrderItem> getItemsByOrderId(int orderId) {
        Session session = factory.openSession();
        Query<OrderItem> query = session.createQuery(
                "from OrderItem where order.orderId = :oid",
                OrderItem.class);
        query.setParameter("oid", orderId);
        List<OrderItem> list = query.list();
        session.close();
        return list;
    }
}
