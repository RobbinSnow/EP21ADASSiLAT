% origin written by Zhujun
function [plotflag] = myplotyyset(AX,H1,H2,X1,Y1,Y2,mylegend,mylegendpos,isY2logic)

myColor1 = [70/255,130/255,180/255];  %左侧坐标轴及曲线颜色
myColor2 = [1,140/255,0];             %右侧坐标轴及曲线颜色
% myGcaPos=[0.05,0.05,0.9,0.9];       %[0.05,0.05]是图形相对绘图区左下角的位置，[0.8,0.8]是图形相对绘图区的大小比例
plotflag = 0;

myXlim1 = [min(X1) max(X1)+5];
[myYlim1,myTick1] = myCalYlim(Y1);
[myYlim2,myTick2] = myCalYlim(Y2);
nY1 = size(Y1,2);
nY2 = size(Y2,2);
if nY1==1
    set(H1(1),'LineStyle','-','Color',myColor1,'LineWidth', 0.5);
elseif nY1==2
    set(H1(1),'LineStyle','-','Color',myColor1,'LineWidth', 0.5);
    set(H1(2),'LineStyle','-.','Color',myColor1,'LineWidth', 0.5);
elseif nY1==3
    set(H1(1),'LineStyle','-','Color',myColor1,'LineWidth', 0.5);
    set(H1(2),'LineStyle','-.','Color',myColor1,'LineWidth', 0.5);
    set(H1(3),'LineStyle',':','Color',myColor1,'LineWidth', 0.5);
else
    return;
end

set(AX(1),'YColor',myColor1);
set(AX(1),'Xlim',myXlim1,'Ylim',myYlim1,'fontsize', 6);
set(AX(1),'YTick',myTick1);

if nY2==1
    set(H2(1),'LineStyle','-','Color',myColor2,'LineWidth', 0.5);
elseif nY2==2
    set(H2(1),'LineStyle','-','Color',myColor2,'LineWidth', 0.5);
    set(H2(2),'LineStyle',':','Color',myColor2,'LineWidth', 0.5);
elseif nY2==3
    set(H2(1),'LineStyle','-','Color',myColor2,'LineWidth', 0.5);
    set(H2(2),'LineStyle',':','Color',myColor2,'LineWidth', 0.5);
    set(H2(3),'LineStyle','__','Color',myColor2,'LineWidth', 0.5);
else
    return;
end

set(AX(2),'YColor',myColor2);
set(AX(2),'Ylim',myYlim2,'fontsize',6);
if isY2logic==1
    set(AX(2),'Ytick',(0:1:1));
else
    set(AX(2),'YTick',myTick2);
end

% leghandle=legend(mylegend,'fontsize',6,'Location','northeast');
% get(leghandle,'position')
% set(zz,'position',mylegendpos);
legend(mylegend,'fontsize',4,'position',mylegendpos);
legend('boxoff');
grid on;
% legend('position',[0.25,0.93,0.2,0.05]);

% set(gcf,'position',myFigPos);
% set(gca,'position',myGcaPos);

% set(myfig,'Position',myFigPos);
% set(myfig,'PaperSize',myPaperSize);
% set(myfig,'PaperPosition',myPaperPosition);

plotflag=1;

