function out = operation(x)
% function out = operation(x)
% Create a function to be perfomed while running the model during simulation.
% For example, generating the gif animation or recording the video (ffmpeg.exe)
% is required to be placed in the main directory of the model.
% x = {'MyCam.Create_Video'}; % Defined as cell array : use ; to include another operations at simulatneous locaiton



value='';
[m,~]=size(x);
for i=1:m
    value{i,1}=sprintf('operation %s',x{i,1});
end
value{m+1,1}='run';
out=cellstr(value);
end