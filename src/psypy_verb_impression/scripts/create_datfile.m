clear; close all; clc;

%% set data and results directory
datadir = '../data';
resultdir = '../results';
conditiondir = '../conditions';

%% read data file
[fname, fpath] = uigetfile('*.csv', 'select a file', [datadir, filesep, 'verb_impression_*.csv'], 'MultiSelect', 'on');
if ~iscell(fname)
    fname = {fname};
end

%% read condition file
[cname, cpath] = uigetfile('*.xlsx', 'select a file', [conditiondir, filesep, 'condition*'], 'MultiSelect', 'off');
conditionTbl = readtable(fullfile(cpath, cname));

%% read the PCA results with categories
[pcaname, pcapath] = uigetfile('*.mat', 'select a file', ['../../quan_text_analysis/results', filesep, 'categories*.mat'], 'MultiSelect', 'off');
load(fullfile(pcapath, pcaname), 'T_traitq', 'T_pca_cat');

%% process
nFiles = length(fname);
for iFile = 1:nFiles
    verbs_c = {};
    traits_c = {};
    ratings_c = {};

    step = 1;

    fid = fopen(fullfile(fpath, fname{iFile}), 'r', 'n', 'UTF-8');
    line_in = fgetl(fid); % skip the first line
    while ~feof(fid)
        line_in = fgetl(fid);
        line_c = strsplit(line_in, ',');
        verbs_c{step} = line_c{1};
        traits_c{step} = line_c{2};
        ratings_c{step} = str2num(line_c{11});
        step = step + 1;
    end
    fclose('all');

    dataTbl = table(verbs_c', traits_c', ratings_c', 'VariableNames', {'verbs', 'traitq', 'ratings'});

    %% add traitq_id, verb_id, pca_cat_id_v
    % join and sort
    inTbl = innerjoin(dataTbl, conditionTbl);
    inTbl = sortrows(inTbl, [6, 7, 5, 4]);

    %% add pca_cat_id_q
    % join and sort
    inTbl = innerjoin(inTbl, T_traitq);
    inTbl = sortrows(inTbl, [6, 7, 5, 4]);

    %% save results
    [~, f, e] = fileparts(fname{iFile});
    %[savefile, savepath] = uiputfile('.dat', 'Save as...', fullfile(datadir, [f '.dat']));
    writetable(inTbl, fullfile(datadir, [f '.dat']));
end
