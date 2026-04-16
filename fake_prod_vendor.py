import random
from datetime import datetime, timedelta

def generate_product_vendor_sql(filename, num_records=500):
    # Assuming you have roughly 20 vendors in your Vendor table
    vendor_ids = list(range(1, 21))
    
    with open(filename, 'w') as f:
        records_created = 0
        current_product_id = 21
        
        while records_created < num_records:
            # Randomly decide if this product has 1 or 2 vendors
            num_vendors_for_this_prod = random.choice([1, 2])
            
            # Pick unique vendors for this specific product to avoid PK conflicts
            assigned_vendors = random.sample(vendor_ids, num_vendors_for_this_prod)
            
            for v_id in assigned_vendors:
                if records_created >= num_records:
                    break
                
                # Vendor price is usually lower than retail (between 5.00 and 150.00)
                vend_price = round(random.uniform(5.00, 150.00), 2)
                
                # Random date between 2022 and 2024
                start_date = datetime(2022, 1, 1)
                random_days = random.randint(0, 1000)
                vend_date = (start_date + timedelta(days=random_days)).strftime('%Y-%m-%d')
                
                sql_statement = (
                    f"INSERT INTO Product_Vendor (vendor_id, product_id, prod_vend_price, prod_vend_date) "
                    f"VALUES ({v_id}, {current_product_id}, {vend_price}, '{vend_date}');\n"
                )
                
                f.write(sql_statement)
                records_created += 1
            
            current_product_id += 1
            # Reset product ID if we run out of products before reaching 500 vendor records
            if current_product_id > 520:
                current_product_id = 21

    print(f"Successfully generated {num_records} Product_Vendor records in {filename}")

if __name__ == "__main__":
    generate_product_vendor_sql("insert_product_vendor.sql", 500)