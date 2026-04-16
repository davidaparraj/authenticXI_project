import random

def generate_invoice_items_sql(filename, num_invoices=480):
    with open(filename, 'w') as f:
        # We are looping through invoice_ids 21 to 480
        for inv_id in range(21, 21 + num_invoices):
            
            # Randomly decide how many different products are in this invoice (1 to 3)
            num_items = random.choices([1, 2, 3], weights=[70, 20, 10])[0]
            
            # Pick unique product IDs for this invoice to avoid primary key issues
            # Assuming product IDs 1-500 exist
            product_ids = random.sample(range(1, 480), num_items)
            
            for prod_id in product_ids:
                quantity = random.randint(1, 5)
                
                # prod_price_at_time is the price when they bought it
                # (Standard retail range)
                price = round(random.uniform(10.00, 250.00), 2)
                
                sql_statement = (
                    f"INSERT INTO Invoice_item (invoice_id, product_id, prod_quantity, prod_price_at_time) "
                    f"VALUES ({inv_id}, {prod_id}, {quantity}, {price});\n"
                )
                
                f.write(sql_statement)

    print(f"Successfully generated Invoice_item records for {num_invoices} invoices in {filename}")

if __name__ == "__main__":
    generate_invoice_items_sql("insert_invoice_items.sql", 480)