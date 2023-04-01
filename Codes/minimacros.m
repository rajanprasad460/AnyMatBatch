function out = minimacros(x,n)
% function out = minimacros(x,n)
% Creates mini macros to be run based on specified commands
% x = commands
% n = numer of times macros to be repeated



x_string=string(x);
key=contains(x_string,'"Set Value"');
key_x=find(key==1);
y=length(key_x)/n;
n_key_x=reshape(key_x,[n,y]);
l_count=1;
out={''};
for i=1:n
    temp_macros=x;
    temp_macros(reshape(n_key_x(setdiff(1:n,i),:),1,[]))='';

    out(l_count:l_count+length(temp_macros)-1,1)=temp_macros;
    l_count=l_count+length(temp_macros);
    %============== [ ADDITIONAL ] =====================================
    %-- If all set values are required to be executed as separate macros
    %     out(end+1,1)={'exit'};
    %     l_count=l_count+length(temp_macros)+1;
    %--------------------------------------------------------

end
end


%
% function out = minimacros(x,setvariables,n)
%
% x_string=string(x);
% [ry,cy]=size(setvariables);
% y=max(ry,cy);
% key=contains(x_string,'"Set Value"');
% key_x=find(key==1);
% n_key_x=reshape(key_x,[n,y]);
% l_count=1;
% for i=1:n
%     temp_macros=x;
%     temp_macros(reshape(n_key_x(setdiff(1:n,i),:),1,[]))='';
%
%     out(l_count:l_count+length(temp_macros)-1,1)=temp_macros;
%     l_count=l_count+length(temp_macros);
% end
% end
