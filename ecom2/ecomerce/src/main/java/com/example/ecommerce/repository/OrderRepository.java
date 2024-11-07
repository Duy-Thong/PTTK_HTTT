package com.example.ecommerce.repository;

import com.example.ecommerce.model.*;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order, Integer> {
    List<Order> findByCart(Cart cart);

    List<Order> findByPayment(Payment payment);

    List<Order> findByShipment(Shipment shipment);

    List<Order> findByCustomer(Customer customer);
}
