function [Accflag]=myAccPlot(Res,id,str)
% function [Accflag]=myAccPlot(Res,id,FilePath)
% function to plot figure and print .eps file
%%
figure(10000+id)
set(gcf,'position',[20 20 450 450]);  
% myPaperSize=[8 4];
% myPaperPosition=[0 0 8 4];
%%
%subfigure1
myplotBasPosL   = [0.05 0.84 0.4 0.15];% left subplot base position
myplotBasPosR   = [0.55 0.84 0.4 0.15];
mylegendBasPosL = [0.26,0.94,0.2,0.02];% left legend base position
mylegendBasPosR = [0.76,0.94,0.2,0.02];
deltaPos = [0 0.2 0 0];
mygap = 0.01;% legend with different number of lines,modify the location compare to with 3 lines 

subplot(5,2,1);
subplot('Position',myplotBasPosL);
% hplo=figure(10000+10*id-9);
[AX,H1,H2] = plotyy(Res.Time,Res.LockedID,Res.Time,[Res.OnSw,Res.CanclSw]);
mylegend={'LockedID','OnSw', 'CanclSw'};
mylegendpos = mylegendBasPosL + [0,(3-length(mylegend))*mygap,0,0];
[plotflag] = myplotyyset(AX,H1,H2,Res.Time,Res.LockedID,[Res.OnSw,Res.CanclSw],mylegend,mylegendpos,1);


% print(strcat('fig',num2str(10000+10*id-9)),'-depsc');
% close(figure(10000+10*id-9));
%%
%subfigure2
subplot(5,2,2);
subplot('Position',myplotBasPosR);
H1 = plot(Res.Time,Res.ACCSysSt);
mylegend = {'ACCSysSt'};
mylegendpos = mylegendBasPosR+[0,(3-length(mylegend))*mygap,0,0];
[plotflag] = myplotset(H1,Res.Time,Res.ACCSysSt,mylegend,mylegendpos);
% print(strcat('fig',num2str(10000+10*id-8)),'-depsc');
% close(figure(10000+10*id-8));
%%
%subfigure3
subplot(5,2,3);
subplot('Position',myplotBasPosL-deltaPos);
[AX,H1,H2] = plotyy(Res.Time,[Res.SetSpd,Res.MemSpd],Res.Time,[Res.SetSw,Res.RsmSw]);
mylegend ={'SetSpd','MemSpd', 'SetSw','RsmSw'};
mylegendpos = mylegendBasPosL-deltaPos+[0,(3-length(mylegend))*mygap,0,0];
[plotflag] = myplotyyset(AX,H1,H2,Res.Time,[Res.SetSpd,Res.MemSpd],[Res.SetSw,Res.RsmSw],mylegend,mylegendpos,1);
% print(strcat('fig',num2str(10000+10*id-7)),'-depsc');
% close(figure(10000+10*id-7));
%%
%subfigure4
subplot(5,2,4);
subplot('Position',myplotBasPosR-deltaPos);
% hplo=figure(10000+10*id-6);
H1 = plot(Res.Time,Res.ACCReqVa,Res.Time,Res.Ax);
mylegend ={'ACCReqVa','Ax'};
mylegendpos = mylegendBasPosR-deltaPos+[0,(3-length(mylegend))*mygap,0,0];
[plotflag] = myplotset(H1,Res.Time,[Res.ACCReqVa,Res.Ax],mylegend,mylegendpos);
% print(strcat('fig',num2str(10000+10*id-6)),'-depsc');
% close(figure(10000+10*id-6));
%%
%subfigure5
subplot(5,2,5);
subplot('Position',myplotBasPosL-2*deltaPos);
% hplo=figure(10000+10*id-5);
[AX,H1,H2] = plotyy(Res.Time,[Res.Vx,Res.SetSpd,Res.LockedVx],Res.Time,[Res.SpdIncSw,Res.SpdDecSw]);
mylegend = {'Vx','SetSpd', 'LockedVx','SpdIncSw','SpdDecSw'};
mylegendpos = mylegendBasPosL-2*deltaPos+[0,(3-length(mylegend))*mygap,0,0];
[plotflag] = myplotyyset(AX,H1,H2,Res.Time,[Res.Vx,Res.SetSpd,Res.LockedVx],[Res.SpdIncSw,Res.SpdDecSw],mylegend,mylegendpos,1);
% print(strcat('fig',num2str(10000+10*id-5)),'-depsc');
% close(figure(10000+10*id-5));
%%
%subfigure6
% hplo=figure(10000+10*id-4);
subplot(5,2,6);
subplot('Position',myplotBasPosR-2*deltaPos);
[AX,H1,H2] = plotyy(Res.Time,Res.ACCReqVa,Res.Time,Res.ACCReqSt);
mylegend ={'ACCReqVa','ACCReqSt'};
mylegendpos = mylegendBasPosR-2*deltaPos+[0,(3-length(mylegend))*mygap,0,0];
[plotflag] = myplotyyset(AX,H1,H2,Res.Time,Res.ACCReqVa,Res.ACCReqSt,mylegend,mylegendpos,1);
% print(strcat('fig',num2str(10000+10*id-4)),'-depsc');
% close(figure(10000+10*id-4));
%%
%subfigure7
% hplo=figure(10000+10*id-3);
subplot(5,2,7);
subplot('Position',myplotBasPosL-3*deltaPos);
[AX,H1,H2] = plotyy(Res.Time,Res.LockedX,Res.Time,[Res.DisIncSw,Res.DisDecSw]);
mylegend ={'LockedX','DisIncSw','DisDecSw'};
mylegendpos = mylegendBasPosL-3*deltaPos+[0,(3-length(mylegend))*mygap,0,0];
[plotflag] = myplotyyset(AX,H1,H2,Res.Time,Res.LockedX,[Res.DisIncSw,Res.DisDecSw],mylegend,mylegendpos,1);
% print(strcat('fig',num2str(10000+10*id-3)),'-depsc');
% close(figure(10000+10*id-3));
%%
%subfigure8
% hplo=figure(10000+10*id-2);
subplot(5,2,8);
subplot('Position',myplotBasPosR-3*deltaPos);
[AX,H1,H2] = plotyy(Res.Time,Res.ToqReqVa,Res.Time,Res.ToqReqSt);
mylegend ={'ToqReqVa','ToqReqSt'};
mylegendpos = mylegendBasPosR-3*deltaPos+[0,(3-length(mylegend))*mygap,0,0];
[plotflag] = myplotyyset(AX,H1,H2,Res.Time,Res.ToqReqVa,Res.ToqReqSt,mylegend,mylegendpos,1);
% print(strcat('fig',num2str(10000+10*id-2)),'-depsc');
% close(figure(10000+10*id-2));
%%
% %subfigure9
% hplo=figure(10000+10*id-1);
% H1 = plot(Res.Time,Res.BrkPed,Res.Time,Res.AccPed);
% mylegend={'BrkPed','AccPed'};
% [plotflag]=myplotset(hplo,H1,[Res.BrkPed,Res.AccPed],mylegend)
% % print(strcat('fig',num2str(10000+10*id-1)),'-depsc');
% close(figure(10000+10*id-1));
subplot(5,2,9);
subplot('Position',myplotBasPosL-4*deltaPos);
[AX,H1,H2] = plotyy(Res.Time,Res.Steer_SW,Res.Time,Res.Ay);
mylegend ={'SteerSW','Ay'};
mylegendpos = mylegendBasPosL-4*deltaPos+[0,(3-length(mylegend))*mygap,0,0];
[plotflag] = myplotyyset(AX,H1,H2,Res.Time,Res.Steer_SW,Res.Ay,mylegend,mylegendpos,0);
% print(strcat('fig',num2str(10000+10*id)),'-depsc');
% close(figure(10000+10*id));
%%
%subfigure10
% hplo=figure(10000+10*id);
subplot(5,2,10);
subplot('Position',myplotBasPosR-4*deltaPos);
[AX,H1,H2] = plotyy(Res.Time,Res.Steer_SW,Res.Time,Res.Ay);
mylegend ={'SteerSW','Ay'};
mylegendpos = mylegendBasPosR-4*deltaPos+[0,(3-length(mylegend))*mygap,0,0];
[plotflag] = myplotyyset(AX,H1,H2,Res.Time,Res.Steer_SW,Res.Ay,mylegend,mylegendpos,0);
% print(strcat(FilePath,'fig',num2str(10000+id)),'-depsc');
print(strcat(str,'fig',num2str(10000+id)),'-depsc');
close(figure(10000+id));
%%
Accflag=1;


% % %%
% % %subfigure1
% % hplo=figure(10000+10*id-9);
% % [AX,H1,H2] = plotyy(Res.Time,Res.LockedID,Res.Time,[Res.OnSw,Res.CanclSw]);
% % mylegend={'LockedID','OnSw', 'CanclSw'};
% % [plotflag]=myplotyyset(hplo,AX,H1,H2,Res.LockedID,[Res.OnSw,Res.CanclSw],mylegend,1);
% % % print(strcat('fig',num2str(10000+10*id-9)),'-depsc');
% % close(figure(10000+10*id-9));
% % %%
% % %subfigure2
% % hplo=figure(10000+10*id-8);
% % H1 = plot(Res.Time,Res.ACCSysSt);
% % mylegend={'ACCSysSt'};
% % [plotflag]=myplotset(hplo,H1,Res.ACCSysSt,mylegend);
% % % print(strcat('fig',num2str(10000+10*id-8)),'-depsc');
% % close(figure(10000+10*id-8));
% % %%
% % %subfigure3
% % hplo=figure(10000+10*id-7);
% % [AX,H1,H2] = plotyy(Res.Time,[Res.SetSpd,Res.MemSpd],Res.Time,[Res.SetSw,Res.RsmSw]);
% % mylegend={'SetSpd','MemSpd', 'SetSw','RsmSw'};
% % [plotflag]=myplotyyset(hplo,AX,H1,H2,[Res.SetSpd,Res.MemSpd],[Res.SetSw,Res.RsmSw],mylegend,1);
% % % print(strcat('fig',num2str(10000+10*id-7)),'-depsc');
% % close(figure(10000+10*id-7));
% % %%
% % %subfigure4
% % hplo=figure(10000+10*id-6);
% % H1 = plot(Res.Time,Res.ACCReqVa,Res.Time,Res.Ax);
% % mylegend={'ACCReqVa','Ax'};
% % [plotflag]=myplotset(hplo,H1,[Res.ACCReqVa,Res.Ax],mylegend);
% % % print(strcat('fig',num2str(10000+10*id-6)),'-depsc');
% % close(figure(10000+10*id-6));
% % %%
% % %subfigure5
% % hplo=figure(10000+10*id-5);
% % [AX,H1,H2] = plotyy(Res.Time,[Res.Vx,Res.SetSpd,Res.LockedVx],Res.Time,[Res.SpdIncSw,Res.SpdDecSw]);
% % mylegend={'Vx','SetSpd', 'LockedVx','SpdIncSw','SpdDecSw'};
% % [plotflag]=myplotyyset(hplo,AX,H1,H2,[Res.Vx,Res.SetSpd,Res.LockedVx],[Res.SpdIncSw,Res.SpdDecSw],mylegend,1);
% % % print(strcat('fig',num2str(10000+10*id-5)),'-depsc');
% % close(figure(10000+10*id-5));
% % %%
% % %subfigure6
% % hplo=figure(10000+10*id-4);
% % [AX,H1,H2] = plotyy(Res.Time,Res.ACCReqVa,Res.Time,Res.ACCReqSt);
% % mylegend={'ACCReqVa','ACCReqSt'};
% % [plotflag]=myplotyyset(hplo,AX,H1,H2,Res.ACCReqVa,Res.ACCReqSt,mylegend,1);
% % % print(strcat('fig',num2str(10000+10*id-4)),'-depsc');
% % close(figure(10000+10*id-4));
% % %%
% % %subfigure7
% % hplo=figure(10000+10*id-3);
% % [AX,H1,H2] = plotyy(Res.Time,Res.LockedX,Res.Time,[Res.DisIncSw,Res.DisDecSw]);
% % mylegend={'LockedX','DisIncSw','DisDecSw'};
% % [plotflag]=myplotyyset(hplo,AX,H1,H2,Res.LockedX,[Res.DisIncSw,Res.DisDecSw],mylegend,1);
% % % print(strcat('fig',num2str(10000+10*id-3)),'-depsc');
% % close(figure(10000+10*id-3));
% % %%
% % %subfigure8
% % hplo=figure(10000+10*id-2);
% % [AX,H1,H2] = plotyy(Res.Time,Res.ToqReqVa,Res.Time,Res.ToqReqSt);
% % mylegend={'ToqReqVa','ToqReqSt'};
% % [plotflag]=myplotyyset(hplo,AX,H1,H2,Res.ToqReqVa,Res.ToqReqSt,mylegend,1);
% % % print(strcat('fig',num2str(10000+10*id-2)),'-depsc');
% % close(figure(10000+10*id-2));
% % %%
% % % %subfigure9
% % % hplo=figure(10000+10*id-1);
% % % H1 = plot(Res.Time,Res.BrkPed,Res.Time,Res.AccPed);
% % % mylegend={'BrkPed','AccPed'};
% % % [plotflag]=myplotset(hplo,H1,[Res.BrkPed,Res.AccPed],mylegend)
% % % % print(strcat('fig',num2str(10000+10*id-1)),'-depsc');
% % % close(figure(10000+10*id-1));
% % %%
% % %subfigure10
% % hplo=figure(10000+10*id);
% % [AX,H1,H2] = plotyy(Res.Time,Res.Steer_SW,Res.Time,Res.Ay);
% % mylegend={'Steer_SW','Ay'};
% % [plotflag]=myplotyyset(hplo,AX,H1,H2,Res.Steer_SW,Res.Ay,mylegend,0);
% % % print(strcat('fig',num2str(10000+10*id)),'-depsc');
% % close(figure(10000+10*id));
% % %%
% % Accflag=1;