package com.example.ecommerce.service;

import com.example.ecommerce.model.Cart;
import com.example.ecommerce.model.Customer;
import com.example.ecommerce.model.Item;
import com.example.ecommerce.repository.CartRepository;
import com.example.ecommerce.repository.CustomerRepository;
import com.example.ecommerce.repository.ItemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CartService {
    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private ItemRepository itemRepository;

    @Autowired
    private CustomerRepository customerRepository;  // Add this line

    public Cart createCart(String customerId) {
        Customer customer = customerRepository.findById(customerId).orElseThrow(() -> new RuntimeException("Customer not found"));
        Cart cart = new Cart();
        cart.setCustomer(customer);  // Set the Customer object instead of setting customerId directly
        return cartRepository.save(cart);
    }


    public Cart getCart(String cartId) {
        return cartRepository.findById(cartId).orElse(null);
    }

    public Cart addItemToCart(String cartId, Item item) {
        Cart cart = getCart(cartId);
        if (cart != null) {
            cart.addItem(item);
            cartRepository.save(cart);
        }
        return cart;
    }

    public Cart removeItemFromCart(String cartId, String itemId) {
        Cart cart = getCart(cartId);
        if (cart != null) {
            Item item = itemRepository.findById(itemId).orElse(null);
            if (item != null) {
                cart.removeItem(item);
                cartRepository.save(cart);
            }
        }
        return cart;
    }
}