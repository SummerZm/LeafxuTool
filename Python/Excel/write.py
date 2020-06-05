# -*- coding: utf-8 -*- 
import xlwt

def testXlwt(file = 'new.xls'):
    book = xlwt.Workbook() #创建一个Excel
    sheet1 = book.add_sheet('hello') #在其中创建一个名为hello的sheet
    sheet1.write(0,0,'cloudox') #往sheet里第一行第一列写一个数据
    sheet1.write(1,0,'ox') #往sheet里第二行第一列写一个数据
    book.save(file) #创建保存文件

#主函数
def main():
   testXlwt()

if __name__=="__main__":
    main()
    input()