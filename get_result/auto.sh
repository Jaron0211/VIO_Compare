'''
This file should be place in the senario folder.
The structure is in this form:

.
└── senario
    ├── MH_01
    │   ├── **auto.sh** --> The auto comparision script
    │   ├── csv
    │   │   ├── data.csv   --> This is the groundtruth file in EuRoC form
    │   │   ├── A_vio.csv  --> The VIO trajectory in EuRoC form
    │   │   └── B_vio.csv  --> The VIO trajectory in EuRoC form
    │   ├── tum
    │   │   ├── data.tum   --> This is the groundtruth file in TUM form
    │   │   ├── A_vio.tum  --> The VIO trajectory in TUM form
    │   │   └── B_vio.tum  --> The VIO trajectory in TUM form
    │   ├── ape_results  --> The APE comparison 
    │   └── rpe_results  --> The RPE comparison
    ├── MH_02
    ├── MH_03
    └── ...


'''

rm -rf rpe_results ape_results

mkdir rpe_results 
mkdir ape_results


if test -d ./tum; 
then
	cd tum
	rm -f $(ls -I "data.tum" )
else
	mkdir tum
	cd tum
fi


evo_traj euroc ../csv/*.csv --save_as_tum

files="./*.tum"

for name in $files
do
	if [ "${name}" != "./data.tum" ] 
	then
		vio_name=${name}
		ape_file_name="../ape_results/"${vio_name}".zip"
		rpe_file_name="../rpe_results/"${vio_name}".zip"
		
		evo_ape tum data.tum ${vio_name} --save_results ${ape_file_name} -as
		evo_rpe tum data.tum ${vio_name} --save_results ${rpe_file_name} -as
	fi
done

cd ..
/bin/sh -ec "evo_config set save_traj_in_zip true ; evo_res ape_results/*.zip --save_table ape_results/table.csv --save_plot ape_results/tableplot.pdf"
/bin/sh -ec "evo_config set save_traj_in_zip true ; evo_res rpe_results/*.zip --save_table rpe_results/table.csv --save_plot rpe_results/tableplot.pdf" 
