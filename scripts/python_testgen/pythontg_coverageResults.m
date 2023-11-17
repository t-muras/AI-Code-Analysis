clear all;
json_str = fileread('data/python_testgen/coverage/tg_pyConvertedCoverageReport.json');
data = jsondecode(json_str);
image_base_path = 'images/python_testgen/coverage/';
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

chatgpt_data = [chatgpt_po_data; chatgpt_be_data; chatgpt_ai_data];
copilot_data = [copilot_po_data; copilot_be_data; copilot_ai_data];

hist_data = {
    chatgpt_po_data; copilot_po_data; chatgpt_be_data; 
    copilot_be_data; chatgpt_ai_data; copilot_ai_data; 
    };

hist_data_full = { chatgpt_data; copilot_data;};

% Histograms
hist_titles = {
    ' ChatGPT Test Coverage - Prompt Only'; ' Copilot Test Coverage - Prompt Only';
    ' ChatGPT Test Coverage - Book Example Code'; ' Copilot Test Coverage - Book Example Code';
    ' ChatGPT Test Coverage - AI Generated'; ' Copilot Test Coverage - AI Generated'; 
    };

hist_titles_full = {' ChatGPT Test Coverage'; ' Copilot Test Coverage';};

hist_image_paths = {
    'chatgpt_cov_po.png'; 'copilot_cov_po.png'; 'chatgpt_cov_be.png'; 
    'copilot_cov_be.png'; 'chatgpt_cov_ai.png'; 'copilot_cov_ai.png';
};

hist_image_paths_full = {'chatgpt_cov.png'; 'copilot_cov.png';};

intervalStart = 0;
intervallEnd = 100;
stepSize = 5;
edges = intervalStart:stepSize:intervallEnd;    

for i = 1:numel(hist_data)
    figure;
    counts = histcounts(hist_data{i}, edges);
    histogram(hist_data{i}, 'BinEdges', edges);
    title(strcat('Python',hist_titles{i}))
    xlabel('Coverage in %')
    xticks(edges)
    ylabel('Generation count')
    ylim([0 max(counts) + 5]);
    yticks(0:5:max(counts) + 2);
    hold on;
    for j = 1:numel(counts)
        text(edges(j) + stepSize / 2, counts(j), num2str(counts(j)), ...
            'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
    end
    hold off;
    if SAVEPNG
        saveas(gcf, strcat(image_base_path,'histograms/',hist_image_paths{i}));
    end
end

for i = 1:numel(hist_data_full)
    figure;
    counts = histcounts(hist_data_full{i}, edges);
    histogram(hist_data_full{i}, 'BinEdges', edges);
    title(strcat('Python ',hist_titles_full{i}))
    xlabel('Coverage in %')
    xticks(edges)
    ylabel('Generation count')
    ylim([0 max(counts) +  19]);
    yticks(0:20:max(counts) + 19);
    hold on;
    for j = 1:numel(counts)
        text(edges(j) + stepSize / 2, counts(j), num2str(counts(j)), ...
            'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
    end
    hold off;
    if SAVEPNG
        saveas(gcf, strcat(image_base_path,'histograms/',hist_image_paths_full{i}));
    end
end

% Bar charts
bar_data = [
    round(mean(chatgpt_po_data),2); round(mean(chatgpt_be_data),2); 
    round(mean(chatgpt_ai_data),2); round(mean(copilot_po_data),2); 
    round(mean(copilot_be_data),2); round(mean(copilot_ai_data),2);
];

bar_titles = {
    ' ChatGPT Test Coverage'; ''; ''; ' Copilot Test Coverage'; ''; ''; 
    };

bar_image_paths = {
    'chatgpt_cov_bar_split.png'; ''; ''; 'copilot_cov_bar_split.png'; ''; '';
};

bar_width = 0.8;
% coverage bar chart split by approach and ai model
for i = 1:3:numel(bar_data)
    data = [bar_data(i), (100 - bar_data(i)); bar_data(i + 1), (100 - bar_data(i + 1)); bar_data(i + 2), (100 - bar_data(i + 2))];
    n = size(data, 1); % number of bars
    x = 1:n; % position of the bars
    xlabels = {'PromptOnly', 'BookExampleCode', 'AIGenerated'};
    build_stacked_bar_chart(data, x, 'southeast', strcat('Python', bar_titles{i}), strcat(image_base_path,'bar_charts/',bar_image_paths{i}), bar_width, '%', xlabels, {});
end

% coverage bar chart split by approach - combined
data = [];
for i = 1:3:numel(bar_data) % concatenate the data for each approach
    data = [data; bar_data(i), (100 - bar_data(i)); bar_data(i + 1), (100 - bar_data(i + 1)); bar_data(i + 2), (100 - bar_data(i + 2))];
end
n = size(data, 1) / 2;
x1 = 1:n;
x2 = (n + 2):(n * 2 + 1); 
labels = {'PromptOnly', 'BookExampleCode', 'AIGenerated', 'PromptOnly', 'BookExampleCode', 'AIGenerated'}; 
build_stacked_bar_chart(data, [x1, x2], 'southeast', 'Python Test Coverage', strcat(image_base_path,'bar_charts/','python_cov_all.png'), 0.9, '%', labels, {'ChatGPT', 'Copilot'});


% coverage bar chart split by ai model
bar_data_full = [round(mean(chatgpt_data),2); round(mean(copilot_data),2);];
bar_titles_full = {' ChatGPT Test Coverage'; ' Copilot Test Coverage';};
bar_image_paths_full = {'chatgpt_cov_bar.png'; 'copilot_cov_bar.png';};
bar_ticklabels = {'ChatGPT', 'Copilot'};

for i = 1:numel(bar_data_full)
    data = [bar_data_full(i), (100 - bar_data_full(i));];
    n = size(data, 1);
    x = 1:n; 
    build_stacked_bar_chart(data, x, 'northeast', strcat('Python', bar_titles_full{i}), strcat(image_base_path,'bar_charts/',bar_image_paths_full{i}), bar_width, '%', bar_ticklabels(i), {});
end

% coverage bar chart split by ai model - combined
data = [];
for i = 1:numel(bar_data_full) % concatenate the data for each approach
    data = [data; bar_data_full(i), (100 - bar_data_full(i));];
end
n = size(data, 1);
x = 1:n; 
build_stacked_bar_chart(data, x, 'northeast','Python Test Coverage', strcat(image_base_path,'bar_charts/','cov_bar.png'), bar_width, '%', bar_ticklabels, {});

% Functions
function build_stacked_bar_chart(data, x, legend_loc, bar_title, image_path, bar_width, y_label, x_labels, groups)
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
        for j = 1:numel(yData)
            x_pos = x(j); 
            if k == 2
                y = 100 - (yData(j) / 2);
            else
                y = yData(j) / 2;
            end
            text(x_pos, y, sprintf('%.2f%%', yData(j)), 'HorizontalAlignment', 'center');
        end
    end

    % Labels for the bars
    set(gca, 'XTickLabel', x_labels);
    % add group labels
    n = size(data, 1) / 2;
    start = 1;
    limit = n;
    for g = 1:numel(groups)
        text(mean(x(start:limit)), 106, groups(g), 'HorizontalAlignment', 'center', 'FontSize', 11);
        start = start + n;
        limit = limit + n;
    end

    % Change axis labels
    ylabel(y_label, 'Rotation', 0); % y-axis label
    title(bar_title);
    ylim([0 109]);

    legends =  legend('Covered', 'Not Covered', 'Location', legend_loc);
    set(legends, 'FontSize', 8);
    
    box off;
    hold off;
    if SAVEPNG
        saveas(gcf, image_path);
    end
end