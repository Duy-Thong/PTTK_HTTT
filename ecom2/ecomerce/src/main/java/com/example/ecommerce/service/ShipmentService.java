package com.example.ecommerce.service;

import com.example.ecommerce.model.Shipment;
import com.example.ecommerce.repository.ShipmentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ShipmentService {
    @Autowired
    private ShipmentRepository shipmentRepository;

    public Shipment createShipment(Shipment shipment) {
        // Logic for creating shipment (e.g., determining shipment status)
        return shipmentRepository.save(shipment);
    }

    public Shipment getShipmentById(String shipmentId) {
        return shipmentRepository.findById(shipmentId).orElse(null);
    }
}