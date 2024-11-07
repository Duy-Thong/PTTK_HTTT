package com.example.ecommerce.controller;

import com.example.ecommerce.model.Cart;
import com.example.ecommerce.model.Item;
import com.example.ecommerce.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/cart")
public class CartController {
    @Autowired
    private CartService cartService;

    @PostMapping("/{customerId}")
    public Cart createCart(@PathVariable String customerId) {
        return cartService.createCart(customerId);
    }

    @GetMapping("/{cartId}")
    public Cart getCart(@PathVariable String cartId) {
        return cartService.getCart(cartId);
    }

    @PostMapping("/{cartId}/addItem")
    public Cart addItemToCart(@PathVariable String cartId, @RequestBody Item item) {
        return cartService.addItemToCart(cartId, item);
    }

    @DeleteMapping("/{cartId}/removeItem/{itemId}")
    public Cart removeItemFromCart(@PathVariable String cartId, @PathVariable String itemId) {
        return cartService.removeItemFromCart(cartId, itemId);
    }
}