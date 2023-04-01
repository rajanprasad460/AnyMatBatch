function [out,m] =setvalue(x,parameter)
%  [out,m] =setvalue(x,parameter)
% It will set a value to certain parameters if required to be varied during
% simulation.
% x = variable name whose values is to be varied or assigned
% parameter = value that is to be assigned
% Note : x is a single variable and parameters could be multiple

value='';
[m,~]=size(parameter);
parameter=cellstr(string(parameter));

for i=1:m
value{i,1}=sprintf('classoperation %s "Set Value" -v --value="%s"',string(x),parameter{i,:});
end
out=cellstr(value);
end