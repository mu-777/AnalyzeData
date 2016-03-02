

figure(1);
grid on;    hold on;

line = csvread('./csv/20160114_180520_trajectory.csv', 1, 0);
ee_js = csvread('./csv/20160114_180520_peg.csv', 1, 0);
ee_av = csvread('./csv/20160114_180842_peg.csv', 1, 0);

plot3(line(:,1), line(:,2), line(:,3),'Color', 'r', 'Marker', 'x', 'LineWidth', 2, 'MarkerSize', 6)
plot3(ee_js(:,2), ee_js(:,3), ee_js(:,4), 'Color', 'g')
plot3(ee_av(:,2), ee_av(:,3), ee_av(:,4), 'Color', 'b')


figure(2);
grid on;    hold on;

plot3(line(:,1), line(:,2), line(:,3),'Color', 'r', 'Marker', 'x', 'LineWidth', 2, 'MarkerSize', 6)
for i = 1 : size(ee_js(:,1))-1
    plot3(ee_js(i:i+1,2), ee_js(i:i+1,3), ee_js(i:i+1,4), 'Color', 'g')
end

for i = 1 : size(ee_av(:,1))-1
    plot3(ee_av(i:i+1,2), ee_av(i:i+1,3), ee_av(i:i+1,4), 'Color', 'b')
end


