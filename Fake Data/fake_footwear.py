import random

def generate_footwear_sql(filename, num_records=500):
    # Data pools for Footwear
    cleat_types = ['FG', 'SG', 'IC', 'AG', 'TF'] # Firm Ground, Soft Ground, Indoor, etc.
    colors = [
        'Navy/White', 'Red/White', 'Red/Black', 'Blue/White', 
        'Black/Red', 'Blue/Gold', 'White/Silver', 'Volt/Black', 
        'Orange/Black', 'Pink/White', 'Black/Black', 'Yellow/Blue'
    ]
    
    # Generate list of sizes from 6 to 13 in 0.5 increments
    sizes = []
    current_size = 6.0
    while current_size <= 13.0:
        # Convert to string, removing .0 for whole numbers to match your style
        val = str(current_size).replace('.0', '')
        sizes.append(val)
        current_size += 0.5

    with open(filename, 'w') as f:
        # Assuming product_ids 1-500
        for i in range(1, num_records + 1):
            product_id = i
            foot_size = random.choice(sizes)
            foot_cleat_type = random.choice(cleat_types)
            foot_color = random.choice(colors)

            # Formatting as individual INSERT statements
            sql_statement = (
                f"INSERT INTO Footwear (product_id, foot_size, foot_cleat_type, foot_color) "
                f"VALUES ({product_id}, '{foot_size}', '{foot_cleat_type}', '{foot_color}');\n"
            )
            
            f.write(sql_statement)

    print(f"Successfully generated {num_records} Footwear records in {filename}")

if __name__ == "__main__":
    generate_footwear_sql("insert_footwear.sql", 500)