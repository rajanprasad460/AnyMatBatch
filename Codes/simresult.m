function [result,error,ecount] = simresult(cmdout)
% function [result,error,ecount] = simresult(cmdout)
% Extract the outputs from the ANYBODY console output.
% May require modification depending on the changes in Console outputs.

% data = regexpi(cmdout, 'classoperation.*?.Output..*? "Dump".*?=(.*?)##', 'tokens');
% name_data=regexpi(cmdout, 'classoperation.*?.Output.(.*?) "Dump".*?##', 'tokens');

data = regexpi(cmdout, 'classoperation.*?.Output..*? "Dump".*?=(.*?)##', 'tokens');
% Exclude the full file name upto [Model. .....Output]===================
t_name_data=regexpi(cmdout, 'classoperation.*?.Output.(.*?)##','tokens');
% Doesnot Exclude anything [As per ANYBODY] =============================
% t_name_data=regexpi(cmdout, 'classoperation(.*?)##','tokens');
%=======================================================================
name_data=regexpi((string(t_name_data)), '(.*?) "Dump".*?', 'tokens');
% Deleting the empty cells in the name_data ----------------------------
name_data(cellfun(@isempty,name_data))='';

e_catch=regexpi(cmdout, 'Error :(.*?)#', 'tokens');
% Finding data from the Dumped Output file -----------------
[~,n]=size(data);
ecount=0;

result=cell(2,n);
for i=1:n
    temp=char(data{1,i});
    del_key1=find(temp=='{');
    del_key2=find(temp=='}');
    del_key3=find(temp==';');
    temp([del_key1 del_key2 del_key3])='';
    Z = textscan(string(temp),'%s','Delimiter',',');
    temp_field=char(string(name_data{1,i}));
    temp_field(isspace(temp_field))='';
    result{1,i}=temp_field;
    result{2,i}=Z{1,1};
end

if isempty(e_catch)
    error='';
else
    [~,ne]=size(e_catch);
    ecount=ne;
    error=e_catch;
end
end