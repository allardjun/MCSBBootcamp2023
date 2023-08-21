function uValue = uBlackBox(t)

A_hidden     = 1.1; % fluorescence intensity units
omega_hidden = 2.6; % rad/s
A0_hidden    = 0.01;
B_hidden     = 0.5;

uValue = A_hidden*sin(omega_hidden*t)+A0_hidden + B_hidden*cos(omega_hidden*t);

end