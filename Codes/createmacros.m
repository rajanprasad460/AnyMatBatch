function y= createmacros(x,n,np)
% function y= createmacros(x,n,np)
% Create macros based on the user specified vaiables.
% Stores the created macros as text file and is then executed by command
% prompt to run the model.
% x = minimacors created
% n = number of macros to be copied
% np = number of macros to be run in parallel
% y = string containig all the created macros location of the text files 
% [y is copied to the respective folder during console run]




key=strcmp(x,'exit');
n_actual=find(key==1);
path=pwd;
% path='C:\Users\100053511\Documents\Trials\AnyBodySimulationCodes';
str='';
count=1;
f_count=1;
r_count=1;

for i=1:(n*length(n_actual))
    
    if r_count>length(n_actual)
        r_count=1;
    end
    
    if r_count==1
        temp_macros=x(1:n_actual(r_count),:);
    else
        temp_macros=x(n_actual(r_count-1)+1:n_actual(r_count),:);
    end
    r_count=r_count+1;
    
    str{f_count}=sprintf('%s/tempmacros%d.txt',path,f_count);
    %---------- Saving the file --------------------------
    if count==1
        fileID = fopen(str{f_count},'w');
    else
        fileID = fopen(str{f_count},'a');
    end
    
    if count<np
        if i==(n*length(n_actual))
            % Do nothing
        else
            temp_macros(end,:)='';
        end
    else
        count=0;
        f_count=f_count+1;
    end
    
    
    fmt='%s';
    if length(temp_macros)>1
        for j=1:length(temp_macros)
            fmt = sprintf('%s\n%%s',fmt);
        end
    end
    fprintf(fileID,fmt, string(temp_macros));
    fclose(fileID);
    count=count+1;
end
y = str;



%========================== v3.0 ====================================
%%% Problem with n ( repeatation number)
% function y= createmacros(x,n,np)
% key=strcmp(x,'exit');
% n_actual=find(key==1);
% path=pwd;
% str='';
% count=1;
% f_count=1;

%
% for i=1:(n*length(n_actual))
%     if i==1
%     temp_macros=x(1:n_actual(i),:);
%     else
%         temp_macros=x(n_actual(i-1)+1:n_actual(i),:);
%     end
%
%
%     str{f_count}=sprintf('%s/tempmacros%d.txt',path,f_count);
%     %---------- Saving the file --------------------------
%     if count==1
%         fileID = fopen(str{f_count},'w');
%     else
%         fileID = fopen(str{f_count},'a');
%     end
%
%     if count<np
%         if i==(n*length(n_actual))
%             % Do nothing
%         else
%             temp_macros(end,:)='';
%         end
%     else
%         count=0;
%         f_count=f_count+1;
%     end
%
%
%     fmt='%s';
%     if length(temp_macros)>1
%         for j=1:length(temp_macros)
%             fmt = sprintf('%s\n%%s',fmt);
%         end
%     end
%     fprintf(fileID,fmt, string(temp_macros));
%     fclose(fileID);
%     count=count+1;
% end
% y=str;



%=======================================================================




%============================== V 2.0==============================
% key=strcmp(x,'exit');
% n_actual=find(key==1);
% path=pwd;
% str='';
% count=1;
% f_count=1;
% for i=1:n*length(n_actual)
%     temp_macros=x;
%
%     str{f_count}=sprintf('%s/tempmacros%d.txt',path,f_count);
%     %---------- Saving the file --------------------------
%     if count==1
%         fileID = fopen(str{f_count},'w');
%     else
%         fileID = fopen(str{f_count},'a');
%     end
%
%     if count<np
%         if i==n
%             temp_macros(n_actual(1:end-1),:)='';
%         else
%             temp_macros(n_actual(1:end),:)='';
%         end
%     else
%         temp_macros(n_actual(1:end-1),:)='';
%         count=0;
%         f_count=f_count+1;
%     end
%
%
%     fmt='%s';
%     if length(temp_macros)>1
%         for j=1:length(temp_macros)
%             fmt = sprintf('%s\n%%s',fmt);
%         end
%     end
%     fprintf(fileID,fmt, string(temp_macros));
%     fclose(fileID);
%     count=count+1;
% end
% y=str;

%====================================================================



% function y= createmacros(x,n)
% key=strcmp(x,'exit');
% n_actual=find(key==1);
% path=pwd;
% str='';
% for i=1:n
%     temp_macros=x;
%     if n_actual==1
%         % Do nothing
%     else % Delete the exit in between
%         temp_macros(n_actual(1:end-1),:)='';
%     end
%     str{i}=sprintf('%s/tempmacros%d.txt',path,i);
% %---------- Saving the file --------------------------
%     fileID = fopen(str{i},'w');
%     fmt='%s';
%     if length(temp_macros)>1
%         for j=1:length(temp_macros)
%             fmt = sprintf('%s\n%%s',fmt);
%         end
%     end
%     fprintf(fileID,fmt, string(temp_macros));
%     fclose(fileID);
%
% end
% y=str;