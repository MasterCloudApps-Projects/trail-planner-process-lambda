import psycopg2
from psycopg2 import Error
import os

rds_host = os.environ.get('RDS_HOST')
username = os.environ.get('RDS_DB_USERNAME')
password = os.environ.get('RDS_DB_PASSWORD')
db_name = os.environ.get('RDS_DB_NAME')

def lambda_handler(event, context):
    try:
        connection = psycopg2.connect(user=username,
                                      password=password,
                                      host=rds_host,
                                      port="5432",
                                      database=db_name)

        cursor = connection.cursor()
        # SQL query to create a new table
        create_table_query = '''CREATE TABLE mobile
              (ID INT PRIMARY KEY     NOT NULL,
              MODEL           TEXT    NOT NULL,
              PRICE         REAL); '''
        # Execute a command: this creates a new table
        cursor.execute(create_table_query)
        connection.commit()
        print("Table created successfully in PostgreSQL ")

        cursor = connection.cursor()
        # Executing a SQL query to insert data into  table
        insert_query = """ INSERT INTO mobile (ID, MODEL, PRICE) VALUES (1, 'Iphone12', 1100)"""
        cursor.execute(insert_query)
        connection.commit()
        print("1 Record inserted successfully")
        # Fetch result
        cursor.execute("SELECT * from mobile")
        record = cursor.fetchall()
        print("Result ", record)

    except (Exception, Error) as error:
        print("Error while connecting to PostgreSQL", error)
    finally:
        if connection:
            cursor.close()
            connection.close()
            print("PostgreSQL connection is closed")