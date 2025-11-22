#!/bin/bash

# Base URL
BASE_URL="http://localhost:8080/products"

# Create a product
echo "Creating product..."
curl -X POST $BASE_URL \
  -H "Content-Type: application/json" \
  -d '{"name": "iPhone 15", "sku": "IP15-128", "description": "Latest iPhone", "price": 999.99, "discount": 0.0, "metadata": "color:black"}'
echo -e "\n"

# Get all products
echo "Getting all products..."
curl -X GET $BASE_URL
echo -e "\n"

# Search product by name
echo "Searching product by name 'iPhone 15'..."
curl -X GET "$BASE_URL/search?name=iPhone%2015"
echo -e "\n"

# Update product (assuming ID 1)
echo "Updating product with ID 1..."
curl -X PUT "$BASE_URL/1" \
  -H "Content-Type: application/json" \
  -d '{"name": "iPhone 15 Pro", "sku": "IP15P-128", "description": "Latest iPhone Pro", "price": 1199.99, "discount": 50.0, "metadata": "color:titanium"}'
echo -e "\n"

# Get product by ID
echo "Getting product by ID 1..."
curl -X GET "$BASE_URL/1"
echo -e "\n"

# Delete product (assuming ID 1)
echo "Deleting product with ID 1..."
curl -X DELETE "$BASE_URL/1"
echo -e "\n"

# Get all products again to verify deletion
echo "Getting all products after deletion..."
curl -X GET $BASE_URL
echo -e "\n"
