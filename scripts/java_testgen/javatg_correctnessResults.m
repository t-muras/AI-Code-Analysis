clear all;
json_str = fileread('data/java_testgen/unitTests/tg_javaUnitTestReport.json');
data = jsondecode(json_str);
image_base_path = 'images/java_testgen/correctness/';
global SAVEPNG; % to enable saving of the images set SAVEPNG to 1
SAVEPNG = 0;

% Concatenate the arrays into a single array for each approach
% po = Prompt Only Generated Reference Code
% be = Book Example Reference Code
% ai = AI Generated Reference Code
chatgpt_po_data = [
    data.ChatGPT.QuickSort.PromptOnly;
    data.ChatGPT.BreadthFirstSearch.PromptOnly;
    data.ChatGPT.BinarySearch.PromptOnly;
    data.ChatGPT.BinaryToDecimal.PromptOnly;
    data.ChatGPT.Knapsack.PromptOnly;
    data.ChatGPT.MergeSort.PromptOnly;
    data.ChatGPT.Kruskal.PromptOnly;
    data.ChatGPT.BellmanFord.PromptOnly;
    data.ChatGPT.DepthFirstSearch.PromptOnly;
    data.ChatGPT.Dijkstra.PromptOnly;
    data.ChatGPT.EgyptianFractions.PromptOnly;
    data.ChatGPT.FloydWarshall.PromptOnly
    ];

copilot_po_data = [
    data.Copilot.QuickSort.PromptOnly;
    data.Copilot.BreadthFirstSearch.PromptOnly;
    data.Copilot.BinarySearch.PromptOnly;
    data.Copilot.BinaryToDecimal.PromptOnly;
    data.Copilot.Knapsack.PromptOnly;
    data.Copilot.MergeSort.PromptOnly;
    data.Copilot.Kruskal.PromptOnly;
    data.Copilot.BellmanFord.PromptOnly;
    data.Copilot.DepthFirstSearch.PromptOnly;
    data.Copilot.Dijkstra.PromptOnly;
    data.Copilot.EgyptianFractions.PromptOnly;
    data.Copilot.FloydWarshall.PromptOnly
    ];

chatgpt_be_data = [
    data.ChatGPT.QuickSort.BookExampleCode;
    data.ChatGPT.BreadthFirstSearch.BookExampleCode;
    data.ChatGPT.BinarySearch.BookExampleCode;
    data.ChatGPT.BinaryToDecimal.BookExampleCode;
    data.ChatGPT.Knapsack.BookExampleCode;
    data.ChatGPT.MergeSort.BookExampleCode;
    data.ChatGPT.Kruskal.BookExampleCode;
    data.ChatGPT.BellmanFord.BookExampleCode;
    data.ChatGPT.DepthFirstSearch.BookExampleCode;
    data.ChatGPT.Dijkstra.BookExampleCode;
    data.ChatGPT.EgyptianFractions.BookExampleCode;
    data.ChatGPT.FloydWarshall.BookExampleCode
    ];

copilot_be_data = [
    data.Copilot.QuickSort.BookExampleCode;
    data.Copilot.BreadthFirstSearch.BookExampleCode;
    data.Copilot.BinarySearch.BookExampleCode;
    data.Copilot.BinaryToDecimal.BookExampleCode;
    data.Copilot.Knapsack.BookExampleCode;
    data.Copilot.MergeSort.BookExampleCode;
    data.Copilot.Kruskal.BookExampleCode;
    data.Copilot.BellmanFord.BookExampleCode;
    data.Copilot.DepthFirstSearch.BookExampleCode;
    data.Copilot.Dijkstra.BookExampleCode;
    data.Copilot.EgyptianFractions.BookExampleCode;
    data.Copilot.FloydWarshall.BookExampleCode
    ];

chatgpt_ai_data = [
    data.ChatGPT.QuickSort.AIGenerated;
    data.ChatGPT.BreadthFirstSearch.AIGenerated;
    data.ChatGPT.BinarySearch.AIGenerated;
    data.ChatGPT.BinaryToDecimal.AIGenerated;
    data.ChatGPT.Knapsack.AIGenerated;
    data.ChatGPT.MergeSort.AIGenerated;
    data.ChatGPT.Kruskal.AIGenerated;
    data.ChatGPT.BellmanFord.AIGenerated;
    data.ChatGPT.DepthFirstSearch.AIGenerated;
    data.ChatGPT.Dijkstra.AIGenerated;
    data.ChatGPT.EgyptianFractions.AIGenerated;
    data.ChatGPT.FloydWarshall.AIGenerated
    ];

copilot_ai_data = [
    data.Copilot.QuickSort.AIGenerated;
    data.Copilot.BreadthFirstSearch.AIGenerated;
    data.Copilot.BinarySearch.AIGenerated;
    data.Copilot.BinaryToDecimal.AIGenerated;
    data.Copilot.Knapsack.AIGenerated;
    data.Copilot.MergeSort.AIGenerated;
    data.Copilot.Kruskal.AIGenerated;
    data.Copilot.BellmanFord.AIGenerated;
    data.Copilot.DepthFirstSearch.AIGenerated;
    data.Copilot.Dijkstra.AIGenerated;
    data.Copilot.EgyptianFractions.AIGenerated;
    data.Copilot.FloydWarshall.AIGenerated
    ];

all_data = [
    length(chatgpt_po_data);
    length(chatgpt_be_data);
    length(chatgpt_ai_data);
    length(copilot_po_data);
    length(copilot_be_data);
    length(copilot_ai_data);
    ];

chatGptBEErrorSum = sum(chatgpt_be_data);
copilotBEErrorSum = sum(copilot_be_data);
chatGptPOErrorSum = sum(chatgpt_po_data);
copilotPOErrorSum = sum(copilot_po_data);
chatGptAIErrorSum = sum(chatgpt_ai_data);
copilotAIErrorSum = sum(copilot_ai_data);

bar_data_absolute = [
    length(chatgpt_po_data) - chatGptPOErrorSum, chatGptPOErrorSum;
    length(chatgpt_be_data) - chatGptBEErrorSum, chatGptBEErrorSum;
    length(chatgpt_ai_data) - chatGptAIErrorSum, chatGptAIErrorSum;
    length(copilot_po_data) - copilotPOErrorSum, copilotPOErrorSum;
    length(copilot_be_data) - copilotBEErrorSum, copilotBEErrorSum;
    length(copilot_ai_data) - copilotAIErrorSum, copilotAIErrorSum;
];

bar_data_perc = zeros(6,2);
for i = 1:length(bar_data_absolute)
    for j = 1:length(bar_data_absolute(i))+1
        bar_data_perc(i, j) = bar_data_absolute(i, j) / all_data(i) * 100;
    end
end

bar_titles = {
              ' ChatGPT Test Correctness'; ''; ''; ' Copilot Test Correctness'; ''; '';
              };
bar_image_paths_abs = {
    'chatgpt_correctness_bar_split_abs.png'; ''; ''; 'copilot_correctness_bar_split_abs.png'; ''; ''; 
};
bar_width = 0.8;
y_lim = bar_data_absolute(1, 1) + bar_data_absolute(1, 2) + 9;
absolute = 1;
% bar chart split by approach and ai model - absolute numbers
for i = 1:3:length(bar_data_absolute)
    data = bar_data_absolute(i:i+2, :);
    n = size(data, 1); % number of bars
    x = 1:n; % position of the bars
    xlabels = {'PromptOnly', 'BookExampleCode', 'AIGenerated'};
    build_stacked_bar_chart(data, x, 'northeast', y_lim, strcat('Java', bar_titles{i}), strcat(image_base_path, bar_image_paths_abs{i}), bar_width, 'Generation count', xlabels, {}, absolute);
end

% bar chart split by approach - combined, absolute numbers
n = size(bar_data_absolute, 1) / 2;
x1 = 1:n;
x2 = (n + 2):(n * 2 + 1); 
labels = {'PromptOnly', 'BookExampleCode', 'AIGenerated', 'PromptOnly', 'BookExampleCode', 'AIGenerated'}; 
build_stacked_bar_chart(bar_data_absolute, [x1, x2], 'north', y_lim, 'Java Test Correctness', strcat(image_base_path,'correctness_bar_split_abs.png'), 0.9, 'Generation count', labels, {'ChatGPT', 'Copilot'}, absolute);


% PERCENTAGES
bar_image_paths = {
    'chatgpt_correctness_bar_split.png'; ''; ''; 'copilot_correctness_bar_split.png'; ''; ''; 
};
absolute = 0;
y_lim = 109;
% bar chart split by approach and ai model - percentages
for i = 1:3:length(bar_data_perc)
    data = bar_data_perc(i:i+2, :);
    n = size(data, 1); % number of bars
    x = 1:n; % position of the bars
    xlabels = {'PromptOnly', 'BookExampleCode', 'AIGenerated'};
    build_stacked_bar_chart(data, x, 'northeast', y_lim, strcat('Java', bar_titles{i}), strcat(image_base_path, bar_image_paths{i}), bar_width, '%', xlabels, {}, absolute);
end

% bar chart split by approach - combined, percentages
n = size(bar_data_perc, 1) / 2;
x1 = 1:n;
x2 = (n + 2):(n * 2 + 1); 
labels = {'PromptOnly', 'BookExampleCode', 'AIGenerated', 'PromptOnly', 'BookExampleCode', 'AIGenerated'}; 
build_stacked_bar_chart(bar_data_perc, [x1, x2], 'north', y_lim, 'Java Test Correctness', strcat(image_base_path,'correctness_bar_split.png'), 0.9, '%', labels, {'ChatGPT', 'Copilot'}, absolute);

% bar chart split by ai model
bar_data_full = [round(mean(bar_data_perc(1:3)),2); round(mean(bar_data_perc(4:6)),2);];
bar_titles_full = {' ChatGPT Test Correctness'; ' Copilot Test Correctness';};
bar_image_paths_full = {'chatgpt_correctness_bar.png'; 'copilot_correctness_bar.png';};
bar_ticklabels = {'ChatGPT', 'Copilot'};

for i = 1:numel(bar_data_full)
    data = [bar_data_full(i), (100 - bar_data_full(i));];
    n = size(data, 1);
    x = 1:n; 
    build_stacked_bar_chart(data, x, 'northeast', y_lim, strcat('Java', bar_titles_full{i}), strcat(image_base_path,bar_image_paths_full{i}), bar_width, '%', bar_ticklabels(i), {}, absolute);
end

% bar chart split by ai model - combined
data = [];
for i = 1:numel(bar_data_full) % concatenate the data for each approach
    data = [data; bar_data_full(i), (100 - bar_data_full(i));];
end
n = size(data, 1);
x = 1:n;  
build_stacked_bar_chart(data, x, 'northeast', y_lim, 'Java Test Correctness', strcat(image_base_path,'correctness_bar.png'), bar_width, '%', bar_ticklabels, {}, absolute);

% Functions
function build_stacked_bar_chart(data, x, legend_loc, y_lim,bar_title, image_path, bar_width, y_label, x_labels, groups, absolute)
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
    % add group labels
    n = size(data, 1) / 2;
    start = 1;
    limit = n;
    for g = 1:numel(groups)
        height = 106;
        if absolute
            height = 126;
        end
        text(mean(x(start:limit)), height, groups(g), 'HorizontalAlignment', 'center', 'FontSize', 11);
        start = start + n;
        limit = limit + n;
    end

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