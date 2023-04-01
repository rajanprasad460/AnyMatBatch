function Result =processresult(simrun,outputvar)
% function Result =processresult(simrun,outputvar)
% Extract the output from the simulation result obtained from the simresult
% module.
% simrun = output of the simresult module
% outputvar = the output variables to be extracted




[~,ns]=size(simrun);
r_count=1;
for i=1:ns
    temp_result=simrun(i).result;
    [~,mr]=size(temp_result);
    Results(:,r_count:r_count+mr-1)=temp_result;
    heading(r_count:r_count+mr-1)=temp_result(1,:);
    r_count=r_count+mr;
end

key=strcmp(heading,outputvar);
Result=(Results(2,key));
end