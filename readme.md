# VIO Trajectory compare setup tool
## Note
This script, which operates in conjunction with Evo, a tool for comparing VIO paths, automates the comparison process, making it more efficient and user-friendly.

## The structure

Follow the folder structure:
~~~
workspace/
├── classfication.py #get csv and put into different senario folder.
├── EuRoC_all.sh     #run with EuRoC bag file and ALL VIO algorithm.
├── VIODE_all.sh     #run with VIODE bag file and ALL VIO algorithm.
├── euroc_compare.sh #run with EuRoC bag file and specific VIO algorithm.
├── VIODE_compare.sh #run with VIODE bag file and specific VIO algorithm.
├── origin_csv/
│   ├── VIO_Algorithm_1/
│   │   ├── [VIO_Algorithm_1]_[senario_1].csv
│   │   ├── [VIO_Algorithm_1]_[senario_2].csv
│   │   ├── [VIO_Algorithm_1]_[senario_3].csv
│   │   └── ...
│   ├── VIO_Algorithm_2/
│   │   ├── [VIO_Algorithm_2]_[senario_1].csv
│   │   ├── [VIO_Algorithm_2]_[senario_2].csv
│   │   ├── [VIO_Algorithm_2]_[senario_3].csv
│   │   └── ...
│   ├── VIO_Algorithm_3
│   └── ...
└── senario/
    ├── get_compare_result.py #get all RPE/APE result into one csv file.
    ├── senario_1/
    │   ├── auto.sh #automatic run evo comparision(APE and RPE).
    │   ├── csv
    │   └── tum/
    │       └── data.tum --> If only have the tum version groundtruth, put it in the /tum and rename it 'data.tum'.
    ├── senario_2/
    │   ├── auto.sh
    │   ├── csv
    │   └── tum/
    │       └── data.tum
    ├── senario_3
    ├── senario_4
    └── ...
~~~
