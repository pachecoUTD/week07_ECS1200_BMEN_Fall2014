%% Part 3b

% convert dataVolts to air flow rate
data_airFlow_rate = dataVolts * ?? + ??;

figure(3);clf;
plot(etime, data_airFlow_rate);
xlabel('Time (sec)');
ylabel('Air flow rate (L/s)');
axis([0 seconds_to_record -17 17]);

