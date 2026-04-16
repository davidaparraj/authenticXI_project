import random

def generate_accessories_sql(filename, num_records=500):
    # Data pools for accessories
    # Using a dictionary to pair types with a basic description
    accy_data = {
        'Scarf': 'Official club scarf merchandise',
        'Pennant': 'Official club pennant merchandise',
        'Cushion': 'Official club cushion merchandise',
        'Tote Bag': 'Official club tote bag merchandise',
        'Key Ring': 'Official club key ring merchandise',
        'Water Bottle': 'Official club hydration merchandise',
        'Wristband': 'Official club athletic wristband',
        'Pin Badge': 'Official club collectible pin'
    }
    
    sizes = ['One Size', 'S/M', 'M/L', '12 inch', 'Standard', 'Small', 'Large']

    with open(filename, 'w') as f:
        # Assuming product_ids continue from where your jerseys or other products left off
        # If your Accessories start at a specific ID, change the range start
        for i in range(1, num_records + 1):
            product_id = i
            
            # Pick a random accessory type and its matching description
            accy_type = random.choice(list(accy_data.keys()))
            accy_descript = accy_data[accy_type]
            accy_size = random.choice(sizes)

            # Formatting as individual INSERT statements
            sql_statement = (
                f"INSERT INTO Accessories (product_id, accy_type, accy_descript, accy_size) "
                f"VALUES ({product_id}, '{accy_type}', '{accy_descript}', '{accy_size}');\n"
            )
            
            f.write(sql_statement)

    print(f"Successfully generated {num_records} Accessory records in {filename}")

if __name__ == "__main__":
    generate_accessories_sql("insert_accessories.sql", 500)