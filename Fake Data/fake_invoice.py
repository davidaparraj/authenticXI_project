import random
from datetime import datetime, timedelta

def generate_invoice_sql(filename, num_records=500):
    # Status options for the order lifecycle
    statuses = ['Processing', 'Shipped', 'Delivered', 'Cancelled']
    
    # Assuming you have 500 customers in your Customer table
    customer_ids = list(range(1, 501))
    
    with open(filename, 'w') as f:
        # payment_id starts at 21 to match your previous Payment script
        for i in range(21, 21 + num_records):
            customer_id = random.choice(customer_ids)
            payment_id = i
            inv_status = random.choice(statuses)
            
            # Generating a random timestamp for the invoice
            start_date = datetime(2023, 1, 1)
            random_seconds = random.randint(0, 60*60*24*730)
            inv_time = start_date + timedelta(seconds=random_seconds)
            time_str = inv_time.strftime('%Y-%m-%d %H:%M:%S')

            sql_statement = (
                f"INSERT INTO Invoice (customer_id, payment_id, inv_date, inv_status) "
                f"VALUES ({customer_id}, {payment_id}, '{time_str}', '{inv_status}');\n"
            )
            
            f.write(sql_statement)

    print(f"Successfully generated {num_records} Invoice records in {filename}")

if __name__ == "__main__":
    generate_invoice_sql("insert_invoices.sql", 500)