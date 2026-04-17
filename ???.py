thang-=[31,28,31,30,31,30,31,31,30,31,30,31] 
defnhuan (year): 
return year%400--0 or (year%4--o and year%100!-0) 
date -=input ("Nhập thời gian theo dạng ngày-tháng-năm:") 
tg= date.split("-") 
day, month, year- int (tg[0]),int (tg[11),int(tg[21) 
if nhuan (year): 
thang [1]-29 
else: 
thang [1]=28 
if year >o and 1 <= month <=12 and 1<= day <= thang [month-11: 
print (day,"-", month,"-", year,"là hợp lệ") 
else: 
print ("Bộ da lieu dä nhập không họp 1e")
