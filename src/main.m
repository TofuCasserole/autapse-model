% units are scaled to:
%   millivolts for voltage
%   nanoamperes for current
%   milliseconds for time
%   centimeters for space
%   microsiemens for conductance
%   megaohms for resistance
%   nanofarads for capacitance

% From Hodgkin & Huxley, 1952
% @ https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1392413/pdf/jphysiol01442-0106.pdf

Cm = 1e3;       % bulk membrane capacitance (nF/cm^2)
E_Na = -115;    % sodium nernst potential (mV) 
E_K = 12;       % potassium nernst potential (mV)
E_Cl = -10.613; % chloride nernst potential (mV)
gNa = 120e3;    % bulk maximum sodium channel conductance (uS/cm^2)
gK = 36e3;      % bulk maximum potassium channel conductance (uS/cm^2)
gCl = 300;      % bulk chloride channel conductance (uS/cm^2)