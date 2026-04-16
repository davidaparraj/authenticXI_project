import random

def generate_product_sql(filename, num_records=500):
    # Data pools for variety
    teams = [
        "Real Madrid", "Barcelona", "Manchester United", "Man City", "Liverpool", 
        "Chelsea", "Arsenal", "PSG", "Bayern Munich", "Juventus", "LA Galaxy", "Inter Miami"
    ]
    brands = ["Nike", "Adidas", "Puma", "Umbro", "New Balance", "Mizuno", "Authentic XI"]
    types = ["Jersey", "Footwear", "Accessories", "Equipment"]
    seasons = ["2013/14", "2016/17", "2019/20", "2021/22", "2022/23", "2023/24", "2024/25"]
    
    items = {
        "Jersey": ["Home Jersey", "Away Jersey", "Third Jersey", "Retro Jersey"],
        "Footwear": ["Phantom GX 2 FG", "Future 7 AG", "Future 7 FG", "Speedportal.1", "Copa Pure"],
        "Accessories": ["Water Bottle", "Mini Pennant", "Club Scarf", "Key Ring", "Wristband Set", "Pin Badge Set"],
        "Equipment": ["Training Ball", "Shin Guards", "Captain's Armband"]
    }

    with open(filename, 'w') as f:
        for _ in range(num_records):
            # Pick random attributes
            team_id = random.randint(1, 20)
            team_name = random.choice(teams)
            p_type = random.choice(types)
            p_brand = random.choice(brands)
            p_season = random.choice(seasons)
            
            # Logic for Product Name
            item_base = random.choice(items[p_type])
            if p_type in ["Jersey", "Accessories"]:
                prod_name = f"{team_name} {item_base} {p_season}" if p_type == "Jersey" else f"{team_name} {item_base}"
            else:
                prod_name = f"{p_brand} {item_base}"
            
            # Price formatting (XX.99)
            price = round(random.uniform(9.99, 250.00), 2)
            if not str(price).split('.')[1] == '99': # Force the .99 aesthetic
                price = float(f"{int(price)}.99")

            # Updated format: Every line is a full, independent INSERT statement
            sql_statement = (
                f"INSERT INTO Product (team_id, prod_name, prod_price, prod_brand, prod_season, prod_type) "
                f"VALUES ({team_id}, '{prod_name}', {price}, '{p_brand}', '{p_season}', '{p_type}');\n"
            )
            
            f.write(sql_statement)

    print(f"Successfully generated {num_records} individual INSERT statements in {filename}")

if __name__ == "__main__":
    generate_product_sql("insert_products.sql", 500)