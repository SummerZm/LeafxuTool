import os
import sys
import  xdrlib ,sys
import xlrd

#打开excel文件
def open_excel(file= 'test.xlsx'):
    data = xlrd.open_workbook(file)
    return data

#根据名称获取Excel表格中的数据   参数:file：Excel文件路径     colnameindex：表头列名所在行的索引  ，by_name：Sheet1名称
def excel_table_byname(file='C:/Users/LB/Desktop/Python/test.xlsx', colnameindex=0, by_name=u'Sheet1'):
    data = open_excel(file) #打开excel文件
    table = data.sheet_by_name(by_name) #根据sheet名字来获取excel中的sheet
    nrows = table.nrows #行数 
    colnames = table.row_values(colnameindex) #某一行数据 
    list =[] #装读取结果的序列
    for rownum in range(0, nrows): #遍历每一行的内容
        row = table.row_values(rownum) #根据行号获取行
        if row: #如果行存在
            app = [] #一行的内容
            for i in range(len(colnames)): #一列列地读取行的内容
                app.append(row[i])
            list.append(app) #装载数据
    return list

#主函数
def main():
    tables = excel_table_byname()
    for row in tables:
        print(row)

if __name__=="__main__":
    main()

input()