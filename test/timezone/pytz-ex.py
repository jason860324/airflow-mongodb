# Source:
# https://techmonger.github.io/32/pytz-example-conversion/
# https://linuxhint.com/use-pytz-module-python/
#

import datetime
import pytz

ex_count = 1 #1
print(f'\nex-{ex_count}=> Get current Date Time Object')
source_date = datetime.datetime.now()
print(source_date)

ex_count += 1 #2
print(f'\nex-{ex_count}=> Create Source Time Zone Object')
source_time_zone = pytz.timezone('US/Eastern')
print(source_time_zone)

ex_count += 1 #3
print(f'\nex-{ex_count}=> Assign Source Time Zone to Created Date Time Object')
source_date_with_timezone = source_time_zone.localize(source_date)
print(source_date_with_timezone)

ex_count += 1 #4
print(f'\nex-{ex_count}=> Create Target Time Zone Object')
target_time_zone = pytz.timezone('Europe/Moscow')
print(target_time_zone)

ex_count += 1 #5
print(f'\nex-{ex_count}=> Convert Source Time Zone to Target Time Zone')
target_date_with_timezone = source_date_with_timezone.astimezone(target_time_zone)
print(target_date_with_timezone)


