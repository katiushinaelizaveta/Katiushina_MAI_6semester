% Предполагаем, что целевой показатель называется 'Digital_index'
Y = data_clean.Digital_index;
% Все остальные столбцы — факторы
X = data_clean(:, 1:end-1);

% Строим линейную регрессию
  mdl = fitlm(X, Y);
% mdl_robust = fitlm(data_clean, 'Digital_index ~ High_education + ICT_invest + Urbanization + Cloud', 'RobustOpts', 'on');
% disp(mdl_robust)
% Выводим результаты
disp(mdl)
% plot(mdl)