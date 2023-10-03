#! /bin/sh

#start roscore
gnome-terminal --tab --title="roscore" -- bash -c "roscore; exec bash" &
sleep 3 

#prepare euroc dataset

cd /media/jaron/DATA/experiment_data/VIO_Dataset/EuRoC/bag/

files="./*"
echo ${files}

for bag in ${files}
do
	gnome-terminal --tab --title="dgvins" -- bash -c "roslaunch dgvins euroc.launch" &
	sleep 5
	vins_pid=$(pgrep dgvins)
	command="rosbag play /media/jaron/DATA/experiment_data/VIO_Dataset/EuRoC/bag/"${bag/.//}
	gnome-terminal --tab --title="rosbag" -- bash -c "${command}; kill -- -$pid; kill -- -$vins_pid"
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
	mv ~/vins_output/dgvins_vio.csv ~/vins_output/DGVINS_${filename////}_vio.csv 
	mv ~/vins_output/dgvins_vio.csvVisual_residual.txt ~/vins_output/DGVINS_${filename////}_Visual_residual.txt 

done
