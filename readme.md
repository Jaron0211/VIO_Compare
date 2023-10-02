* VIO Trajectory compare setup tool
** Note
This script is working with evo comparision tool

** The structure

Follow the folder structure:

workspace/
├── auto.sh
├── classfication.py
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
    ├── senario_1/
    │   ├── csv
    │   └── tum/
    │       └── data.tum --> If only have the tum version groundtruth, put it in the /tum.
    ├── senario_2/
    │   ├── csv
    │   └── tum/
    │       └── data.tum
    ├── senario_3
    ├── senario_4
    └── ...
