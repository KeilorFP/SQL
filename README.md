# 🧾 SQL Case Study: Business Intelligence for TodoLoQueNecesitas.com

This project focuses on the **design, implementation, and analysis of a sales database** for a growing e-commerce business: **TodoLoQueNecesitas.com**. It simulates a real-world consulting case, where you act as the business intelligence and database expert responsible for optimizing data management and enabling actionable insights.

Developed as part of the Business Intelligence & Visualization module at **IMMUNE Technology Institute**.

---

## 🎯 Business Context

María, the founder of TodoLoQueNecesitas.com, originally tracked sales using Excel. As her online store grew, she needed a more robust and scalable data system. You were hired to:

- **Design a relational database** to track customers, suppliers, products, and sales.
- **Implement the schema in SQL**
- **Generate key queries** to support business decision-making.
- **(Optional)** Visualize sales KPIs using BI tools.

---

## 🧩 Requirements & Data Model

### 📦 Entities & Relationships

The following entities and relationships were modeled:

#### 🧑 Customers
- `CustomerID` (Primary Key)
- Name, Address (street, number, city, region), Multiple phone numbers

#### 🏢 Suppliers
- `SupplierID` (Primary Key)
- Name, Address, Phone, Website
- A supplier can provide multiple products

#### 📦 Products
- `ProductID` (Primary Key)
- Name, Price, Stock, CategoryID, Supplier relationships (many-to-many)

#### 🗂️ Categories
- `CategoryID` (Primary Key)
- Name, Description
- One-to-many with products

#### 🧾 Sales
- `InvoiceNumber` (Primary Key)
- Date, `CustomerID` (foreign key), Discount, Total
- A sale can include **multiple products** (many-to-many via `SaleDetails`)

#### 🧾 SaleDetails (junction table)
- `InvoiceNumber`, `ProductID`
- Quantity, Sale Price

---

## 🛠️ Project Structure

### 1. 📐 Database Design
- Created **ER Diagram**
- Normalized data up to 3NF
- Defined primary and foreign keys

### 2. 🧱 SQL Implementation
- Wrote scripts to:
  - Create tables
  - Define relationships
  - Insert sample/mock data for testing

### 3. 🔍 Business Queries
Examples of insights generated:
- Top-selling products
- Sales by category and month
- Customers with highest lifetime value
- Unsold products
- Supplier contribution to total sales

### 4. 📊 (Optional) BI Dashboard
If using a visualization tool:
- KPIs: Total Revenue, Avg Discount, Products per Sale
- Charts: Sales over time, Revenue by category/supplier

---

## 🧰 Tools & Technologies

- MySQL / PostgreSQL / SQLite
- SQL DDL & DML
- (Optional) Power BI / Tableau / Excel Pivot Tables
- ERD tool (draw.io / dbdiagram.io)

---
