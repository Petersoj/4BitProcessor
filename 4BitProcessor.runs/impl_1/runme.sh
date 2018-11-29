#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
# 

if [ -z "$PATH" ]; then
  PATH=/home/jacob/.Xilinx/SDK/2015.4/bin:/home/jacob/.Xilinx/Vivado/2015.4/ids_lite/ISE/bin/lin64:/home/jacob/.Xilinx/Vivado/2015.4/bin
else
  PATH=/home/jacob/.Xilinx/SDK/2015.4/bin:/home/jacob/.Xilinx/Vivado/2015.4/ids_lite/ISE/bin/lin64:/home/jacob/.Xilinx/Vivado/2015.4/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=/home/jacob/.Xilinx/Vivado/2015.4/ids_lite/ISE/lib/lin64
else
  LD_LIBRARY_PATH=/home/jacob/.Xilinx/Vivado/2015.4/ids_lite/ISE/lib/lin64:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='/home/jacob/Documents/ECE2700/4BitProcessor/4BitProcessor.runs/impl_1'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

# pre-commands:
/bin/touch .init_design.begin.rst
EAStep vivado -log ProcessorTop.vdi -applog -m64 -messageDb vivado.pb -mode batch -source ProcessorTop.tcl -notrace


