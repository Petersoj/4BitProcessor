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
ExecStep $xv_path/bin/xsim ProcessorTest_behav -key {Behavioral:sim_1:Functional:ProcessorTest} -tclbatch ProcessorTest.tcl -log simulate.log
