
rem docker build --rm  -t jessewei/sqlg-airflow:latest . > build.log
rem docker build -f Dockerfile.docker-airflow --rm  -t saastoolset/sqlg-airflow:latest .
rem docker build -f Dockerfile.2.3 --rm  -t saastoolset/sqlg-airflow:2.3 .

docker build --rm  -t saastoolset/sqlg-airflow-test:pilot .



 

