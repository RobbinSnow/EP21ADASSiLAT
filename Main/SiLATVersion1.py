#!/usr/bin/env python
# -*- coding:utf8 -*- 

# step1: use PreScan Processor Manager to open PreScan and MATLAB and CarSim
# step2: Python link to the share session of MATLAB engine
# step3: Python change MATLAB working directory and run the coordinate m file
# step4: cycle step3
# step5: All Program clean up

import matlab.engine
import os
import time
import subprocess
# import win32com.client
# open PreScan
# subprocess.Popen([r"E:\Program Files\PreScan\PreScan_8.4.0\bin\PreScanStart.exe"])
# subprocess.Popen([r"E:\Program Files\PreScan\PreScan_8.4.0\bin\PreScan.CLI.exe"])
# open MATLAB using PreScan


# CarSim control Can also be done manually
# open CarSim with Python and change to the destination dataset
# h=win32com.client.Dispatch('CarSim.Application')
# h.gotodataset()
# first run matlab.engine.shareEngine in MATLAB command window to share the matlab session

# eng=matlab.engine.start_matlab('-desktop')
# connent to Matlab
eng=matlab.engine.connect_matlab()

# get all the filefolder
expPath='E:\EP21ADASSiLAT\PreScanExperiments'# folder storing all the PreScan experiments
fileList=os.listdir(expPath)# get all the experiments' name
for f in fileList:
	path=''.join([expPath,'/',f])
	eng.cd(path)# change MATLAB working directory
	time.sleep(5)# seconds you want to wait
	eng.PreScan_Runscript(nargout=0)# Run MATLAB script to control PreScan
# change to report path and generate report
#reportPath='E:\EP21ADASSIL\Report'
#eng.cd(reportPath)
#eng.ReportLatex(nargout=0)
#eng.quit()# quit the connection with MATLAB 

# how to get matlab.m run state
	

# Result xls 

# Report generation
	
# cd the matlab workspace folder