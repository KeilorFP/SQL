# SQL
# Case Study | Business Intelligence and Visualization
Introduction
A year ago, María decided to start her own online sales business, which she named “TodoLoQueNecesitas.com.”
Initially, she recorded all business information in Excel spreadsheets, but due to the company's growth in recent months, she realized the need to design and implement a database to register sales. This would help her keep track of suppliers, customers, products, and sales.
Therefore, María has contacted you, an expert database designer and manager, to help improve her business.

Problem Statement
After several meetings, the following points have been defined to design the database:

The information needed for suppliers includes: their unique supplier ID, name, address, phone number, and website.
A supplier can provide different products, and a product can be supplied by more than one supplier.
For a customer, the information to store includes: their unique customer code, name, address, and multiple contact phone numbers.
For both suppliers and customers, each address should contain details such as street, number, city, and region.
The products sold have the following information: their unique ID, name, price, current stock, and the supplier's name who sells them.
Products are organized into categories, and each product can only be classified under one category, while a category can contain multiple products. The information to be stored for each category includes: the unique ID, name, and description.
The most important information to store is about each sale. Each sale includes: a unique invoice number, date, customer, discount, and total cost.
Additionally, each sale consists of multiple products, with information about the price at which each product was sold and the units sold.
It’s important to note that a product can be part of several sales but might also never have been sold. Also, each customer can be involved in multiple sales, but each sale will only involve one customer.

