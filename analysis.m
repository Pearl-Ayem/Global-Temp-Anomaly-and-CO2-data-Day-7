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
[coef,bint,~,~,~] = regress(gtanom,[ones(size(gtanom)) year]);
[h,p,ci,stats] = ttest(gtanom);


gtanomlinfit = coef(1)+coef(2).*year;
gtanomlinfitbotlim = coef(1)+bint(2,1).*year;
gtanomlinfittoplim = coef(1)+bint(2,2).*year;
hold on
plot(year(mgtanom),gtanomlinfit(mgtanom),'r'); 
%plot(year(mgtanom),gtanomlinfitbotlim(mgtanom),'r--'); 
%plot(year(mgtanom),gtanomlinfittoplim(mgtanom),'r--'); 
text(1880,0.9,['Slope = ',num2str(round(coef(2),3)),...
    '; p-value = ' num2str(p) ','...
    'Tstat = ' num2str(stats.tstat)])
hold off


subplot(212)
plot(year,CO2,'k'); 
xlabel('Year'); 
ylabel('CO_2 (ppm)')
title({'Atmospheric CO2 ' ,'from 1959-2017'})
axis([1955,2018,300,420])
mgtanom = ~isnan(CO2);
maskboth = isnan(CO2) | isnan(year);

[coef,bint,~,~,~] = regress(CO2,[ones(size(CO2)) year]);

gtanomlinfit = coef(1)+coef(2).*year;
gtanomlinfitbotlim = coef(1)+bint(2,1).*year;
gtanomlinfittoplim = coef(1)+bint(2,2).*year;
[h,p,ci,stats] = ttest(CO2);


hold on
plot(year(mgtanom),gtanomlinfit(mgtanom),'r'); 
%plot(year(mgtanom),gtanomlinfitbotlim(mgtanom),'r--'); 
%plot(year(mgtanom),gtanomlinfittoplim(mgtanom),'r--'); 
text(1955,410,['Slope = ',num2str(round(coef(2),3)),...
    '; p-value = ' num2str(p) ','...
    'Tstat = ' num2str(stats.tstat)])
hold off

%% CORRELATION BETWEEN CO2 AND TEMP

overlap = zeros();
for i =1:length(year)
    if ~(isnan(CO2(i)) || isnan(gtanom(i)))
        overlap(i,1)= year(i);
        overlap(i,2)=gtanom(i);
        overlap(i,3)=CO2(i);
    end
end

figure
plot(overlap(:,3),overlap(:,2),'k'); 
xlabel('Year'); 
ylabel('CO_2 (ppm)')
title({'Global Temperature Anomaly VS' ,'Atmospheric CO2 from 1959-2017'})
axis([1955,2018,300,420])
mgtanom = ~isnan(overlap(:,2));
maskboth = isnan(overlap(:,2)) | isnan(overlap(:,3));

[coef,bint,~,~,~] = regress(overlap(:,2),[ones(size(overlap(:,2))) overlap(:,3)]);

gtanomlinfit = coef(1)+coef(2).*overlap(:,3);
gtanomlinfitbotlim = coef(1)+bint(2,1).*overlap(:,3);
gtanomlinfittoplim = coef(1)+bint(2,2).*overlap(:,3);
[h,p,ci,stats] = ttest(overlap(:,2));


hold on
plot(overlap(:,3),gtanomlinfit,'r'); 
%plot(year(mgtanom),gtanomlinfitbotlim(mgtanom),'r--'); 
%plot(year(mgtanom),gtanomlinfittoplim(mgtanom),'r--'); 
text(1955,410,['Slope = ',num2str(round(coef(2),3)),...
    '; p-value = ' num2str(p) ','...
    'Tstat = ' num2str(stats.tstat)])
hold off