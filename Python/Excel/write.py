# -*- coding: utf-8 -*- 
import xlwt

def testXlwt(file = 'new.xls'):
    book = xlwt.Workbook() #����һ��Excel
    sheet1 = book.add_sheet('hello') #�����д���һ����Ϊhello��sheet
    sheet1.write(0,0,'cloudox') #��sheet���һ�е�һ��дһ������
    sheet1.write(1,0,'ox') #��sheet��ڶ��е�һ��дһ������
    book.save(file) #���������ļ�

#������
def main():
   testXlwt()

if __name__=="__main__":
    main()
    input()