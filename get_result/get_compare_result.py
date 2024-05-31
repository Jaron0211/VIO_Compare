'''
Author: Jian Lun, Li

Put this file under senario folder, and run this python script, 
will get total_APE_result.csv and total_RPE_result.csv 

'''

import os
from glob import glob
import csv

folders = glob(os.curdir+"/*/", recursive=True)

#get APE
total_APE_result_csv = open('total_APE_result.csv','w+')
total_result = csv.writer(total_APE_result_csv, delimiter=' ',quotechar=',', quoting=csv.QUOTE_MINIMAL)
for folder in folders:
    ape_result = folder + 'ape_results/table.csv'
    with open(ape_result, newline='') as result_file:
        spamreader = csv.reader(result_file, delimiter=' ', quotechar=',')
        first_row = True
        for row in spamreader:
            if first_row:
                first_row = False
                total_result.writerow([folder] + [] + row)
                continue
            total_result.writerow(row)

#get RPE
total_RPE_result_csv = open('total_RPE_result.csv','w+')
total_result = csv.writer(total_RPE_result_csv, delimiter=' ',quotechar=',', quoting=csv.QUOTE_MINIMAL)
for folder in folders:
    ape_result = folder + 'rpe_results/table.csv'
    with open(ape_result, newline='') as result_file:
        spamreader = csv.reader(result_file, delimiter=' ', quotechar=',')
        first_row = True
        for row in spamreader:
            if first_row:
                first_row = False
                total_result.writerow(folder)
                continue
            total_result.writerow(row)
