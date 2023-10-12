#! /bin/sh

algorithm=$1

launch_command=""


if [ $algorithm=="vins" ]
then
	launch_command="rosrun vins vins_node /home/jaron/catkin_ws/src/VINS-Fusion-gpu/config/euroc/euroc_stereo_imu_config.yaml"
elif [ $algorithm=="dgvins" ]
then
	launch_command="roslaunch dgvins euroc.launch"
elif [ $algorithm=="dynaVINS" ]
then
	launch_command="roslaunch dynaVINS euroc.launch"
fi
	
#start roscore
gnome-terminal --tab --title="roscore" -- bash -c "roscore; exec bash" &
sleep 3 

#prepare euroc dataset
cd /media/jaron/DATA/experiment_data/VIO_Dataset/EuRoC/bag/

files="./*"
echo ${files}

for bag in ${files}
do

	gnome-terminal --tab --title="$algorithm" -- bash -c "${launch_command}" &
	sleep 5
	vio_pid=$(pgrep ${algorithm})
	command="rosbag play /media/jaron/DATA/experiment_data/VIO_Dataset/EuRoC/bag/${bag/.//}"
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
	mv ~/vins_output/dgvins_vio.csv ~/vins_output/${algorithm}_${filename////}_vio.csv 
	#mv ~/vins_output/dgvins_vio.csvVisual_residual.txt ~/vins_output/${algorithm}_${filename////}_Visual_residual.txt 

done
