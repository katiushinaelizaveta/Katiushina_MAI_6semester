% Загружаем таблицу, сохраняя исходные имена столбцов
data = readtable('курсач.xlsx', 'VariableNamingRule', 'preserve');

% Убираем текстовый столбец с названиями регионов
data_numeric = removevars(data, {'Region'});

% Создаём новую таблицу для числовых данных
data_double = table();

for i = 1:width(data_numeric)
    col = data_numeric{:, i};
    % Если столбец — ячейки
    if iscell(col)
        % Заменяем пробелы на пустоту и преобразуем в double
        col_clean = strrep(col, ' ', '');
        data_double{:, i} = str2double(col_clean);
    % Если столбец — строки
    elseif isstring(col)
        col_clean = strrep(col, ' ', '');
        data_double{:, i} = str2double(col_clean);
    % Если столбец уже числовой
    elseif isnumeric(col)
        data_double{:, i} = col;
    else
        % Прочие типы
        data_double{:, i} = str2double(string(col));
    end
end

% Присваиваем имена переменных
data_double.Properties.VariableNames = data_numeric.Properties.VariableNames;

% Удаляем строки с пропущенными значениями (NaN)
data_clean = rmmissing(data_double);

% Извлекаем числовую матрицу
X = data_clean{:,:};

% Проверяем, нет ли комплексных чисел
if ~isreal(X)
    X = real(X);
end

% Вычисляем корреляцию
R = corr(X);

% Визуализация
figure;
heatmap(data_clean.Properties.VariableNames, ...
        data_clean.Properties.VariableNames, R, ...
        'Colormap', parula, 'Title', 'Корреляционная матрица');

% Дополнительно выводим матрицу корреляции в командное окно
disp('Корреляционная матрица:');
disp(R);