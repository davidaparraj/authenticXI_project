import random
from faker import Faker

def generate_customer_sql(filename, num_records=500):
    fake = Faker()
    
    # Using 'w' to overwrite the file every time the script runs
    with open(filename, 'w') as f:
        f.write("-- Automated Customer Data Export\n")
        
        for _ in range(num_records):
            # Generating fake data points
            fname = fake.first_name()
            lname = fake.last_name()
            # Formatting phone to match your example
            phone = fake.numerify('###-555-####')
            # Replacing newlines in addresses with spaces for SQL compatibility
            address = fake.address().replace('\n', ', ')
            email = f"{fname.lower()}.{lname.lower()}@{fake.free_email_domain()}"
            
            # Cleaning apostrophes in names (like O'Connor) to prevent SQL errors
            fname = fname.replace("'", "''")
            lname = lname.replace("'", "''")
            address = address.replace("'", "''")

            # Building the SQL string
            sql_line = (
                f"INSERT INTO Customer (cust_fname, cust_lname, cust_ph_num, cust_address, cust_email) "
                f"VALUES ('{fname}', '{lname}', '{phone}', '{address}', '{email}');\n"
            )
            
            f.write(sql_line)

    print(f"Successfully generated {num_records} records in {filename}")

if __name__ == "__main__":
    generate_customer_sql("insert_customers.sql", 500)