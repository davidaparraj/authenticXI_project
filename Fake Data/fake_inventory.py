import random
from datetime import datetime, timedelta

def generate_inventory_sql(filename, num_records=480):
    warehouses = ['A', 'B', 'C', 'D', 'E']
    
    with open(filename, 'w') as f:
        # Starting from ID 21 as per your example
        for i in range(21, 21 + num_records):
            product_id = i
            quantity = random.randint(1, 480)
            
            # Generate a random date within the last 2 years
            start_date = datetime(2023, 1, 1)
            end_date = datetime(2024, 12, 31)
            time_between_dates = end_date - start_date
            days_between_dates = time_between_dates.days
            random_number_of_days = random.randrange(days_between_dates)
            random_date = start_date + timedelta(days=random_number_of_days)
            date_str = random_date.strftime('%Y-%m-%d')
            
            # Create a location string
            warehouse = random.choice(warehouses)
            shelf = random.randint(1, 20)
            location = f"Warehouse {warehouse} - Shelf {shelf}"
            
            # Single statement style
            sql_statement = (
                f"INSERT INTO Inventory (product_id, invent_quantity,invent_update_date,invent_location) "
                f"VALUES ({product_id}, {quantity}, '{date_str}', '{location}');\n"
            )
            
            f.write(sql_statement)

    print(f"Successfully generated {num_records} Inventory records in {filename}")

if __name__ == "__main__":
    generate_inventory_sql("insert_inventory.sql", 480)