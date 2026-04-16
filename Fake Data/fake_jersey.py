import random

def generate_jersey_sql(filename, num_records=480):
    # Data pools for variety
    sizes = ['XS', 'S', 'M', 'L', 'XL', '2XL', '3XL']
    types = ['Home', 'Away', 'Third', 'Retro', 'Training']
    
    # List of famous players to populate jsy_player_nm
    players = [
        'Rashford', 'Lewandowski', 'Rodri', 'Fernandes', 'Mbappe', 
        'Haaland', 'Vinicius Jr', 'Bellingham', 'Salah', 'De Bruyne', 
        'Saka', 'Kane', 'Messi', 'Ronaldo', 'Modric', 'Son', 
        'Griezmann', 'Musiala', 'Yamal', 'Palmer'
    ]

    with open(filename, 'w') as f:
        for i in range(1, num_records + 1):
            # product_id corresponds to the IDs generated in the Product table
            product_id = i 
            
            jsy_size = random.choice(sizes)
            jsy_type = random.choice(types)
            
            # Logic: 20% chance the jersey is blank (NULL), 80% chance it has a player
            if random.random() < 0.2:
                jsy_player = "NULL"
            else:
                # Wrap player name in quotes
                name = random.choice(players)
                jsy_player = f"'{name}'"

            # Formatting as individual INSERT statements as requested
            sql_statement = (
                f"INSERT INTO Jersey (product_id, jsy_size, jsy_player_nm, jsy_type) "
                f"VALUES ({product_id}, '{jsy_size}', {jsy_player}, '{jsy_type}');\n"
            )
            
            f.write(sql_statement)

    print(f"Successfully generated {num_records} Jersey records in {filename}")

if __name__ == "__main__":
    generate_jersey_sql("insert_jerseys.sql", 480)