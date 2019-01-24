%% RAW DATA 

clear
close all
clc

[data txt raw] = xlsread('Data.xls');

year = data(:,1);
gtanom = data(:,2); % K, global temp anomaly
CO2 = data(:,3); % ppm, atmospheric CO2 concentration


%% RAW CHARTS

figure
subplot(211)
plot(year,gtanom,'k'); 
xlabel('Year'); 
ylabel({'Temp ' ,'Anomaly ({\circ}C)'})
title({'Global Temperature Anomaly' ,'from 1880-2017'})
axis([1878,2018,-1,1.1])
mgtanom = ~isnan(gtanom);
maskboth = isnan(gtanom) | isnan(year);
[coef,bint,r,rint,stats] = regress(gtanom,[ones(size(gtanom)) year]);
R1 = stats(1)^2; 
p1 = stats(3);
[R,p] = corrcoef(gtanom(~maskboth),year(~maskboth));

gtanomlinfit = coef(1)+coef(2).*year;
gtanomlinfitbotlim = coef(1)+bint(2,1).*year;
gtanomlinfittoplim = coef(1)+bint(2,2).*year;
hold on
plot(year(mgtanom),gtanomlinfit(mgtanom),'r'); 
%plot(year(mgtanom),gtanomlinfitbotlim(mgtanom),'r--'); 
%plot(year(mgtanom),gtanomlinfittoplim(mgtanom),'r--'); 
text(1880,0.9,['Slope = ',num2str(round(coef(2),3)),...
    '; p-value = ' num2str(p(2,1)) ','...
    'Correlation Coefficient = ' num2str(R(2,1)) ])
hold off


subplot(212)
plot(year,CO2,'k'); 
xlabel('Year'); 
ylabel('CO_2 (ppm)')
title({'Atmospheric CO2 ' ,'from 1959-2017'})
axis([1955,2018,300,420])
mgtanom = ~isnan(CO2);
maskboth = isnan(CO2) | isnan(year);
[coef,bint,r,rint,stats] = regress(CO2,[ones(size(CO2)) year]);
R1 = stats(1)^2; 
p1 = stats(3);
[R,p] = corrcoef(CO2(~maskboth),year(~maskboth));

gtanomlinfit = coef(1)+coef(2).*year;
gtanomlinfitbotlim = coef(1)+bint(2,1).*year;
gtanomlinfittoplim = coef(1)+bint(2,2).*year;
hold on
plot(year(mgtanom),gtanomlinfit(mgtanom),'r'); 
%plot(year(mgtanom),gtanomlinfitbotlim(mgtanom),'r--'); 
%plot(year(mgtanom),gtanomlinfittoplim(mgtanom),'r--'); 
text(1955,410,['Slope = ',num2str(round(coef(2),3)),...
    '; p-value = ' num2str(p(2,1)) ','...
    'Correlation Coefficient = ' num2str(R(2,1)) ])
hold off