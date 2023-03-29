"""
Code that goes along with the Airflow located at:
http://airflow.readthedocs.org/en/latest/tutorial.html
"""
from airflow import DAG
#from airflow.operators.bash_operator import BashOperator
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator

from airflow.providers.mongo.hooks.mongo import MongoHook

from datetime import datetime, timedelta
import os
import json

tmp = os.path.basename(__file__)
tmp1 = os.path.splitext(tmp)[0]

filename = os.path.basename(__file__)
dag_name = os.path.splitext(filename)[0]

c = "_"
person_name = dag_name[dag_name.find(c)+1:]


default_args = {
    "owner": "airflow",
    "depends_on_past": False,
    "start_date": datetime(2023, 3, 27),
    "email": ["airflow@airflow.com"],
    "email_on_failure": False,
    "email_on_retry": False,
    "retries": 1,
    "retry_delay": timedelta(minutes=3),
    # 'queue': 'bash_queue',
    # 'pool': 'backfill',
    # 'priority_weight': 10,
    # 'end_date': datetime(2021, 8, 23),
}

dag = DAG(dag_name, 
    default_args=default_args, 
    schedule_interval=timedelta(minutes=60),
    tags=[dag_name],
    )


def addData():
    hook = MongoHook(mongo_conn_id='mongoid')
    client = hook.get_conn()
    client.admin.authenticate('root','example') # switch to admin to auth
    db = client["test"]
    col = db["stationery"] # Collection Name
    add_rec1 = {
            "person":person_name,
            "name":"pencil case",
            "tags":["school","general"],
            "price":100,
            "quantity":2
            }
    rec_id1 = col.insert_one(add_rec1)
    print("Data inserted with record ids",rec_id1)
    # Printing the data inserted
    # cursor = col.find()
    # for record in cursor:
    #     print(record)
    # print(data.list_collection_names())

def retrieveData():
    hook = MongoHook(mongo_conn_id='mongoid')
    client = hook.get_conn()
    client.admin.authenticate('root','example') # switch to admin to auth
    db = client["test"]
    col = db["stationery"] # Collection Name
    x = col.find_one({"person": person_name})
    print("The data we get is :",x)

t1 = PythonOperator(
        task_id="Add-Data", 
        python_callable=addData, 
        dag=dag
        )

t2 = PythonOperator(
        task_id="Retrieve-Data", 
        python_callable=retrieveData, 
        dag=dag
        )


t1 >> t2 

