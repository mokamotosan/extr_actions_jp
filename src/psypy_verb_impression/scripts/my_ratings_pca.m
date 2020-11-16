function my_ratings_pca(ratings, labels)

%% set scripts directory
scriptDir = pwd;
p = genpath(scriptDir);
addpath(p);

%% reshape data
[ratings, TF] = rmmissing(ratings);

%% prepare labels
if ~exist('labels','var')
    labels = {};
    for ii = 1:size(ratings,2)
        labels{ii} = sprintf('item%02d', ii);
    end
end

%% �f�[�^�̃v���b�g
figure('Name', 'Boxplot');
boxplot(ratings,'orientation','horizontal','labels',labels); 
view(0, 270); xlabel('Rating'); ylabel('Item');

%% �y�A���C�Y����
C = corr(ratings,ratings, 'Rows', 'complete');
figure('Name', 'Pair-wise correlation');
imagesc(C); colorbar; xlabel('Item'); ylabel('Item');

%% �听���̌v�Z
[coeff,score,latent,~,explained] = pca(ratings);

%% �听���W�����e�[�u���ɕۑ�
% pca: coeff��column = eigenvector
% T_coeff = table(coeff(:,1), coeff(:,2), coeff(:,3), coeff(:,4), coeff(:,5), coeff(:,6), coeff(:,7), coeff(:,8), coeff(:,9), coeff(:,10), ...
%                     coeff(:,11), coeff(:,12), coeff(:,13), coeff(:,14), coeff(:,15), coeff(:,16), coeff(:,17), coeff(:,18), coeff(:,19), coeff(:,20), ...
%                     'RowNames', labels, ...
%                     'VariableNames', {'pc1', 'pc2', 'pc3', 'pc4', 'pc5', 'pc6', 'pc7', 'pc8', 'pc9', 'pc10', 'pc11', 'pc12', 'pc13', 'pc14', 'pc15', 'pc16', 'pc17', 'pc18', 'pc19', 'pc20'});
% % �听���W�����G�N�Z���ɕۑ�
% coeffTbl = table(coeff, 'RowNames', itemIDs); %coeff �̗񂲂Ƃ� 1 �̎听���̌W��: colume = eingenvector
% writetable(coeffTbl, fullfile(fpath, ['pca_results_' datestr(datetime, 'yyyymmddTHHMMSS') '.xlsx']), 'WriteRowNames', true);

%% ���K���𐫂̊m�F
I = coeff'*coeff;
I(1:3,1:3)

%% �ŗL�l�̃X�N���[�v���b�g
figure('Name', 'Screeplot of Eingenvalue');
subplot(1,2,1); title('Screeplot of Eigenvalues');
yyaxis left; bar(latent); ylim([0 sum(latent)]); ylabel('Eigenvalue'); 
yyaxis right; plot(cumsum(explained), 'o-'); ylim([0 100]); ylabel('cumsum %');
xlabel('PCs');

% Parallel analysis�ɂ����q���̌���
subplot(1,2,2); pa_test2(ratings);

%% �����̓��_�̃v���b�g
figure()
plot(score(:,1),score(:,2),'+')
xlabel('1st Principal Component')
ylabel('2nd Principal Component')

%% ���ʂ̉���
figure()
biplot(coeff(:,1:2),'scores',score(:,1:2),'varlabels',labels);
%axis([-.26 0.6 -.51 .51]);

%% �O�����p�C�v���b�g�̍쐬
figure()
likedislike = T_targetinfo.likedislike(~TF);
gender = T_targetinfo.target_gender(~TF);
distance = T_targetinfo.distance(~TF);
biplot(coeff(:,1:3),'scores',score(:,1:3),'varlabels',labels,'obslabels',gender);
%axis([-.26 0.8 -.51 .51 -.61 .81]);
view([30 40]);

%% add info
fileinfo.pca.path = fpath;
fileinfo.pca.file = fname;

%% save data
[savefile, savepath] = uiputfile('*.mat', 'Save results', fullfile(resultsdir, ['pca_' datestr(datetime, 'yyyymmddTHHMMSS') '.mat']));
save(fullfile(savepath, savefile), 'T_subconfi', 'T_subinfo', 'T_targetinfo', 'T_ans', 'T_dep', 'T_coeff', 'fileinfo');
