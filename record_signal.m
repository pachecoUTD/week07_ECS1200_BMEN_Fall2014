% Before running this code, connect to the Arduino using the command
% a = arduino('COM3'); 
% Note: your COM port may be different

% how many seconds of data to record
seconds_to_record = 20;

% sampling rate in Hz
sampling_rate = 10;

% time between samples
pause_time = 1/sampling_rate;

%%%%%%%%%%%% GPIO Initialization %%%%%%%%%%%%

% Initialize digital pins
LED1 = 2; % Assign the pin numbers to a variable to make them easy to reference
LED2 = 3;
LED3 = 4; 
LED4 = 5; 
LED5 = 6; 

pinMode(a,LED1,'output'); % Set GPIO pins to serve as "output" pins
pinMode(a,LED2,'output'); 
pinMode(a,LED3,'output'); 
pinMode(a,LED4,'output'); 
pinMode(a,LED5,'output'); 

digitalWrite(a,LED1,0); % Force GPIO pins "LOW" so that LEDs are off
digitalWrite(a,LED2,0);  
digitalWrite(a,LED3,0);  
digitalWrite(a,LED4,0);  
digitalWrite(a,LED5,0); 

%%%%%%%%%%%% End of GPIO Initialization %%%%%%%%%%%%


fprintf('Ready to record. Press enter to start recording...');
pause
fprintf('\n');

% the Matlab function 'now' returns the current time in Matlab serial 
% time which has units of days. To convert to seconds, you must therefore
% multiple by 24 hours/day * 3600 seconds/hour = 86400 seconds / day

% Save the current time
time0 = now;

% To convert Matlab serial time to a readable format you can use the datestr function
fprintf('Matlab serial start time %0.7f is %s\n', time0, datestr(time0));

%% Part 2
% Write a while loop that records data from the spirometer for the specified 
% duration. Store the data in a vector named 'dataADC'. For each data sample, 
% record the elapsed time (in seconds) in a vector named 'etime'

% initialize etime and data vectors
etime = []; 
dataADC = [];

figure(1);clf;
hold on;
while ((now-time0)*24*3600) < seconds_to_record
    
    % read spirometer signal from analog channel 0
    dataV = analogRead(a, 0);
    timeV = now;

    % update data vector using array concatenation
    dataADC = [dataADC dataV];
    
    % update etime vector using array concatenation
    etime = [etime (timeV-time0)*24*3600];

    % plot the data you have collected so far
    figure(1);
    plot(etime, dataADC);
    axis([0 seconds_to_record 0 1023]);

    % force Matlab to update the plot
    drawnow;
        
    % pause for fixed time
    pause(pause_time);
    
    %%%%%%%%%%%% GPIO Readout %%%%%%%%%%%%
    
    if dataV > 575
        digitalWrite(a,LED1,1);
        digitalWrite(a,LED2,1);
        digitalWrite(a,LED3,1);
        digitalWrite(a,LED4,1);
        digitalWrite(a,LED5,1);
    elseif dataV > 560
        digitalWrite(a,LED1,1);
        digitalWrite(a,LED2,1);
        digitalWrite(a,LED3,1);
        digitalWrite(a,LED4,1);
        digitalWrite(a,LED5,0);
    elseif dataV > 545
        digitalWrite(a,LED1,1);
        digitalWrite(a,LED2,1);
        digitalWrite(a,LED3,1);
        digitalWrite(a,LED4,0);
        digitalWrite(a,LED5,0);
    elseif dataV > 530
        digitalWrite(a,LED1,1);
        digitalWrite(a,LED2,1);
        digitalWrite(a,LED3,0);
        digitalWrite(a,LED4,0);
        digitalWrite(a,LED5,0);
    elseif dataV > 515
        digitalWrite(a,LED1,1);
        digitalWrite(a,LED2,0);
        digitalWrite(a,LED3,0);
        digitalWrite(a,LED4,0);
        digitalWrite(a,LED5,0);
    else
        digitalWrite(a,LED1,0);
        digitalWrite(a,LED1,0);
        digitalWrite(a,LED1,0);
        digitalWrite(a,LED1,0);
        digitalWrite(a,LED1,0);
    end
    
    %%%%%%%%%%%% End of GPIO Readout %%%%%%%%%%%%
        
         
end
xlabel('Time (sec)');
ylabel('Raw ADC units');
title('Spirometry signal'); 





