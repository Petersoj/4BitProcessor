#!/bin/bash -f
xv_path="/home/jacob/.Xilinx/Vivado/2015.4"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xelab -wto 9224f3cb2f02473badee9e37fa626f4e -m64 --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot ProcessorTest_behav xil_defaultlib.ProcessorTest xil_defaultlib.glbl -log elaborate.log
