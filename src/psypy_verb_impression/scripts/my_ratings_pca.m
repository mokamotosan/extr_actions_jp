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

%% データのプロット
figure('Name', 'Boxplot');
boxplot(ratings,'orientation','horizontal','labels',labels); 
view(0, 270); xlabel('Rating'); ylabel('Item');

%% ペアワイズ相関
C = corr(ratings,ratings, 'Rows', 'complete');
figure('Name', 'Pair-wise correlation');
imagesc(C); colorbar; xlabel('Item'); ylabel('Item');

%% 主成分の計算
[coeff,score,latent,~,explained] = pca(ratings);

%% 主成分係数をテーブルに保存
% pca: coeffのcolumn = eigenvector
% T_coeff = table(coeff(:,1), coeff(:,2), coeff(:,3), coeff(:,4), coeff(:,5), coeff(:,6), coeff(:,7), coeff(:,8), coeff(:,9), coeff(:,10), ...
%                     coeff(:,11), coeff(:,12), coeff(:,13), coeff(:,14), coeff(:,15), coeff(:,16), coeff(:,17), coeff(:,18), coeff(:,19), coeff(:,20), ...
%                     'RowNames', labels, ...
%                     'VariableNames', {'pc1', 'pc2', 'pc3', 'pc4', 'pc5', 'pc6', 'pc7', 'pc8', 'pc9', 'pc10', 'pc11', 'pc12', 'pc13', 'pc14', 'pc15', 'pc16', 'pc17', 'pc18', 'pc19', 'pc20'});
% % 主成分係数をエクセルに保存
% coeffTbl = table(coeff, 'RowNames', itemIDs); %coeff の列ごとに 1 つの主成分の係数: colume = eingenvector
% writetable(coeffTbl, fullfile(fpath, ['pca_results_' datestr(datetime, 'yyyymmddTHHMMSS') '.xlsx']), 'WriteRowNames', true);

%% 正規直交性の確認
I = coeff'*coeff;
I(1:3,1:3)

%% 固有値のスクリープロット
figure('Name', 'Screeplot of Eingenvalue');
subplot(1,2,1); title('Screeplot of Eigenvalues');
yyaxis left; bar(latent); ylim([0 sum(latent)]); ylabel('Eigenvalue'); 
yyaxis right; plot(cumsum(explained), 'o-'); ylim([0 100]); ylabel('cumsum %');
xlabel('PCs');

% Parallel analysisによる因子数の決定
subplot(1,2,2); pa_test2(ratings);

%% 成分の得点のプロット
figure()
plot(score(:,1),score(:,2),'+')
xlabel('1st Principal Component')
ylabel('2nd Principal Component')

%% 結果の可視化
figure()
biplot(coeff(:,1:2),'scores',score(:,1:2),'varlabels',labels);
%axis([-.26 0.6 -.51 .51]);

%% 三次元パイプロットの作成
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
