
clc;
clear;
tic

%%  path of the AnyMatBatch codes if toolbox is not installed
% addpath(fullfile(cd,'..\','AnyMatCodes'));
% addpath('C:\Users\100053511\Documents\Trials\CellinaModelTrials\AnyMatCodes');

%% Define the output variables to be recoreded for analysis
outputvars=[{'Main.Studies.MarkerTracking.Output.JointAngleOutputs.OutputFile_LeftLeg.HipFlexion'}...
    ;{'Main.Studies.MarkerTracking.Output.JointAngleOutputs.OutputFile_LeftLeg.HipAbduction'}...
    ;{'Main.Studies.MarkerTracking.Output.JointAngleOutputs.OutputFile_LeftLeg.HipExternalRotation'}...
    ;{'Main.Studies.MarkerTracking.Output.JointAngleOutputs.OutputFile_LeftLeg.KneeFlexion'}...
    ;{'Main.Studies.MarkerTracking.Output.JointAngleOutputs.OutputFile_LeftLeg.AnklePlantarFlexion'}...
    ;{'Main.Studies.MarkerTracking.Output.JointAngleOutputs.OutputFile_LeftLeg.SubTalarEversion'}...
    ;{'Main.Studies.MarkerTracking.Output.JointAngleOutputs.OutputFile_RightLeg.HipFlexion'}...
    ;{'Main.Studies.MarkerTracking.Output.JointAngleOutputs.OutputFile_RightLeg.HipAbduction'}...
    ;{'Main.Studies.MarkerTracking.Output.JointAngleOutputs.OutputFile_RightLeg.HipExternalRotation'}...
    ;{'Main.Studies.MarkerTracking.Output.JointAngleOutputs.OutputFile_RightLeg.KneeFlexion'}...
    ;{'Main.Studies.MarkerTracking.Output.JointAngleOutputs.OutputFile_RightLeg.AnklePlantarFlexion'}...
    ;{'Main.Studies.MarkerTracking.Output.JointAngleOutputs.OutputFile_RightLeg.SubTalarEversion'}...
    ;{'Main.Studies.MarkerTracking.Output.JointAngleOutputs.OutputFile_TrunkFull.PelvisRotVec'}...
    ;{'Main.Studies.InverseDynamicStudy.Output.BodyModel.SelectedOutput.Left.Leg.JointMomentMeasure.HipAbduction'}...
    ;{'Main.Studies.InverseDynamicStudy.Output.BodyModel.SelectedOutput.Left.Leg.JointMomentMeasure.HipFlexion'}...
    ;{'Main.Studies.InverseDynamicStudy.Output.BodyModel.SelectedOutput.Left.Leg.JointMomentMeasure.HipExternalRotation'}...
    ;{'Main.Studies.InverseDynamicStudy.Output.BodyModel.SelectedOutput.Left.Leg.JointMomentMeasure.KneeFlexion'}...
    ;{'Main.Studies.InverseDynamicStudy.Output.BodyModel.SelectedOutput.Left.Leg.JointMomentMeasure.AnklePlantarFlexion'}...
    ;{'Main.Studies.InverseDynamicStudy.Output.BodyModel.SelectedOutput.Left.Leg.JointMomentMeasure.SubTalarEversion'}...
    ;{'Main.Studies.InverseDynamicStudy.Output.BodyModel.SelectedOutput.Right.Leg.JointMomentMeasure.HipAbduction'}...
    ;{'Main.Studies.InverseDynamicStudy.Output.BodyModel.SelectedOutput.Right.Leg.JointMomentMeasure.HipFlexion'}...
    ;{'Main.Studies.InverseDynamicStudy.Output.BodyModel.SelectedOutput.Right.Leg.JointMomentMeasure.HipExternalRotation'}...
    ;{'Main.Studies.InverseDynamicStudy.Output.BodyModel.SelectedOutput.Right.Leg.JointMomentMeasure.KneeFlexion'}...
    ;{'Main.Studies.InverseDynamicStudy.Output.BodyModel.SelectedOutput.Right.Leg.JointMomentMeasure.AnklePlantarFlexion'}...
    ;{'Main.Studies.InverseDynamicStudy.Output.BodyModel.SelectedOutput.Right.Leg.JointMomentMeasure.SubTalarEversion'}...
    ;{'Main.Studies.InverseDynamicStudy.Output.BodyModel.SelectedOutput.Left.Leg.Muscles.MuscleActivity.SoleusActivity'}...
    ;{'Main.Studies.InverseDynamicStudy.Output.BodyModel.SelectedOutput.Left.Leg.Muscles.MuscleActivity.TibialisAnteriorActivity'}...
    ;{'Main.Studies.InverseDynamicStudy.Output.BodyModel.SelectedOutput.Left.Leg.Muscles.MuscleActivity.TibialisPosteriorActivity'}...
    ;{'Main.Studies.InverseDynamicStudy.Output.BodyModel.SelectedOutput.Left.Leg.Muscles.MuscleActivity.RectusFemorisActivity'}...
    ;{'Main.Studies.InverseDynamicStudy.Output.BodyModel.SelectedOutput.Left.Leg.Muscles.MuscleActivity.VastusActivity'}...
    ;{'Main.Studies.InverseDynamicStudy.Output.BodyModel.SelectedOutput.Left.Leg.Muscles.MuscleActivity.BicepsFemorisCaputBreveActivity'}...
    ;{'Main.Studies.InverseDynamicStudy.Output.BodyModel.SelectedOutput.Left.Leg.Muscles.MuscleActivity.BicepsFemorisCaputLongActivity'}...
    ;{'Main.Studies.InverseDynamicStudy.Output.BodyModel.SelectedOutput.Left.Leg.Muscles.MuscleActivity.GluteusMaxActivity'}...
    ;{'Main.Studies.InverseDynamicStudy.Output.Abscissa.t'}...
    ;{'Main.Studies.MarkerTracking.Output.Abscissa.t'}];

%% Create mini macors list with the Operation
com_lists=minimacros([

loadmodel("Main.any");
operation({'MyCam.Create_Video'});
outputvalue(outputvars,'dump');
{'exit'}],1);


%% Macro creation based on mini macros
macros=createmacros(com_lists,1,1);
% createmacros(com_lists,number of macros to be copied,no of macros to be run in parallel);

%%  Run Macros to obtain the Results =======================
Olddir=cd;
t_macros=cell(size(macros));
%% Route to navigate to folder [foler containing the subject data]

str_l='C:\Users\100053511\Documents\Trials\CellinaModelTrials\Cellina_with_GRF_Prediction\Subjects';
dfolders=listfolder(str_l);

% ========== User Gender data to avoid running for female subject=====
gen={'M','W','W','M','M','M','W','W','M','M','W','M','W','W','W','M','W','M','W','M','W','M','W','W','W','M','W','M','M','W','M','M','W','M','W','W','W','W','W','M','W','W','M','M','M','M','M','M','M','M'};



combine=struct([]);

%% Running model for all subjects

for j=1:length(dfolders)

    dfolders_name=dfolders(j).name;
    if strcmp(gen(1,j),'M')
        modeldir=sprintf('%s\\%s',str_l,dfolders_name);

        dfolders_in=listfolder(modeldir);

        %  =============== Runnig static file first to obtain parameters==
        dfolders_in_name=dfolders_in(end).name;
        modellocation_in=sprintf('%s\\%s',modeldir,dfolders_in_name);
        cd (modellocation_in)
        fprintf('\n Currently in directory \n %s',modellocation_in);
        if ~exist('log.txt','file')
            %  ============== Trasferring Macros to wokring directory ========
            for k=1:length(macros)
                [~,NAME,EXT] = fileparts(macros{k});
                t_macros{k}=fullfile(modellocation_in,sprintf('%s.txt',string(NAME)));
                copyfile(macros{k},t_macros{k})
            end

            %=============================================================
            %------------- Runnign the system-----------------------------
            simresult=runmacros(t_macros,1);
            save(strcat(dfolders_in_name,'analysis.mat'), 'simresult');
            %**********************************************************
        end
        for m=1:length(dfolders_in)-1
            dfolders_in_name=dfolders_in(m).name;
            modellocation_in=sprintf('%s\\%s',modeldir,dfolders_in_name);
            cd (modellocation_in)
            fprintf('\n Currently in directory \n %s',modellocation_in);
            if ~exist('log.txt','file')
                %  ============== Trasferring Macros to wokring directory ========
                for k=1:length(macros)
                    [~,NAME,EXT] = fileparts(macros{k});
                    t_macros{k}=fullfile(modellocation_in,sprintf('%s.txt',string(NAME)));
                    copyfile(macros{k},t_macros{k})
                end

                %=============================================================
                %------------- Runnign the system-----------------------------
                simresult=runmacros(t_macros,1);
                save(strcat(dfolders_in_name,'analysis.mat'), 'simresult');
                %------------ Combined Result ----------------------------------
                combine(j,m).result=simresult;
            end
        end
    else
        fprintf('\n Skipping Becasue the %s is for female subject \n',dfolders_name);
    end
    cd(Olddir);
end
cd(Olddir);

%%  Save analysis as one file
save('analysis23.mat', 'combine');
toc


