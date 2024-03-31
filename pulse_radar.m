time_step = 5e-9;
PRI = 1e-3;
N_shift = 5e-4;
pulse_width = 1e-6;
NR = 100;
%   NR = 2e6;
%   Ts = 1/NR;

t = 0: time_step: 10*PRI - time_step;

T_signal = SignalProcess(0, t, pulse_width, PRI);
R_signal = SignalProcess(N_shift, t, pulse_width, PRI);
[t2, ADC_signal] = Sampling(R_signal, NR, time_step);


subplot(3, 1, 1)
plot(t, T_signal);
title('transfer signal'), xlabel('time'), ylabel('amplitude');

subplot(3, 1, 2)
plot(t, R_signal);
title('receiver signal'), xlabel('time'), ylabel('amplitude');
 
subplot(3, 1, 3)
plot(t2, ADC_signal)
title('sampling signal'), xlabel('time'), ylabel('amplitude');


function [signal] = SignalProcess ( N, t, pulse_width, PRI)

signal = zeros(size(t));

for n = 0:9
    for i = 1:length(t)
        if ( N + (n * PRI) <= t(i)) && ( t(i) <= pulse_width + N + (n * PRI))
            signal(i) = 1;
        end
    end
end

end


function [t2, output_signal] = Sampling ( input_signal, NR, time_step)

output_signal = resample( input_signal, 1, NR);
time = time_step * NR;
t2 = 0: time: (length(input_signal) - time) * time_step;

end


