'''
Date: 20230830
Author: Jaron Lee
Discribe:

This is the script that classific the raw vio_path.csv file into every senario.
The workspace struction:

.
├── classificatnion.py
├── origin_csv
│   ├── A-algorithm
│   │   ├── A-algorithm_1-senario_vio.csv
│   │   ├── A-algorithm_2-senario_vio.csv
│   │   └── A-algorithm_3-senario_vio.csv
│   ├── B-algorithm
│   │   ├── B-algorithm_1-senario_vio.csv
│   │   ├── B-algorithm_2-senario_vio.csv
│   │   └── B-algorithm_3-senario_vio.csv
│   └── ...
└── senario
    ├── 1-senario
    │   ├── csv
    │   ├── tum
    │   └── results
    ├── 2-senario
    │   ├── csv
    │   ├── tum
    │   └── results
    └── ...

Within this structure, it will automatic copy the vio.csv file into relatived comparsion folder( with evo tools).

The filename follow the rule:

ALGORITHM_SENARIO_vio.csv

and also, the vio.csv should be in the EuRoC format.

'''

import os
import shutil

senario_path = './senario/'
senarios =  os.listdir(senario_path)

algorithm_path = './origin_csv/'
algorithms = os.listdir(algorithm_path)

print(algorithms)

for algorithm in algorithms:
    for senario in senarios:

        vio_traj_path = algorithm_path + algorithm + '/' + algorithm + '_' + senario + '_' + 'vio.csv'
        target_path = senario_path + senario + '/' + 'csv/' + algorithm + '_' + senario + '_' + 'vio.csv'

        print(vio_traj_path, target_path)
        
        shutil.copyfile(vio_traj_path, target_path)

