function out =outputvalue(varargin)
% function out =outputvalue(varargin)
% This function will request to read output specified so that it can be
% stored as .mat format for further analysis in matlab. 
% if 'dump' is specified along with outputvalues, it will dump all the
% output values during simulation in command prompt terminal and later
% stored as variable in matlab. Example outputvalue(variable,'dump')
% if a file is required to save for the output variable, then define 'save' along with 
% 'dump'. Example outputvalue(variable,'dump','save')
% The variable defined in above are listed as cell array separated by ';'
% to read multiplt output variables depending on definition.


value='';
if nargin == 2
    x=(varargin(1));
    type=string(varargin(2));
    x=string(x{:});
    [m,~]=size(x);
    if strcmp(type,'dump')
        for i=1:m
            %value{i,1}=sprintf('classoperation %s "Dump" -l --limit="5"',x(i,1));
            value{i,1}=sprintf('classoperation %s "Dump"',x(i,1));
        end
    end
    out=cellstr(value);
    
elseif nargin == 3
    x=(varargin(1));
    type=string(varargin(2));
    x=string(x{:});
    fname=string(varargin(3));
    [m,~]=size(x);
    if strcmp(type,'save')
        for i=1:m
            value{i,1}=sprintf('classoperation %s "Save data" -t --type="Deep" -f --file="%s"',x(i,1),fname);
        end
    end
    out=cellstr(value);
    
else
    error('Plese input in designated format');
end



%============================ V 1.0  ===================================
% function out =outputvalue(x,type)
% value='';
%     [m,~]=size(x);
%     if strcmp(type,'dump')
%         for i=1:m
%             %         value{i,1}=sprintf('classoperation %s "Dump" -l --limit="5"',x{i,1});
%             value{i,1}=sprintf('classoperation %s "Dump"',x{i,1});
%         end
%     end
%     out=cellstr(value);
