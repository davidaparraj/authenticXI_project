import random
from datetime import datetime, timedelta

def generate_payment_sql(filename, num_records=500):
    methods = ['Credit Card', 'Debit Card', 'Google Pay', 'Apple Pay', 'PayPal']
    statuses = ['Completed', 'Completed', 'Completed', 'Failed', 'Refunded'] # Weighted toward Completed
    
    with open(filename, 'w') as f:
        # Starting from ID 21 as per your request
        for i in range(21, 21 + num_records):
            pymt_method = random.choice(methods)
            pymt_status = random.choice(statuses)
            
            # Generate random timestamp within the last 2 years
            start_date = datetime(2023, 1, 1)
            random_seconds = random.randint(0, 60*60*24*730) # 2 years of seconds
            pymt_time = start_date + timedelta(seconds=random_seconds)
            time_str = pymt_time.strftime('%Y-%m-%d %H:%M:%S')
            
            # Formatted Transaction Reference with leading zeros
            # TXN-AX-000021, etc.
            trans_ref = f"TXN-AX-{str(i).zfill(6)}"
            
            # Random amount between 10.00 and 500.00
            amt = round(random.uniform(10.00, 500.00), 2)

            sql_statement = (
                f"INSERT INTO Payment (pymt_method, pymt_date, pymt_status, pymt_trans_ref, pymt_amt) "
                f"VALUES ('{pymt_method}', '{time_str}', '{pymt_status}', '{trans_ref}', {amt});\n"
            )
            
            f.write(sql_statement)

    print(f"Successfully generated {num_records} Payment records in {filename}")

if __name__ == "__main__":
    generate_payment_sql("insert_payments.sql", 500)