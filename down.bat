echo off

if "%1" == "" (
	echo "0, Stop SingleNode"
	docker-compose -f docker-compose.yml down
	goto END
)

if "%1" == "1" (
	echo "1, Stop MultiNode"
	docker-compose -f docker-compose-Celery.yml down

	goto END
)   

if "%1" == "2" (
	echo "2, Stop Tutorial"
	docker rm -f air_webserver_2

	goto END
)   

if "%1" == "3" (
	echo "3, Stop Example"
	docker rm  -f air_webserver_3

	goto END
)   

if "%1" == "4" (
	echo "4, Stop 2.3.1"
	docker-compose -f docker-compose-2.3.yml down

	goto END
)   

if "%1" == "5" (
	echo "5, Stop pilot"
	docker-compose -f docker-compose-pilot.yml down

	goto END
) 

if "%1" == "-h" (
	goto HELP
)   

if "%1" == "0" (
	docker-compose -f docker-compose.yml down
) else (
	if "%1" == "" (
	docker-compose -f docker-compose.yml down
	)
)

:HELP
	echo .
	echo "down.bat: The Airflow shutdown script, usage:"
	echo "down.bat [0|1|2|3|-h]"



:END
echo  END of stop script

echo  on
