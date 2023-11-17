// script to join the results of the python unit tests and the pylint results for all algorithms
const fs = require('fs');

// Path to json Files
const correctnessResults = './data/python/unitTests/pythonUnitTestReport.json';
const qualityResults = './data/python/pylint/convertedPylintReport.json';
const outputFileName = './data/python/allPythonResults.json';

function extractArraysFromJSON(obj, result = []) {
  if (Array.isArray(obj)) {
    result.push(...obj);
  } else if (typeof obj === 'object') {
    for (const key in obj) {
      if (obj.hasOwnProperty(key)) {
        extractArraysFromJSON(obj[key], result);
      }
    }
  }
  return result;
}

const rawDataCorrectness = fs.readFileSync(correctnessResults);
const rawDataQuality = fs.readFileSync(qualityResults);
const dataCorrectness = JSON.parse(rawDataCorrectness);
const dataQuality = JSON.parse(rawDataQuality);

const copilotCorrectness = dataCorrectness['Copilot'];
const copilotCorrectnessCombined = extractArraysFromJSON(copilotCorrectness);
const copilotQuality = dataQuality['Copilot'];
const copilotQualityCombined = extractArraysFromJSON(copilotQuality);

const chatGPTCorrectness = dataCorrectness['ChatGPT'];
const chatGPTCorrectnessCombined = extractArraysFromJSON(chatGPTCorrectness);
const chatGPTQuality = dataQuality['ChatGPT'];
const chatGPTQualityCombined = extractArraysFromJSON(chatGPTQuality);

const outputData = {
  "Code Correctness": {
    ChatGPT: chatGPTCorrectnessCombined,
    Copilot: copilotCorrectnessCombined
  },
  "Code Quality": {
    ChatGPT: chatGPTQualityCombined,
    Copilot: copilotQualityCombined
  }
};

fs.writeFileSync(outputFileName, JSON.stringify(outputData, null, 0));
console.log(`Joined results array can be found in '${outputFileName}'.`);
