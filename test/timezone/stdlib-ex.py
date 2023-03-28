import datetime #ctrl+f5 implement

ex_count = 0

ex_count += 1
print(f'\nex-{ex_count}=>')
x = datetime.datetime.now()
print(x)

ex_count += 1
print(f'\nex-{ex_count}=> Return the year and name of weekday:')
x = datetime.datetime.now()
print(x.year)
print(x.strftime("%A"))



# ex_count += 1
# print(f'\nex-{ex_count}=> ')
# print(datetime.datetime.utcnow().strftime('%z'))
# print(datetime.datetime.now().strftime('%z'))


ex_count += 1
print(f'\nex-{ex_count}=> Creating Date Objects:')
x = datetime.datetime(2020, 5, 17)
print(x)



ex_count += 1
print(f'\nex-{ex_count}=> The strftime() Method:')
x = datetime.datetime(2018, 6, 1)
print(x.strftime("%B"))