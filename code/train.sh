GLOG_log_dir=./log ../caffe/build/tools/caffe train --solver=./solver.prototxt --gpu=6
#nohup ../../../exp/SaCNN/SaCNN1.0/caffe/tools/caffe train --solver=./solver.prototxt --gpu=1 > ./log/log 2>&1 &
#--snapshot=./models/pretrain_iter_1300000.solverstate
