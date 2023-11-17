clear all;
json_str = fileread('data/java_testgen/levenshtein/tg_javaLevenshteinReport.json');
data = jsondecode(json_str);
json_str = fileread('data/java_testgen/levenshtein/tg_javaCharCounts.json');
dataChars = jsondecode(json_str);
image_base_path = 'images/java_testgen/levenshtein/';
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


chatgpt_data = [chatgpt_ai_data; chatgpt_be_data; chatgpt_po_data];
copilot_data = [copilot_ai_data; copilot_be_data; copilot_po_data];

chatgpt_chars_ai = [
    dataChars.ChatGPT.QuickSort.AIGenerated;
    dataChars.ChatGPT.BreadthFirstSearch.AIGenerated;
    dataChars.ChatGPT.BinarySearch.AIGenerated;
    dataChars.ChatGPT.BinaryToDecimal.AIGenerated;
    dataChars.ChatGPT.Knapsack.AIGenerated;
    dataChars.ChatGPT.MergeSort.AIGenerated;
    dataChars.ChatGPT.Kruskal.AIGenerated;
    dataChars.ChatGPT.BellmanFord.AIGenerated;
    dataChars.ChatGPT.DepthFirstSearch.AIGenerated;
    dataChars.ChatGPT.Dijkstra.AIGenerated;
    dataChars.ChatGPT.EgyptianFractions.AIGenerated;
    dataChars.ChatGPT.FloydWarshall.AIGenerated
];

chatgpt_chars_po = [
    dataChars.ChatGPT.QuickSort.PromptOnly;
    dataChars.ChatGPT.BreadthFirstSearch.PromptOnly;
    dataChars.ChatGPT.BinarySearch.PromptOnly;
    dataChars.ChatGPT.BinaryToDecimal.PromptOnly;
    dataChars.ChatGPT.Knapsack.PromptOnly;
    dataChars.ChatGPT.MergeSort.PromptOnly;
    dataChars.ChatGPT.Kruskal.PromptOnly;
    dataChars.ChatGPT.BellmanFord.PromptOnly;
    dataChars.ChatGPT.DepthFirstSearch.PromptOnly;
    dataChars.ChatGPT.Dijkstra.PromptOnly;
    dataChars.ChatGPT.EgyptianFractions.PromptOnly;
    dataChars.ChatGPT.FloydWarshall.PromptOnly
];

chatgpt_chars_be = [
    dataChars.ChatGPT.QuickSort.BookExampleCode;
    dataChars.ChatGPT.BreadthFirstSearch.BookExampleCode;
    dataChars.ChatGPT.BinarySearch.BookExampleCode;
    dataChars.ChatGPT.BinaryToDecimal.BookExampleCode;
    dataChars.ChatGPT.Knapsack.BookExampleCode;
    dataChars.ChatGPT.MergeSort.BookExampleCode;
    dataChars.ChatGPT.Kruskal.BookExampleCode;
    dataChars.ChatGPT.BellmanFord.BookExampleCode;
    dataChars.ChatGPT.DepthFirstSearch.BookExampleCode;
    dataChars.ChatGPT.Dijkstra.BookExampleCode;
    dataChars.ChatGPT.EgyptianFractions.BookExampleCode;
    dataChars.ChatGPT.FloydWarshall.BookExampleCode;
];

copilot_chars_ai = [
    dataChars.Copilot.QuickSort.AIGenerated;
    dataChars.Copilot.BreadthFirstSearch.AIGenerated;
    dataChars.Copilot.BinarySearch.AIGenerated;
    dataChars.Copilot.BinaryToDecimal.AIGenerated;
    dataChars.Copilot.Knapsack.AIGenerated;
    dataChars.Copilot.MergeSort.AIGenerated;
    dataChars.Copilot.Kruskal.AIGenerated;
    dataChars.Copilot.BellmanFord.AIGenerated;
    dataChars.Copilot.DepthFirstSearch.AIGenerated;
    dataChars.Copilot.Dijkstra.AIGenerated;
    dataChars.Copilot.EgyptianFractions.AIGenerated;
    dataChars.Copilot.FloydWarshall.AIGenerated
];

copilot_chars_be = [
    dataChars.Copilot.QuickSort.BookExampleCode;
    dataChars.Copilot.BreadthFirstSearch.BookExampleCode;
    dataChars.Copilot.BinarySearch.BookExampleCode;
    dataChars.Copilot.BinaryToDecimal.BookExampleCode;
    dataChars.Copilot.Knapsack.BookExampleCode;
    dataChars.Copilot.MergeSort.BookExampleCode;
    dataChars.Copilot.Kruskal.BookExampleCode;
    dataChars.Copilot.BellmanFord.BookExampleCode;
    dataChars.Copilot.DepthFirstSearch.BookExampleCode;
    dataChars.Copilot.Dijkstra.BookExampleCode;
    dataChars.Copilot.EgyptianFractions.BookExampleCode;
    dataChars.Copilot.FloydWarshall.BookExampleCode
];

copilot_chars_po = [
    dataChars.Copilot.QuickSort.PromptOnly;
    dataChars.Copilot.BreadthFirstSearch.PromptOnly;
    dataChars.Copilot.BinarySearch.PromptOnly;
    dataChars.Copilot.BinaryToDecimal.PromptOnly;
    dataChars.Copilot.Knapsack.PromptOnly;
    dataChars.Copilot.MergeSort.PromptOnly;
    dataChars.Copilot.Kruskal.PromptOnly;
    dataChars.Copilot.BellmanFord.PromptOnly;
    dataChars.Copilot.DepthFirstSearch.PromptOnly;
    dataChars.Copilot.Dijkstra.PromptOnly;
    dataChars.Copilot.EgyptianFractions.PromptOnly;
    dataChars.Copilot.FloydWarshall.PromptOnly
];

% Histograms

hist_data = {chatgpt_po_data; copilot_po_data; chatgpt_be_data; copilot_be_data; chatgpt_ai_data; copilot_ai_data};
hist_data_full = {chatgpt_data; copilot_data};

hist_titles = {
    ' ChatGPT Levenshtein Distance - Prompt Only'; ' Copilot Levenshtein Distance - Prompt Only'; 
    ' ChatGPTLevenshtein Distance - Book Example Code'; ' Copilot Levenshtein Distance - Book Example Code';
    ' ChatGPT Levenshtein Distance - AI Generated'; ' Copilot Levenshtein Distance - AI Generated';
    };
hist_titles_full = {' ChatGPT Levenshtein Distance'; ' Copilot Levenshtein Distance';};

hist_image_paths = {
    'chatgpt_ld_po.png'; 'copilot_ld_po.png'; 'chatgpt_ld_be.png'; 'copilot_ld_be.png'; 'chatgpt_ld_ai.png'; 'copilot_ld_ai.png';
};
hist_image_paths_full = {'chatgpt_ld.png'; 'copilot_ld.png';};

for i = 1:numel(hist_data)
    interval_start = 0;
    step_size = 5;
    lower_edge = 50;
    upper_edge = 90;
    % If the calculation of the upper end is smaller than 20, it should be 20
    interval_end = max(lower_edge,(max(hist_data{i}) + mod(max(hist_data{i}), step_size) - 1));
    edges = interval_start:step_size:min(interval_end, upper_edge); 
    figure;
    counts = histcounts(hist_data{i}, edges);
    histogram(hist_data{i}, 'BinEdges', edges);
    title(strcat('Java',hist_titles{i}))
    xlabel('Levenshtein Distance')
    xticks(edges)
    ylabel('Generation count')
    ylim([0 max(counts) + 9]);
    yticks(0:10:max(counts) + 2);
    hold on;
    for j = 1:numel(counts)
        text(edges(j) + step_size / 2, counts(j), num2str(counts(j)), ...
            'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
    end
    hold off;
    if SAVEPNG
        saveas(gcf, strcat(image_base_path,'histograms/',hist_image_paths{i}));
    end
end


for i = 1:numel(hist_data_full)
    interval_start = 0;
    step_size = 5;
    lower_edge = 50;
    upper_edge = 90;
    interval_end = max(lower_edge,(max(hist_data_full{i}) + mod(max(hist_data_full{i}), step_size) - 1));
    edges = interval_start:step_size:min(interval_end, upper_edge);  
    figure;
    counts = histcounts(hist_data_full{i}, edges);
    histogram(hist_data_full{i}, 'BinEdges', edges);
    title(strcat('Java',hist_titles_full{i}))
    xlabel('Levenshtein Distance')
    xticks(edges)
    ylabel('Generation count')
    ylim([0 max(counts) + 24]);
    yticks(0:25:max(counts) + 2);
    hold on;
    for j = 1:numel(counts)
        text(edges(j) + step_size / 2, counts(j), num2str(counts(j)), ...
            'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
    end
    hold off;
    if SAVEPNG
        saveas(gcf, strcat(image_base_path,'histograms/',hist_image_paths_full{i}));
    end
end

% Bar charts
chatgpt_total_chars_ai = sum(chatgpt_chars_ai);
chatgpt_total_chars_be = sum(chatgpt_chars_be);
chatgpt_total_chars_po = sum(chatgpt_chars_po);

chatgpt_total_levenshtein_ai = sum(chatgpt_ai_data);
chatgpt_total_levenshtein_be = sum(chatgpt_be_data);
chatgpt_total_levenshtein_po = sum(chatgpt_po_data);

copilot_total_chars_ai = sum(copilot_chars_ai); 
copilot_total_chars_be = sum(copilot_chars_be);
copilot_total_chars_po = sum(copilot_chars_po);

copilot_total_levenshtein_ai = sum(copilot_ai_data);
copilot_total_levenshtein_be = sum(copilot_be_data);
copilot_total_levenshtein_po = sum(copilot_po_data);

chatgpt_chars = [chatgpt_chars_ai; chatgpt_chars_be; chatgpt_chars_po];
copilot_chars = [copilot_chars_ai; copilot_chars_be; copilot_chars_po];
chatgpt_total_chars = sum(chatgpt_chars);
copilot_total_chars = sum(copilot_chars);

chatgpt_total_levenshtein = sum(chatgpt_data);
copilot_total_levenshtein = sum(copilot_data);

bar_data = [
    chatgpt_total_levenshtein_po / chatgpt_total_chars_po * 100; 
    chatgpt_total_levenshtein_be / chatgpt_total_chars_be * 100; 
    chatgpt_total_levenshtein_ai / chatgpt_total_chars_ai * 100;
    copilot_total_levenshtein_po / copilot_total_chars_po * 100; 
    copilot_total_levenshtein_be / copilot_total_chars_be * 100; 
    copilot_total_levenshtein_ai / copilot_total_chars_ai * 100;
];

bar_titles = {
    ' ChatGPT Modified Test Code'; ''; ''; ' Copilot Modified Test Code'; ''; ''; 
    };

bar_image_paths = {
    'chatgpt_modCode_bar_split.png'; ''; ''; 'copilot_modCode_bar_split.png'; ''; '';
};

bar_width = 0.8;
% bar chart split by approach and ai model
for i = 1:3:numel(bar_data)
    data = [(100 - bar_data(i)), bar_data(i); (100 - bar_data(i + 1)), bar_data(i + 1); (100 - bar_data(i + 2)),  bar_data(i + 2)];
    n = size(data, 1); % number of bars
    x = 1:n; % position of the bars
    xlabels = {'PromptOnly', 'BookExampleCode', 'AIGenerated'};
    build_stacked_bar_chart(data, x, 'southeast', strcat('Java', bar_titles{i}), strcat(image_base_path,'bar_charts/', bar_image_paths{i}), bar_width, '%', xlabels, {});
end

% bar chart split by approach - combined
data = [];
for i = 1:3:numel(bar_data) % concatenate the data for each approach
    data = [data; (100 - bar_data(i)), bar_data(i); (100 - bar_data(i + 1)), bar_data(i + 1); (100 - bar_data(i + 2)),  bar_data(i + 2)];
end
n = size(data, 1) / 2;
x1 = 1:n;
x2 = (n + 2):(n * 2 + 1); 
labels = {'PromptOnly', 'BookExampleCode', 'AIGenerated', 'PromptOnly', 'BookExampleCode', 'AIGenerated'}; 
build_stacked_bar_chart(data, [x1, x2], 'southeast', 'Java Modified Test Code', strcat(image_base_path,'bar_charts/','java_modCode_all.png'), 0.9, '%', labels, {'ChatGPT', 'Copilot'});


% bar chart split by ai model
bar_data_full = [
    chatgpt_total_levenshtein / chatgpt_total_chars * 100;
    copilot_total_levenshtein / copilot_total_chars * 100;
];
bar_titles_full = {' ChatGPT Modified Test Code'; ' Copilot Modified Test Code';};
bar_image_paths_full = {'chatgpt_modCode_bar.png'; 'copilot_modCode_bar.png';};
bar_xlabels_full = {'ChatGPT'; 'Copilot';};

for i = 1:numel(bar_data_full)
    data = [(100 - bar_data_full(i)), bar_data_full(i);];
    n = size(data, 1);
    x = 1:n; 
    build_stacked_bar_chart(data, x, 'southeast', strcat('Java', bar_titles_full{i}), strcat(image_base_path,'bar_charts/',bar_image_paths_full{i}), bar_width, '%', bar_xlabels_full(i), {});
end

% bar chart split by ai model - combined
data = [];
for i = 1:numel(bar_data_full) % concatenate the data for each approach
    data = [data;(100 - bar_data_full(i)), bar_data_full(i);];
end
n = size(data, 1);
x = 1:n; 
build_stacked_bar_chart(data, x, 'southeast','Java Modified Test Code', strcat(image_base_path,'bar_charts/','modCode_bar.png'), bar_width, '%', bar_xlabels_full, {});

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

    legends =  legend('Not Modified', 'Modified', 'Location', legend_loc);
    set(legends, 'FontSize', 8);
    
    box off;
    hold off;
    if SAVEPNG
        saveas(gcf, image_path);
    end
end