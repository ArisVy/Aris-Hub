thang=[31,28,31,30,31,30,31,31,30,31,30,31]
def nhuan(year): 
return year%400==0 or (year%4 ==0 and year%100 !=0)
date =input("Nhập thời gian theo dạng ngày-tháng-năm:") 
tg = date.split("-") 
day, month,year= int(tg[0]),int(tg[1]),int(tg[2]) 
if nhuan(year): 
thang[1]=29 
else: 
thang[1]=28 
if year >0 and 1 <= month <= 12 and 1<= day <= thang[month-1]: 
print(day,"-", month,"-",year,"là hợp lệ") 
else: 
print("Bộ dữ liệu đã nhập không hợp lệ")
