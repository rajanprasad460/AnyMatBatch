function simrun =runmacros(macros,disp_opt)
% function simrun =runmacros(macros,disp_opt)
% Run the macros created to ANYBODY.
% Definition of path ANYBODY console application location is required.
% Usually it is in the installation directory such as "C:\Program Files\AnyBody.7.3\AnyBodyCon.exe"
% Define this path to run the model. Depending on the model update, this
% directory name keep changing and has to be defined manually. Also can
% capture installation on other location of ANYBODY by user definition manually.
% macros = macors created to be run
% disp_opt : whether to see the console terminal or run it behind silently
% disp_opt = 0 or 1
% simrun is structure containing all the results and error





nsim=length(macros);
s_progress=blanks(50);
simrun = struct([]) ;
ecount=0;


for i=1:nsim
    reservecommand='"C:\Program Files\AnyBody.7.3\AnyBodyCon.exe"';
    command_in=sprintf('%s -m "%s"',reservecommand,macros{i});
    if disp_opt==1
        [~,cmdout]=system(command_in,'-echo');
    else
        [~,cmdout]=system(command_in);
    end
    if i==1000
    else
        delete(macros{i});
    end

    [simrun(i).result,simrun(i).error,error]=simresult(cmdout);

    % --------- Writting a log file for User --------------------------
    if i==1
        fileID = fopen('log.txt','w');
    else
        fileID = fopen('log.txt','a');
    end
    fmt='\n %s \n';
    fprintf(fileID,fmt, string(cmdout));


    ecount=ecount+error;
    progress=round(i/nsim*50);
    s_progress(1:progress)=repelem('*',progress);
    a_progress=sprintf('%d%%',progress*2);
    s_progress(23:23+length(a_progress)-1)=a_progress;
    clc;
    fprintf('[%s] Complete %d out of %d [%d Erros]\n',s_progress,i,nsim,ecount);
end
fclose(fileID);

end