%% Part 3a
% convert your data to units of volts by multiplying by the appropriate
% scaling factor.
dataVolts = dataADC * ??

% plot the results
figure(2);clf;
plot(etime, dataVolts);
xlabel('Time (sec)');
ylabel('Spirometry signal (V)');
axis([0 seconds_to_record 0 5]);



