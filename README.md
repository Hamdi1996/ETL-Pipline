
# ETL Pipeline Project

This project demonstrates an ETL (Extract, Transform, Load) pipeline for extracting user data from a remote JSON API, transforming it, and loading it into a PostgreSQL database.

## Project Overview

The ETL pipeline consists of the following steps:

1. **Extract**: Fetch data from a remote JSON API.
2. **Transform**: Clean and reshape the data into a structure suitable for storage.
3. **Load**: Insert the transformed data into a PostgreSQL database.

## Prerequisites

Before running the ETL pipeline, ensure you have the following installed:

- **Python** (3.x)
- **PostgreSQL** Database Server
- **Apache Airflow** (Optional for automation)
- **Required Python Libraries**:
  - `requests`
  - `psycopg2`
  - `sqlalchemy`
  - `pandas`
  - `airflow` (for scheduling)

To install the required Python libraries, run:
```bash
pip install requests psycopg2 sqlalchemy pandas apache-airflow
```

## Database Setup

### 1. Install PostgreSQL

Make sure PostgreSQL is installed on your machine:
```bash
sudo apt update
sudo apt install postgresql postgresql-contrib
```

### 2. Create the Database

Log in to PostgreSQL and create the `etlpipline_db` database:
```bash
sudo -u postgres psql
CREATE DATABASE etlpipline_db;
\q
```

### 3. Create Database Tables

Use SQLAlchemy models to create tables in the `etlpipline_db` database. The following tables will be created:

- **Users Table**
- **Hair Table**
- **Address Table**

The `Users` table holds basic user information, while the `Hair` and `Address` tables are used to store nested data.

You can define the models as follows:
```python
from sqlalchemy import create_engine, Column, Integer, String, Float
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship, sessionmaker

Base = declarative_base()

class User(Base):
    __tablename__ = 'users'
    id = Column(Integer, primary_key=True)
    first_name = Column(String)
    last_name = Column(String)
    age = Column(Integer)
    email = Column(String)

class Hair(Base):
    __tablename__ = 'hair'
    id = Column(Integer, primary_key=True)
    color = Column(String)
    type = Column(String)
    user_id = Column(Integer, ForeignKey('users.id'))

class Address(Base):
    __tablename__ = 'addresses'
    id = Column(Integer, primary_key=True)
    address = Column(String)
    city = Column(String)
    state = Column(String)
    user_id = Column(Integer, ForeignKey('users.id'))

# Database connection string
DATABASE_URI = 'postgresql://postgres:password@localhost/etlpipline_db'
engine = create_engine(DATABASE_URI)
Base.metadata.create_all(engine)
```

## ETL Pipeline

### 1. Extract Data

In the **Extract** step, you will fetch user data from a public API (e.g., `https://dummyjson.com/users`):
```python
import requests

def extract_users():
    url = "https://dummyjson.com/users"
    response = requests.get(url)
    return response.json()['users']
```

### 2. Transform Data

The **Transform** step reshapes and cleans the data, breaking it down into individual pieces that can be loaded into different tables:

```python
def transform_user(user):
    user_data = {
        "id": user["id"],
        "first_name": user["firstName"],
        "last_name": user["lastName"],
        "age": user["age"],
        "email": user["email"],
    }

    hair_data = user.get("hair", {})
    address_data = user.get("address", {})

    return user_data, hair_data, address_data
```

### 3. Load Data

In the **Load** step, the transformed data is inserted into the PostgreSQL database:

```python
from sqlalchemy.orm import sessionmaker
from sqlalchemy import create_engine

# Setup database connection and session
DATABASE_URI = 'postgresql://postgres:password@localhost/etlpipline_db'
engine = create_engine(DATABASE_URI)
Session = sessionmaker(bind=engine)
session = Session()

def load_data(users):
    for user in users:
        # Transform data
        user_data, hair_data, address_data = transform_user(user)

        # Create User object
        user_obj = User(
            id=user_data["id"],
            first_name=user_data["first_name"],
            last_name=user_data["last_name"],
            age=user_data["age"],
            email=user_data["email"],
        )

        # Create Hair object
        if hair_data:
            hair_obj = Hair(color=hair_data.get("color"), type=hair_data.get("type"))
            user_obj.hair.append(hair_obj)

        # Create Address object
        if address_data:
            address_obj = Address(
                address=address_data.get("address"),
                city=address_data.get("city"),
                state=address_data.get("state"),
            )
            user_obj.address.append(address_obj)

        # Add to session
        session.add(user_obj)

    # Commit all data
    session.commit()
```

### 4. Running the ETL Pipeline

To run the ETL pipeline, simply execute the following function:
```python
def etl_pipeline():
    users = extract_users()
    load_data(users)
    print("ETL pipeline completed successfully.")
```

Run the script:
```bash
python etl_pipeline.py
```

---

## Automating with Apache Airflow

If you want to automate the ETL pipeline, you can schedule it using **Apache Airflow**.

1. **Install Airflow** (if not already installed):
   ```bash
   pip install apache-airflow
   ```

2. **Create a DAG** for the ETL pipeline:
   
```python
from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime

def run_etl_pipeline():
    etl_pipeline()

default_args = {
    'owner': 'airflow',
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

with DAG(
    'etl_pipeline',
    default_args=default_args,
    description='ETL Pipeline DAG',
    schedule_interval='@daily',
    start_date=datetime(2024, 12, 18),
    catchup=False,
) as dag:
    etl_task = PythonOperator(
        task_id='run_etl_pipeline',
        python_callable=run_etl_pipeline,
    )
```

3. **Run the DAG** in Airflow:
   ```bash
   airflow dags list
   airflow dags trigger etl_pipeline
   ```

---

## Conclusion

This project covers the essential steps of an ETL pipeline using Python, PostgreSQL, and optionally Apache Airflow for automation. It demonstrates how to extract, transform, and load data into a database, providing a solid foundation for further data processing tasks.

Let me know if you need more help or further explanations!
