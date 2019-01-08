filename = 'C:\Users\SAIC\Desktop\Test\SAIC CCC Stright 5PctIncreace 30-901.xlsx';
% sheet = 1;
% range = 'A2';
colname = {'Time','ACCReqSt','ACCReqVa','ACCSysSt','AEBReqSt','AEBReqVa','AEBSysSt','AVz','Ax','Ay','CanclSw','DisDecSw','DisIncSw','LockedID','LockedVx','LockedX','LockedY','MemSpd','OnSw','RsmSw','SetSpd','SetSw','SpdDecSw','SpdIncSw','Steer_SW','StrAV_SW','ToqReqSt','ToqReqVa','T_Stamp','Vx'};
M = [Time,ACCReqSt,ACCReqVa,ACCSysSt,AEBReqSt,AEBReqVa,AEBSysSt,AVz,Ax,Ay,CanclSw,DisDecSw,DisIncSw,LockedID,LockedVx,LockedX,LockedY,MemSpd,OnSw,RsmSw,SetSpd,SetSw,SpdDecSw,SpdIncSw,Steer_SW,StrAV_SW,ToqReqSt,ToqReqVa,T_Stamp,Vx];
xlswrite(filename,colname,1);
xlswrite(filename,M,1,'A2');










