@echo off

echo Batch start: %DATE%-%TIME%


if "%1" == "1" (
	echo "1, Start MultiNode"
	rem WIP: docker-compose -f docker-compose-Celery.yml up -d  scale worker=5
	docker-compose -f docker-compose-Celery.yml up -d
	ping 127.0.0.1 -n 40 > nul	
	docker exec -it air_webserver_1 airflow users  create --role Admin --username airflow --email admin --firstname admin --lastname airflow --password airflow
	docker exec -it air_webserver_1  airflow pool -s file_pool 32 file
	docker exec -it air_webserver_1  airflow pool -s sensor_pool 32 external_sensor	
	goto END
)   

if "%1" == "2" (
	echo "2, Start Tutorial"
	docker run -d -p 8082:8080 --name=air_webserver_2 -e AIRFLOW__WEBSERVER__RBAC=False -v %cd%/dags:/usr/local/airflow/dags -v %cd%/config/airflow.cfg:/usr/local/airflow/airflow.cfg saastoolset/sqlg-airflow:latest webserver
	
	rem ping 127.0.0.1 -n 40 > nul	
	rem docker exec -it air_webserver_2 airflow users  create --role Admin --username airflow --email admin --firstname admin --lastname airflow --password airflow
	goto END
)   

if "%1" == "3" (
	echo "3, Start Example"
	docker run -d -p 8083:8080 --name=air_webserver_3 -e AIRFLOW__CORE__LOAD_EXAMPLES=True -e AIRFLOW__WEBSERVER__RBAC=False -v %cd%/dags:/usr/local/airflow/dags -v %cd%/config/airflow.cfg:/usr/local/airflow/airflow.cfg saastoolset/sqlg-airflow:latest webserver
	rem ping 127.0.0.1 -n 40 > nul	
	rem docker exec -it air_webserver_3 airflow users  create --role Admin --username airflow --email admin --firstname admin --lastname airflow --password airflow
	goto END
)   


if "%1" == "4" (
	echo "4, Start 2.3.1 DEMO"
	docker-compose -f docker-compose-2.3.yml up -d  
	REM sleep 20, wait db init then set variable 
	ping 127.0.0.1 -n 40 > nul
	docker exec -it air_webserver_0 airflow users  create --role Admin --username airflow --email admin --firstname admin --lastname airflow --password airflow
	docker exec -it air_webserver_0  airflow pools set file_pool 32 file
	docker exec -it air_webserver_0  airflow pools set sensor_pool 32 external_sensor	
	docker exec -it air_webserver_0  airflow pools set sql_pool 32 sql
)   

if "%1" == "5" (
	echo "5, Start Pilot demo"
	docker-compose -f docker-compose-pilot.yml up -d  
	REM sleep 20, wait db init then set variable 
	ping 127.0.0.1 -n 40 > nul
	docker exec -it air_webserver_0 airflow users  create --role Admin --username airflow --email admin --firstname admin --lastname airflow --password airflow
	docker exec -it air_webserver_0  airflow pools set file_pool 32 file
	docker exec -it air_webserver_0  airflow pools set sensor_pool 32 external_sensor	
	docker exec -it air_webserver_0  airflow pools set sql_pool 32 sql
)


if "%1" == "-h" (
	goto HELP
)   

if "%1" == "0" (
	goto DEFAULT
) else (
	if "%1" == "" (
	goto DEFAULT
	)
)
echo .
echo Invalidate parameter:  %1
goto HELP

goto END
pools set 

:DEFAULT
	echo "0, Start SingleNode"
	docker-compose -f docker-compose.yml up -d  
	REM sleep 20, wait db init then set variable 
	ping 127.0.0.1 -n 40 > nul
	docker exec -it air_webserver_0 airflow users  create --role Admin --username airflow --email admin --firstname admin --lastname airflow --password airflow
	docker exec -it air_webserver_0  airflow pools set file_pool 32 file
	docker exec -it air_webserver_0  airflow pools set sensor_pool 32 external_sensor	
	docker exec -it air_webserver_0  airflow pools set sql_pool 32 sql	
goto END


:HELP
	echo .
	echo "up.bat: The Airflow startup script, usage:"
	echo "up.bat [0|1|2|3|-h]"
	echo "0, Start SingleNode, port=8080"
	echo "1, Start MultiNode, port=8081"  
	echo "2, Start Tutorial, port=8082"
	echo "3, Start Example, port=8083"
	echo "-h, help message"
	echo .

:END	
echo .
echo Batch END: %DATE%-%TIME%
echo .
echo on 