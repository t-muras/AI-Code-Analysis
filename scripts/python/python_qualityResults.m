clear all;
lines_str = fileread('data/python/lineCount/pythonAlgorithmsLineCount.json');
lines = jsondecode(lines_str);
image_base_path = 'images/python_6_algorithms/quality/';
global SAVEPNG; % to enable saving of the images set SAVEPNG to 1
SAVEPNG = 0;

chatgpt_lines = [lines.chatGPT.BreadthFirstSearch;
    lines.chatGPT.BinarySearch;
    lines.chatGPT.BinaryToDecimal;
    lines.chatGPT.Knapsack;
    lines.chatGPT.MergeSort;
    lines.chatGPT.QuickSort;
];

copilot_lines = [lines.copilot.BreadthFirstSearch;
    lines.copilot.BinarySearch;
    lines.copilot.BinaryToDecimal;
    lines.copilot.Knapsack;
    lines.copilot.MergeSort;
    lines.copilot.QuickSort;
   ];

chatGptTotalLines = sum(chatgpt_lines);
copilotTotalLines = sum(copilot_lines);

% Count number of errors
json_str = fileread('data/python/pylint/convertedPylintReport.json');
data = jsondecode(json_str);

% Concatenate the arrays into a single array
chatgpt_data = [
                data.ChatGPT.BreadthFirstSearch;
                data.ChatGPT.BinarySearch;
                data.ChatGPT.BinaryToDecimal;
                data.ChatGPT.Knapsack;
                data.ChatGPT.MergeSort;
                data.ChatGPT.QuickSort;
                ];

copilot_data = [
                data.Copilot.BreadthFirstSearch;
                data.Copilot.BinarySearch;
                data.Copilot.BinaryToDecimal;
                data.Copilot.Knapsack;
                data.Copilot.MergeSort;
                data.Copilot.QuickSort;
                ];

chatGptErrorSum = sum(chatgpt_data);
copilotErrorSum = sum(copilot_data);

chatGptCorrectSum = chatGptTotalLines - chatGptErrorSum;
copilotCorrectSum = copilotTotalLines - copilotErrorSum;

% Display the sum of lines with and without errors
disp('ChatGPT')
disp(chatGptCorrectSum);
disp(chatGptErrorSum);

disp('Copilot')
disp(copilotCorrectSum);
disp(copilotErrorSum);

bar_data_absolute = [
                     chatGptCorrectSum, chatGptErrorSum;
                     copilotCorrectSum, copilotErrorSum;
                     ];

bar_data_perc = [
                 chatGptCorrectSum / chatGptTotalLines * 100, chatGptErrorSum / chatGptTotalLines * 100;
                 copilotCorrectSum / copilotTotalLines * 100, copilotErrorSum / copilotTotalLines * 100;
                 ];

bar_titles = {
              ' ChatGPT Code Quality'; ' Copilot Code Quality';
              };
bar_image_paths = {
                   'python_chatgpt_code_quality.png'; 'python_copilot_code_quality.png';
                   };
xlabels = {'ChatGPT', 'Copilot'};

bar_width = 0.8;
y_lim = bar_data_absolute(1, 1) + bar_data_absolute(1, 2) + 9;
% bar chart split by ai models - absolute correct and incorrect lines
n = size(bar_data_absolute, 1) / 2;
x1 = 1:n;
x2 = (n + 2):(n * 2 + 1);
x = [x1,x2];
figure;
h = bar(x, bar_data_absolute, bar_width, 'stacked');

% Set colors of stacked bars (Bottom: Green, Top: Red)
colors = ['#f2614b'; '#90ee90'];
edge_colors = ['#da2d10'; '#1fc71f'];
for j = 1:numel(h)
    set(h(j), 'FaceColor', colors(mod(j, 2) + 1, :), 'EdgeColor', edge_colors(mod(j, 2) + 1, :));
end

% Label percentages in the middle of the bars
for k = 1:numel(h)
    yData = h(k).YData;
    bar_limit = y_lim - 9;

    for j = 1:numel(yData)
        x_pos = x(j);

        if k == 2 && j == 2
            y = bar_limit - (yData(j) / 2) - 10;
        else 
            if k == 2
                y = bar_limit - (yData(j) / 2);
            else
                y = yData(j) / 2;
            end
        end
        text(x_pos, y, num2str(yData(j)), 'HorizontalAlignment', 'center');
    end
end

% Labels for the bars
set(gca, 'XTickLabel', xlabels);
% Change axis labels
ylabel('Line Count');
title('Python Code Quality');
ylim([0 y_lim]);
legends = legend('Correct', 'Incorrect', 'Location', 'northeast');
set(legends, 'FontSize', 8);
box off;
hold off;
if SAVEPNG
    saveas(gcf, strcat(image_base_path, 'python_code_quality_count.png'));
end

% PERCENTAGES
absolute = 0;
y_lim = 109;
% bar chart split by ai model - percentages
for i = 1:length(bar_data_perc)
    data = bar_data_perc(i, :);
    n = size(data, 1); % number of bars
    x = 1:n; % position of the bars
    build_stacked_bar_chart(data, x, 'northeast', y_lim, strcat('Python', bar_titles{i}), strcat(image_base_path, bar_image_paths{i}), bar_width, '%', xlabels(i), absolute);
end

% bar chart split by ai model - combined, percentages
n = size(bar_data_perc, 1) / 2;
x1 = 1:n;
x2 = (n + 2):(n * 2 + 1);
build_stacked_bar_chart(bar_data_perc, [x1, x2], 'northeast', y_lim, 'Python Code Quality', strcat(image_base_path, 'python_code_quality.png'), bar_width, '%', xlabels, absolute);

% Display how many occurrences of each count of error
copilot_unique_values = unique(copilot_data);

copilot_counts = histcounts(copilot_data, [
                                           copilot_unique_values', max(copilot_unique_values) + 1]);

chatgpt_unique_values = unique(chatgpt_data);

chatgpt_counts = histcounts(chatgpt_data, [
                                           chatgpt_unique_values', max(chatgpt_unique_values) + 1]);

figure;
h_copilot_raw = bar(copilot_unique_values, copilot_counts, 'FaceColor', '#add8e6', 'EdgeColor', '#add8e6');
xlabel('Number of quality errors');
ylabel('Count');
title('Python Copilot Quality Errors');
y_values_copilot_raw = h_copilot_raw.YData;
x_values_copilot_raw = h_copilot_raw.XData;

for i = 1:numel(y_values_copilot_raw)
    text(x_values_copilot_raw(i), y_values_copilot_raw(i), num2str(y_values_copilot_raw(i)), ...
        'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom')
end

ylim([0 200])
box off;
if SAVEPNG
    saveas(gcf, strcat(image_base_path, 'python_copilot_quality_errors_count.png'));
end

figure;
grid on;
h_chatgpt_raw = bar(chatgpt_unique_values, chatgpt_counts, 'FaceColor', '#add8e6', 'EdgeColor', '#add8e6');
xlabel('Number of quality errors');
ylabel('Count');
title('Python ChatGPT Quality Errors');
y_values_chatgpt_raw = h_chatgpt_raw.YData;
x_values_chatgpt_raw = h_chatgpt_raw.XData;

for i = 1:numel(y_values_chatgpt_raw)
    text(x_values_chatgpt_raw(i), y_values_chatgpt_raw(i), num2str(y_values_chatgpt_raw(i)), ...
        'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom')
end

ylim([0 200]);
box off;
if SAVEPNG
    saveas(gcf, strcat(image_base_path, 'python_chatgpt_quality_errors_count.png'));
end

figure;
h_copilot = bar(copilot_unique_values, copilot_counts / length(copilot_data) * 100, 'FaceColor', '#add8e6', 'EdgeColor', '#add8e6');
xlabel('Number of quality errors');
ylabel('%', 'Rotation', 0);
title('Python Copilot Quality Errors');
y_values_copilot = h_copilot.YData;
x_values_copilot = h_copilot.XData;

for i = 1:numel(y_values_copilot)
    text(x_values_copilot(i), y_values_copilot(i), num2str(y_values_copilot(i), '%.1f'), ...
        'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom')
end

ylim([0 45]);
box off;
if SAVEPNG
    saveas(gcf, strcat(image_base_path, 'python_copilot_quality_errors.png'));
end

figure;
h_chatgpt = bar(chatgpt_unique_values, chatgpt_counts / length(chatgpt_data) * 100, 'FaceColor', '#add8e6', 'EdgeColor', '#add8e6');
xlabel('Number of quality errors');
ylabel('%', 'Rotation', 0);
title('Python ChatGPT Quality Errors');
y_values = h_chatgpt.YData;
x_values = h_chatgpt.XData;

for i = 1:numel(y_values)
    text(x_values(i), y_values(i), num2str(y_values(i), '%.1f'), ...
        'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom')
end

ylim([0 45]);
box off;
if SAVEPNG
    saveas(gcf, strcat(image_base_path, 'python_chatgpt_quality_errors.png'));
end

% extract the first 5 x values from the datasets
num_points = 5;
copilot_indices = ismember(copilot_unique_values, chatgpt_unique_values(1:num_points));
x_values_copilot = copilot_unique_values(copilot_indices);
y_values_copilot = copilot_counts(copilot_indices) / length(copilot_data) * 100;
chatgpt_indices = ismember(chatgpt_unique_values, x_values(1:num_points));
x_values_chatgpt = chatgpt_unique_values(chatgpt_indices);
y_values_chatgpt = chatgpt_counts(chatgpt_indices) / length(chatgpt_data) * 100;

% plot the grouped bar chart with only the first 5 x values
figure;
bar_width = 0.35; % adjust this to change the width of each bar
h_copilot = bar(x_values_copilot - bar_width / 2, y_values_copilot, bar_width, 'FaceColor', '#add8e6', 'EdgeColor', '#add8e6');
hold on;
h_chatgpt = bar(x_values_chatgpt + bar_width / 2, y_values_chatgpt, bar_width, 'FaceColor', '#ff9999', 'EdgeColor', '#ff9999');
xlabel('Number of quality errors');
ylabel('%', 'Rotation', 0);
title('Python Quality Errors Comparison (first 5 entries)');
legend('Copilot', 'ChatGPT');
ylim([0 45]);
box off;

% add text labels to the bars
for i = 1:numel(y_values_copilot)
    text(x_values_copilot(i)-bar_width/2, y_values_copilot(i), num2str(y_values_copilot(i), '%.1f'), ...
        'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom')
end

for i = 1:numel(y_values_chatgpt)
    text(x_values_chatgpt(i)+bar_width/2, y_values_chatgpt(i), num2str(y_values_chatgpt(i), '%.1f'), ...
        'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom')
end

% set the x-axis limits to show only the first 5 x values
xlim([x_values_copilot(1) - bar_width / 2 - 0.5, x_values_copilot(end) + bar_width / 2 + 0.5]);


% set the x-axis ticks and labels to show only natural numbers
xticks(x_values_copilot);
xticklabels(0:length(x_values_copilot) - 1);
if SAVEPNG
    saveas(gcf, strcat(image_base_path, 'python_quality_errors_comparison.png'));
end

% Functions
function build_stacked_bar_chart(data, x, legend_loc, y_lim, bar_title, image_path, bar_width, y_label, x_labels, absolute)
    global SAVEPNG;
    figure;
    bar_style = 'stacked';
    h = bar(x, data, bar_width, bar_style);

    % Set colors of stacked bars (Bottom: Green, Top: Red)
    colors = ['#f2614b'; '#90ee90'];
    edge_colors = ['#da2d10'; '#1fc71f'];

    for j = 1:numel(h)
        set(h(j), 'FaceColor', colors(mod(j, 2) + 1, :), 'EdgeColor', edge_colors(mod(j, 2) + 1, :));
    end

    % Label percentages in the middle of the bars
    for k = 1:numel(h)
        yData = h(k).YData;
        bar_limit = y_lim - 9;

        for j = 1:numel(yData)
            x_pos = x(j);

            if k == 2
                y = bar_limit - (yData(j) / 2);
            else
                y = yData(j) / 2;
            end

            if absolute
                text(x_pos, y, num2str(yData(j)), 'HorizontalAlignment', 'center');
            else
                text(x_pos, y, num2str(yData(j), '%.2f%%'), 'HorizontalAlignment', 'center');
            end

        end

    end

    % Labels for the bars
    set(gca, 'XTickLabel', x_labels);

    % Change axis labels
    if absolute
        ylabel(y_label);
    else
        ylabel(y_label, 'Rotation', 0);
    end

    title(bar_title);
    ylim([0 y_lim]);

    legends = legend('Correct', 'Incorrect', 'Location', legend_loc);
    set(legends, 'FontSize', 8);

    box off;
    hold off;

    if SAVEPNG
        saveas(gcf, image_path);
    end

end
