package com.example.ecommerce.controller;

import com.example.ecommerce.model.Shipment;
import com.example.ecommerce.service.ShipmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/shipment")
public class ShipmentController {
    @Autowired
    private ShipmentService shipmentService;

    @PostMapping
    public Shipment createShipment(@RequestBody Shipment shipment) {
        return shipmentService.createShipment(shipment);
    }

    @GetMapping("/{shipmentId}")
    public Shipment getShipmentById(@PathVariable String shipmentId) {
        return shipmentService.getShipmentById(shipmentId);
    }
}