function [plotflag]=myplotset(H1,X1,Y1,mylegend,mylegendpos)
myFigPos=[200 100 1000 500];
myPaperSize=[8 4];
myPaperPosition=[0 0 8 4];
myColor1=[70/255,130/255,180/255];  %左侧坐标轴及曲线颜色
myColor2=[1,140/255,0];             %右侧坐标轴及曲线颜色
myColor3=[1,0,0];                   %右侧坐标轴及曲线颜色
myGcaPos=[0.05,0.05,0.9,0.9];       %[0.05,0.05]是图形相对绘图区左下角的位置，[0.8,0.8]是图形相对绘图区的大小比例
plotflag=0;

myXlim1= [min(X1) max(X1)+5];
[myYlim1,myTick1]= myCalYlim(Y1);
nY1 = size(Y1,2);
if nY1==1
    set(H1(1),'LineStyle','-','Color',myColor1,'LineWidth', 0.5);
elseif nY1==2
    set(H1(1),'LineStyle','-','Color',myColor1,'LineWidth', 0.5);
    set(H1(2),'LineStyle','-.','Color',myColor2,'LineWidth', 0.5);
elseif nY1==3
    set(H1(1),'LineStyle','-','Color',myColor1,'LineWidth', 0.5);
    set(H1(2),'LineStyle','-.','Color',myColor2,'LineWidth', 0.5);
    set(H1(3),'LineStyle',':','Color',myColor3,'LineWidth', 0.5);
else
    return;
end

xlim(myXlim1);
ylim(myYlim1);
set(gca,'FontSize', 6);
set(gca,'YTick',myTick1);
legend(mylegend,'fontsize',4,'Position',mylegendpos);
legend('boxoff');
grid on;

% set(gcf,'position',myFigPos);
% set(gca,'position',myGcaPos);

% set(myfig,'Position',myFigPos);
% set(myfig,'PaperSize',myPaperSize);
% set(myfig,'PaperPosition',myPaperPosition);

plotflag=1;
