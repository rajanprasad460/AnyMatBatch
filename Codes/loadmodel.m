function out = loadmodel(x)
% function out = loadmodel(x)
% Load the model from the specific file location
% x is the model name; usually "Main.any"

out=cellstr(string(sprintf('load "%s"',x)));
end