GLOG_log_dir=./log ../../../exp/SaCNN/SaCNN1.0/caffe/build/tools/caffe train --solver=./solver.prototxt --gpu=5
#nohup ../../../exp/SaCNN/SaCNN1.0/caffe/tools/caffe train --solver=./solver.prototxt --gpu=1 > ./log/log 2>&1 &
#--snapshot=./models/mydata_iter_1395000.solverstate
