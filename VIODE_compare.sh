#! /bin/sh
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
algorithm=$1

launch_command=""
vio_file_name=""
if [ ${algorithm} == 'VINS-Fusion' ]
then
	echo "VINS-Fusion"
	launch_command="rosrun vins vins_node /home/jaron/catkin_ws/src/VINS-Fusion-gpu/config/viode/calibration_stereo.yaml"
	vio_file_name="vio.csv"
elif [ ${algorithm} == "DGVINS" ]
then
	echo "DGVINS"
	launch_command="roslaunch dgvins viode_stereo.launch"
	vio_file_name="dgvins_vio.csv"
elif [ ${algorithm} == "dynaVINS" ]
then
	echo "dynaVINS"
	launch_command="roslaunch dynaVINS viode_stereo.launch"
	vio_file_name="vio.csv"
else
	echo "Not test item!
Available algorithm: VINS-Fusion, DGVINS, dynaVINS"
	return
fi

	
#start roscore
gnome-terminal --tab --title="roscore" -- bash -c "roscore; exec bash" &
sleep 3 
roscore_pid=$(pgrep "roscore http://${hostname}:11311/")

#prepare VIODE dataset
cd /media/jaron/DATA/experiment_data/VIO_Dataset/VIODE/bag
folder_list="./*"
echo ${folder_list}

for folder in ${folder_list}
do
	cd /media/jaron/DATA/experiment_data/VIO_Dataset/VIODE/bag/${folder/"./"/}

	files="./*"
	echo ${files}

	for bag in ${files}
	do

		gnome-terminal --tab --title="$algorithm" -- bash -c "${launch_command}" &
		sleep 5
		vio_pid=$(pgrep ${algorithm})
		command="rosbag play /media/jaron/DATA/experiment_data/VIO_Dataset/VIODE/bag/${folder/"./"/}/${bag/"./"/}"
		gnome-terminal --tab --title="rosbag" -- bash -c "${command}; kill -- -$pid; kill -- -$vio_pid"
		pid=$(pgrep rosbag)
		echo $pid
		
		while ps -p $pid ; do
		    echo "Process is still active..."
		    sleep 3
		    # You can add a timeout here if you want
		done
		
		sleep 5
		filename=${bag/.//}
		echo $filename
		mv ~/vins_output/${vio_file_name} ~/vins_output/${algorithm}_${folder/"./"/}_${filename////}_vio.csv 
		#mv ~/vins_output/dgvins_vio.csvVisual_residual.txt ~/vins_output/${algorithm}_${filename////}_Visual_residual.txt 

	done
done
kill -- -$roscore_pid
cd ${SCRIPT_DIR}
