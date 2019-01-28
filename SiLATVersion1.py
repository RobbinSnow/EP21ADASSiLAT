#!/usr/bin/env python
# -*- coding:utf8 -*- 

# step1: use PreScan Processor Manager to open PreScan and MATLAB
# step2: Python link to the share session of MATLAB engine
# step3: Python change MATLAB working directory and run the coordinate m file
# step4: cycle step3
# step5: All Program clean up

import matlab.engine
import os
import time
import subprocess
import re
import tkinter
from tkinter import messagebox

# hide main window
# use python window to avoid certain error
root = tkinter.Tk()
root.withdraw()

# connent to Matlab
eng = matlab.engine.connect_matlab()

# get all the filefolder
cwd = os.getcwd()#get current working directory
dirs = os.listdir(cwd)#get the filelist in cwd
if 'PreScanExperiments' not in dirs:
	messagebox.showerror("Error", "No experiments folder")
else:
	expPath = cwd + r'\PreScanExperiments'
	#expPath='E:\EP21ADASSiLAT\PreScanExperiments'# folder storing all the PreScan experiments
	fileList=os.listdir(expPath)# get all the experiments' name
	for f in fileList:
		path=''.join([expPath,'/',f])
		eng.cd(path)# change MATLAB working directory
		time.sleep(5)# seconds you want to wait
		eng.PreScan_Runscript(nargout=0)# Run MATLAB script to control PreScan
# change to report path and generate report
reportPath = cwd + r'\Report'
eng.cd(reportPath)
eng.TestAnalysis(nargout = 0)
eng.ReportLatex(nargout = 0)

#reportPath='E:\EP21ADASSIL\Report'
#eng.cd(reportPath)
#eng.ReportLatex(nargout=0)
#eng.quit()# quit the connection with MATLAB 

# how to get matlab.m run state
	

# Result xls 

# Report generation
	
# cd the matlab workspace folder