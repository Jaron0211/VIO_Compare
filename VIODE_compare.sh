#! /bin/sh

algorithm=$1

launch_command=""
if [ ${algorithm} == 'VINS-Fusion' ]
then
	echo "VINS-Fusion"
	launch_command="rosrun vins vins_node /home/jaron/catkin_ws/src/VINS-Fusion-gpu/config/viode/calibration_stereo.yaml"
elif [ ${algorithm} == "DGVINS" ]
then
	echo "DGVINS"
	launch_command="roslaunch dgvins viode_stereo.launch"
elif [ ${algorithm} == "dynaVINS" ]
then
	echo "dynaVINS"
	launch_command="roslaunch dynaVINS viode_stereo.launch"
else
	echo "Not test item!
Available algorithm: VINS-Fusion, DGVINS, dynaVINS"
	return
fi
	
#start roscore
gnome-terminal --tab --title="roscore" -- bash -c "roscore; exec bash" &
sleep 3 

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
		mv ~/vins_output/dgvins_vio.csv ~/vins_output/${algorithm}_${folder/"./"/}_${filename////}_vio.csv 
		#mv ~/vins_output/dgvins_vio.csvVisual_residual.txt ~/vins_output/${algorithm}_${filename////}_Visual_residual.txt 

	done
done
