import random
from faker import Faker
from datetime import datetime, timedelta

def generate_shipment_sql(filename, num_records=480):
    fake = Faker()
    carriers = ['UPS', 'FedEx', 'USPS', 'Amazon Logistics', 'DHL']
    statuses = ['Delivered', 'In Transit', 'Pending', 'Shipped']
    
    with open(filename, 'w') as f:
        # Loop through invoice_ids 21 to 480
        for i in range(21, 21 + num_records):
            invoice_id = i
            
            # Generate a clean one-line address
            address = fake.address().replace('\n', ', ').replace("'", "''")
            
            carrier = random.choice(carriers)
            status = random.choices(statuses, weights=[70, 15, 10, 5])[0]
            
            # Logic: If status is Pending, the delivery date is NULL
            if status == 'Pending':
                ship_date = "NULL"
            else:
                # Generate random date for the past year
                start_date = datetime(2023, 1, 1)
                random_days = random.randint(0, 400)
                delivery_dt = start_date + timedelta(days=random_days)
                ship_date = f"'{delivery_dt.strftime('%Y-%m-%d')}'"

            sql_statement = (
                f"INSERT INTO Shipment (invoice_id, ship_address, ship_date, ship_carrier, ship_delivery_status) "
                f"VALUES ({invoice_id}, '{address}', {ship_date}, '{carrier}', '{status}');\n"
            )
            
            f.write(sql_statement)

    print(f"Successfully generated {num_records} Shipment records in {filename}")

if __name__ == "__main__":
    generate_shipment_sql("insert_shipments.sql", 480)