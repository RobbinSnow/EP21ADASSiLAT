%% ExperimentRamp_Runscript
% step 1: set the PreScan Scene Struct: Run.Settings ={'SlopeAngle', [0,5,10,15,20,25,30]}
% step 2: start CarSim and check dataset valid
% step 3: read the experiment description, get the string and change to array: testcase='CCC={30-30,60-60,90-90,120-120};ACC={60-60,30-120,120-30};
% step 4: use for loop to set the dos command string
% step 5: run the dos command
% step 6; save data to Excel
% step 7: close experiment and prepare for python call another script

%% presetup
% ScenarioName = 'Straight';

%% init
% PreScan project name
disp('MATLAB script running...')
CurrentFolder = pwd;% get current working folder
SlashIndex = regexp(CurrentFolder,'\');% split folder location by slash
ExpName = CurrentFolder(SlashIndex(end)+1:end);%StraightSlope
mdlName = strcat(ExpName,'_cs');
ResultFolder = CurrentFolder(1:SlashIndex(end-1));% E:\EP21ADASSiLAT\
% mdlName = 'StraightCC_cs';
% make sure previous settings are ignored.
clear Results Run;
myDictionaryDesignData;% load SFunction datadictionary
MotorPara;% Load EP21 motor data

%% step 1: set the PreScan Scene Struct
% parameters needed to be changed in PreScan
Run.Settings = {'SlopeAngle', [0 2 5]};

%% step 2: start CarSim and check dataset valid
disp('starting CarSim...')
h = actxserver('CarSim.Application');% get the  handle of CarSim Application
if h.DataSetExists('CarSim Run Control','EP21_ADAS_SIL','EP21_ADAS')&&h.DataSetExists('Procedures','FlatGround','EP21_ADAS_SIL')% if dataset exit? 
    CarSimFlag = 1;
    h.Gotolibrary('CarSim Run Control','EP21_ADAS_SIL','EP21_ADAS');% exit,then go to the CarSim SIL Dataset
    h.Gotolibrary('Procedures','FlatGround','EP21_ADAS_SIL');
    h.GoHome();
    disp('success loading CarSim Application Data');
    disp('PreScan initializing...');
else
    CarSimFlag = 0;
    disp('No Refrence Dataset in  CarSim, please check CarSim dataset and library');
end

%% step 3: read the testcase description txt, get the string and change to array
% model=prescan.experiment.readDataModels();% get PreScan data model API
f = fopen('Testcases.txt');
testcase = textscan(f,'%s');
fclose(f);
testcaseCell = testcase{1};
ACCFlag = 0;ACCArray = [];% CCC tested?
AEBFlag = 0;AEBArray = [];% ACC tested?
LKAFlag = 0;LKAArray = [];% LKA tested?
% testcase='CCC={30-30,60-60,90-90,120-120};ACC={60-60,30-120,120-30};';
for i = 1:length(testcaseCell)
    testcaseString = testcaseCell{i};
    if ~isempty(regexp(testcaseString,'ACC', 'once'))
        ACCFlag = 1;
        ACCArray = String2Number(testcaseString);
    end
    if ~isempty(regexp(testcaseString,'AEB', 'once'))
        AEBFlag = 1;
        AEBArray = String2Number(testcaseString);
    end
    if ~isempty(regexp(testcaseString,'LKA', 'once'))
        LKAFlag = 1;
        LKAArray = String2Number(testcaseString);
    end
end
ACCCaseNo = length(ACCArray)/2;
ACCCasei = 1;
AEBCaseNo = length(AEBArray)/2;
AEBCasei = 1;
LKACaseNo = length(LKAArray)/2;
LKACasei = 1;
TestcaseNo = ACCCaseNo + AEBCaseNo + LKACaseNo;

%% step 4: use for-loop to set the dos command string

ExeName = 'PreScan.CLI.exe';
% ExperimentName = 'StraightACC';
MainExperiment = CurrentFolder;% pwd
ExperimentDir = [CurrentFolder '\..'];

% Number of simulations for each scenario
SceneNo = length(Run.Settings{2});

if CarSimFlag&&(ACCFlag||AEBFlag||LKAFlag)% if CarSim OK and Testcases OK  
    for i = 1:SceneNo
        disp(['Scene: ' num2str(i) '/' num2str(SceneNo)]);
        Command = ExeName;
        Command = [Command ' -load ' '"' MainExperiment '"'];
        tag = Run.Settings{1};
        val = num2str(Run.Settings{2}(i), '%50.50g');
        Command = [Command ' -set ' tag '=' val];
        Settings(end+1) = cellstr([tag ' = ' val]);
        Command = [Command ' -realignPaths'];
        Command = [Command ' -build'];    
        Command = [Command ' -close'];
        %%
        % Execute the command (creates altered PreScan experiment).
%------------------------------------------------------------------------        
        ACCCasei = 1;
        while ACCCasei<= ACCCaseNo
            disp('Now ACC is under test...');
            ADASID=1;%ADAS test ID,1 for ACC
            V0=ACCArray(2*ACCCasei-1);%init Spd for CCC
            disp(strcat('ACC init Spd is:',num2str(V0)));
            V1=ACCArray(2*ACCCasei);%final Spd for CCC
            disp(strcat('ACC final Spd is:',num2str(V1)));
            ACCDuration=5;%time interval between Spd change demands
            
            VPIDIn=ACCArray(2*ACCCasei-1);% init Vx of testcase, for PID controller before DCU come into force
            VToleranceIn = 1;% Vx Error Tolerance in kph
            VDurationIn = 2;% Vx steady time in PID controller in sec
            VAccuracyIn = 0.8;% Vx Accuracy in VDuration time in percent         
            
            disp('CarSim sending to MATLAB');
            h.Gotolibrary('Procedures','FlatGround','EP21_ADAS_SIL');% CarSim goto the specified library
            h.Unlock();% CarSim unlock dataset           
            h.Yellow('*SPEED',num2str(VPIDIn));% set init Vx in CarSim
            h.GoHome();% CarSim goto homepage
            h.RunButtonClick(2);% click CarSim send to Simulink button, to generate the refreshed simfile
%             configureMatlabForPrescan;
            dos(Command);% use dos command to control PreScan: load parse build close......
            % for more dos commands, using dos to open PreScan to see the
            % function reference help
%             SimPreScan(RunModel);
            disp('PreScan Simulink model regenerating...')
            open_system(mdlName);
            % Regenerate compilation sheet.
            regenButtonHandle = find_system(mdlName, 'FindAll', 'on', 'type', 'annotation','text','Regenerate');
            regenButtonCallbackText = get_param(regenButtonHandle,'ClickFcn');
            eval(regenButtonCallbackText);
            % Determine simulation start and end times (avoid infinite durations).
            activeConfig = getActiveConfigSet(mdlName);
            startTime = str2double(get_param(activeConfig, 'StartTime'));
            endTime = str2double(get_param(activeConfig, 'StopTime'));
            duration = endTime - startTime;
            if (duration == Inf)
                endTime = startTime + 10;
            end
            % Simulate the new model.
            disp('PreScan Simulink model running...')
            sim(mdlName, [startTime endTime]);
            save_system(mdlName);
            close_system(mdlName);
            
%             filename = strcat(ResultFolder,'Report\Data\01CCC\CCC',num2str(i*CCCCaseNo-CCCCaseNo+CCCCasei,'%03i'),ExpName,num2str(val),'%Spd',num2str(CCCArray(2*CCCCasei-1)),'.xlsx');
%             colname = {'Time','ACCReqSt','ACCReqVa','ACCSysSt','AEBReqSt','AEBReqVa','AEBSysSt','AVz','Ax','Ay','CanclSw','DisDecSw','DisIncSw','LockedID','LockedVx','LockedX','LockedY','MemSpd','OnSw','RsmSw','SetSpd','SetSw','SpdDecSw','SpdIncSw','Steer_SW','StrAV_SW','ToqReqSt','ToqReqVa','T_Stamp','Vx'};
%             M = [Time,ACCReqSt,ACCReqVa,ACCSysSt,AEBReqSt,AEBReqVa,AEBSysSt,AVz,Ax,Ay,CanclSw,DisDecSw,DisIncSw,LockedID,LockedVx,LockedX,LockedY,MemSpd,OnSw,RsmSw,SetSpd,SetSw,SpdDecSw,SpdIncSw,Steer_SW,StrAV_SW,ToqReqSt,ToqReqVa,T_Stamp,Vx];
            filename = strcat(ResultFolder,'Report\Data\ACC\','ACC',ExpName,num2str(i*ACCCaseNo-ACCCaseNo+ACCCasei,'%03i'),Run.Settings{1},num2str(val),'pctSpd',num2str(ACCArray(2*ACCCasei-1)),'.mat');
            TestResult.Time=Time;TestResult.ACCReqSt=ACCReqSt;TestResult.ACCReqVa=ACCReqVa;
            TestResult.ACCSysSt=ACCSysSt;TestResult.AEBReqSt=AEBReqSt;TestResult.AEBReqVa=AEBReqVa;
            TestResult.AEBSysSt=AEBSysSt;TestResult.AVz=AVz;TestResult.Ax=Ax;
            TestResult.Ay=Ay;TestResult.CanclSw=CanclSw;TestResult.DisDecSw=DisDecSw;
            TestResult.DisIncSw=DisIncSw;TestResult.LockedID=LockedID;TestResult.LockedVx=LockedVx;
            TestResult.LockedX=LockedX;TestResult.LockedY=LockedY;TestResult.MemSpd=MemSpd;
            TestResult.OnSw=OnSw;TestResult.RsmSw=RsmSw;TestResult.SetSpd=SetSpd;
            TestResult.SetSw=SetSw;TestResult.SpdDecSw=SpdDecSw;TestResult.SpdIncSw=SpdIncSw;
            TestResult.Steer_SW=Steer_SW;TestResult.StrAV_SW=StrAV_SW;TestResult.ToqReqSt=ToqReqSt;
            TestResult.ToqReqVa=ToqReqVa;TestResult.T_Stamp=T_Stamp;TestResult.Vx=Vx;
			save(filename,'-struct','TestResult')
%             save('Testresults.mat','Time','ACCReqSt','ACCReqVa','ACCSysSt','AEBReqSt','AEBReqVa','AEBSysSt','AVz','Ax','Ay','CanclSw','DisDecSw','DisIncSw','LockedID','LockedVx','LockedX','LockedY','MemSpd','OnSw','RsmSw','SetSpd','SetSw','SpdDecSw','SpdIncSw','Steer_SW','StrAV_SW','ToqReqSt','ToqReqVa','T_Stamp','Vx')
%             xlswrite(filename,colname,1);
%             xlswrite(filename,M,1,'A2');
            ACCCasei = ACCCasei + 1;
        end
%------------------------------------------------------------------------        
       
    end
else
    disp('No Testcases Listed!')
end

%% Clear CarSim handle
clear h
