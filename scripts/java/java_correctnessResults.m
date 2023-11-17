json_str = fileread('data/java/unitTests/javaUnitTestReport.json');
data = jsondecode(json_str);
image_base_path = 'images/java_6_algorithms/correctness/';
global SAVEPNG; % to enable saving of the images set SAVEPNG to 1
SAVEPNG = 0;

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
all_data = [
    length(chatgpt_data);
    length(copilot_data);
];
bar_data_absolute = [
    length(chatgpt_data) - chatGptErrorSum, chatGptErrorSum;
    length(copilot_data) - copilotErrorSum, copilotErrorSum;
];

bar_data_perc = zeros(2,2);
for i = 1:length(bar_data_absolute)
    for j = 1:length(bar_data_absolute(i))+1
        bar_data_perc(i, j) = bar_data_absolute(i, j) / all_data(i) * 100;
    end
end
bar_titles = {
              ' ChatGPT Code Correctness'; ' Copilot Code Correctness';
              };
bar_image_paths_abs = {
    'java_chatgpt_code_correctness_count.png'; 'java_copilot_code_correctness_count.png'; 
};
xlabels = {'ChatGPT', 'Copilot'};

bar_width = 0.8;
y_lim = bar_data_absolute(1, 1) + bar_data_absolute(1, 2) + 9;
absolute = 1;
% bar chart split ai model - absolute numbers
for i = 1:length(bar_data_absolute)
    data = bar_data_absolute(i, :);
    n = size(data, 1); % number of bars
    x = 1:n; % position of the bars
    build_stacked_bar_chart(data, x, 'northeast', y_lim, strcat('Java', bar_titles{i}), strcat(image_base_path, bar_image_paths_abs{i}), bar_width, 'Generation count', xlabels(i), absolute);
end

% bar chart split by ai model combined, absolute numbers
n = size(bar_data_absolute, 1) / 2;
x1 = 1:n;
x2 = (n + 2):(n * 2 + 1);  
build_stacked_bar_chart(bar_data_absolute, [x1, x2], 'northeast', y_lim, 'Java Code Correctness', strcat(image_base_path,'java_code_correctness_count.png'), bar_width, 'Generation count', xlabels, absolute);

% PERCENTAGES
bar_image_paths = {
    'java_chatgpt_code_correctness.png'; 'java_copilot_code_correctness.png'; 
};
absolute = 0;
y_lim = 109;
% bar chart split by ai model - percentages
for i = 1:length(bar_data_perc)
    data = bar_data_perc(i, :);
    n = size(data, 1); % number of bars
    x = 1:n; % position of the bars
    build_stacked_bar_chart(data, x, 'northeast', y_lim, strcat('Java', bar_titles{i}), strcat(image_base_path, bar_image_paths{i}), bar_width, '%', xlabels(i), absolute);
end

% bar chart split by ai model - combined, percentages
n = size(bar_data_perc, 1) / 2;
x1 = 1:n;
x2 = (n + 2):(n * 2 + 1);  
build_stacked_bar_chart(bar_data_perc, [x1, x2], 'northeast', y_lim, 'Java Code Correctness', strcat(image_base_path,'java_code_correctness.png'), bar_width, '%', xlabels, absolute);

% Functions
function build_stacked_bar_chart(data, x, legend_loc, y_lim,bar_title, image_path, bar_width, y_label, x_labels, absolute)
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

    legends =  legend('Correct', 'Incorrect', 'Location', legend_loc);
    set(legends, 'FontSize', 8);
    
    box off;
    hold off;
    if SAVEPNG
        saveas(gcf, image_path);
    end
end