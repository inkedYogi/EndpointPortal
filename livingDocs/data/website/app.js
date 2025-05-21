// app.js

// --- Configuration: This is your actual, confirmed data source URL ---
const LESSON_DATA_URL = 'https://inkedyogi.github.io/EndpointPortal/livingDocs/data/website/tga_lesson_content.json';
// --------------------------------------------------------------------

// --- DOM Elements ---
const contentContainer = document.getElementById('contentContainer');
const navContent = document.getElementById('nav-content');
const navToggle = document.getElementById('nav-toggle');
const lessonTitleElem = document.getElementById('lessonTitle');
const navLessonTitleElem = document.getElementById('navLessonTitle');
const loadingSpinner = document.getElementById('loading');

// --- Global State ---
let currentLessonData = null;
let completedSections = new Set(); // Stores IDs of completed sections

// --- Handlebars Setup ---
Handlebars.registerHelper('ifEquals', function(arg1, arg2, options) {
    return (arg1 == arg2) ? options.fn(this) : options.inverse(this);
});

const templates = {};
document.querySelectorAll('script[type="text/x-handlebars-template"]').forEach(templateScript => {
    const templateName = templateScript.id.replace('-template', '');
    templates[templateName] = Handlebars.compile(templateScript.innerHTML);
});

Handlebars.registerPartial('quizTemplate', templates['quizTemplate']);

// --- Core Lesson Loading & Rendering ---
async function fetchAndRenderLesson() {
    try {
        const response = await fetch(LESSON_DATA_URL);
        if (!response.ok) {
            console.error(`Failed to load lesson content. HTTP status: ${response.status}`);
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        currentLessonData = await response.json();

        // Update generic titles with loaded lesson title
        lessonTitleElem.textContent = currentLessonData.lessonTitle;
        navLessonTitleElem.textContent = currentLessonData.lessonTitle;

        // Load completed sections from localStorage
        const storedCompleted = localStorage.getItem('completedSections_' + currentLessonData.lessonId);
        if (storedCompleted) {
            completedSections = new Set(JSON.parse(storedCompleted));
        }

        renderLessonSections();
        loadingSpinner.classList.add('hidden'); // Hide loading spinner
    } catch (error) {
        console.error("Error loading lesson data:", error);
        contentContainer.innerHTML = `
            <div class="text-center py-20 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative" role="alert">
                <strong class="font-bold">Loading Failed!</strong>
                <span class="block sm:inline">Could not load lesson data. Please ensure the URL is correct and the file is accessible.</span>
                <p class="mt-2 text-sm">Error details: ${error.message}</p>
            </div>
        `;
        loadingSpinner.classList.add('hidden');
    }
}

function renderLessonSections() {
    contentContainer.innerHTML = ''; // Clear existing content
    navContent.innerHTML = ''; // Clear existing nav links

    let firstUncompletedRendered = false; // Flag to only show one uncompleted section

    currentLessonData.sections.forEach(section => {
        const isCompleted = completedSections.has(section.id);
        const isPrerequisiteMet = checkPrerequisites(section.prerequisites);

        // Render if completed OR if it's the first uncompleted section with met prerequisites
        const shouldRender = isCompleted || (!firstUncompletedRendered && isPrerequisiteMet);

        if (shouldRender) {
            const template = templates[section.type];
            if (template) {
                const sectionHtml = template(section);
                contentContainer.insertAdjacentHTML('beforeend', sectionHtml);

                // Add to navigation
                const navLink = document.createElement('a');
                navLink.href = `#${section.id}`;
                navLink.classList.add('nav-link', 'block', 'md:inline-block', 'hover:text-amber-400', 'border-b-2', 'border-transparent', 'pb-1');
                navLink.textContent = section.heading;
                navContent.appendChild(navLink);

                if (!isCompleted) {
                     // If this is the first uncompleted section, scroll to it
                    const renderedSectionElem = document.getElementById(section.id);
                    if (renderedSectionElem) {
                        renderedSectionElem.scrollIntoView({ behavior: 'smooth', block: 'start' });
                    }
                    firstUncompletedRendered = true; // Block further uncompleted sections from rendering
                }
            } else {
                console.warn(`No template found for section type: ${section.type}. Section ID: ${section.id}`);
            }
        } else {
            // Render a locked navigation link for unrendered sections
            const navLink = document.createElement('a');
            navLink.href = `#${section.id}`; // Still link to it for potential future unlocking
            navLink.classList.add('nav-link', 'block', 'md:inline-block', 'text-stone-400', 'cursor-not-allowed', 'pb-1');
            navLink.textContent = `🔒 ${section.heading}`;
            navContent.appendChild(navLink);
        }
    });

    // Re-render MathJax after content is in DOM
    if (typeof MathJax !== 'undefined') {
        MathJax.typesetPromise().then(() => {
            // console.log('MathJax typeset complete');
        }).catch(err => console.error('MathJax typesetting failed:', err));
    }

    // Re-bind event listeners for newly rendered elements
    setupEventListeners();
    changeActiveLink(); // Initial highlight for nav
}

function checkPrerequisites(prerequisites) {
    if (!prerequisites || prerequisites.length === 0) return true;
    return prerequisites.every(prereqId => completedSections.has(prereqId));
}

function markSectionCompleted(sectionId) {
    if (!completedSections.has(sectionId)) {
        completedSections.add(sectionId);
        localStorage.setItem('completedSections_' + currentLessonData.lessonId, JSON.stringify(Array.from(completedSections)));
        renderLessonSections(); // Re-render to show next section / update nav
    }
}

// --- Event Listeners Setup ---
function setupEventListeners() {
    // Crucially, remove old listeners to prevent duplicates on re-render
    document.querySelectorAll('.check-answer-btn').forEach(btn => btn.removeEventListener('click', handleQuizSubmit));
    document.querySelectorAll('.calculate-demo-btn').forEach(btn => btn.removeEventListener('click', handleDemoCalculation));
    document.querySelectorAll('.check-challenge-btn').forEach(btn => btn.removeEventListener('click', handleDemoChallenge));
    document.querySelectorAll('.llm-prompt-btn').forEach(btn => btn.removeEventListener('click', handleLLMPrompt));
    document.querySelectorAll('.llm-open-ask-btn').forEach(btn => btn.removeEventListener('click', handleLLMOpenAsk));
    document.querySelectorAll('.nav-link').forEach(link => link.removeEventListener('click', handleNavLinkClick));
    window.removeEventListener('scroll', changeActiveLink); // Only one scroll listener

    // Add new listeners
    document.querySelectorAll('.check-answer-btn').forEach(btn => {
        btn.addEventListener('click', handleQuizSubmit);
    });
    document.querySelectorAll('.calculate-demo-btn').forEach(btn => {
        btn.addEventListener('click', handleDemoCalculation);
    });
    document.querySelectorAll('.check-challenge-btn').forEach(btn => {
        btn.addEventListener('click', handleDemoChallenge);
    });
    document.querySelectorAll('.llm-prompt-btn').forEach(btn => {
        btn.addEventListener('click', handleLLMPrompt);
    });
    document.querySelectorAll('.llm-open-ask-btn').forEach(btn => {
        btn.addEventListener('click', handleLLMOpenAsk);
    });

    // Smooth scroll and active link highlighting (re-attaching ensures they work on dynamic links)
    document.querySelectorAll('.nav-link').forEach(link => {
        link.addEventListener('click', handleNavLinkClick);
    });
    window.addEventListener('scroll', changeActiveLink);
}

function handleNavLinkClick(e) {
    e.preventDefault();
    const targetId = this.getAttribute('href').substring(1);
    const targetSection = document.getElementById(targetId);
    if (targetSection) {
        targetSection.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }
    // Close mobile nav if open
    if (navToggle && navContent && !navContent.classList.contains('hidden') && window.innerWidth < 768) {
        navContent.classList.add('hidden');
    }
}

function changeActiveLink() {
    if (!currentLessonData) return; // Guard against no data loaded
    let index = currentLessonData.sections.length;
    // Iterate backwards to find the topmost visible section
    while(--index >= 0) {
        const sectionElement = document.getElementById(currentLessonData.sections[index].id);
        if (sectionElement && window.scrollY + 100 >= sectionElement.offsetTop) {
            break; // Found the active section
        }
    }

    document.querySelectorAll('.nav-link').forEach((link) => link.classList.remove('active'));
    if (currentLessonData.sections[index]) {
        const activeNavLink = navContent.querySelector(`a[href="#${currentLessonData.sections[index].id}"]`);
        if (activeNavLink) {
            activeNavLink.classList.add('active');
        }
    }
}

// --- Quiz Logic ---
function handleQuizSubmit(event) {
    const quizId = event.target.dataset.quizId;
    const section = currentLessonData.sections.find(s => s.id === quizId);
    const quizData = section.quiz;
    const feedbackElem = event.target.nextElementSibling; // div.feedback-message

    let isCorrect = false;

    if (quizData.type === 'multiple_choice') {
        const selectedOption = document.querySelector(`input[name="quiz-option-${quizId}"]:checked`);
        if (selectedOption) {
            isCorrect = quizData.options[parseInt(selectedOption.value)].isCorrect;
        }
    } else if (quizData.type === 'short_answer') {
        const answerText = document.getElementById(`shortAnswer-${quizId}`).value.toLowerCase().trim();
        if (quizData.correctKeywords && quizData.correctKeywords.some(keyword => answerText.includes(keyword.toLowerCase()))) {
            isCorrect = true;
        }
    }

    feedbackElem.classList.remove('hidden');
    if (isCorrect) {
        feedbackElem.classList.remove('bg-red-200', 'text-red-800');
        feedbackElem.classList.add('bg-green-200', 'text-green-800');
        feedbackElem.textContent = quizData.correctFeedback;
        markSectionCompleted(quizId);
    } else {
        feedbackElem.classList.remove('bg-green-200', 'text-green-800');
        feedbackElem.classList.add('bg-red-200', 'text-red-800');
        feedbackElem.textContent = quizData.incorrectFeedback + (quizData.hint ? ` Hint: ${quizData.hint}` : '');
    }
}

// --- Demo Logic ---
function handleDemoCalculation(event) {
    const sectionId = event.target.dataset.sectionId;
    const section = currentLessonData.sections.find(s => s.id === sectionId);
    const demoConfig = section.demoConfig;

    const inputValues = {};
    demoConfig.inputs.forEach(input => {
        const inputElem = document.getElementById(`${input.id}-${sectionId}`);
        if (inputElem && !input.ignoredInCalculation) {
            inputValues[input.id] = parseFloat(inputElem.value) || 0;
        }
    });

    let calculationResult = {};
    try {
        // Create a temporary function scope to run the script securely.
        // It injects input values as variables.
        const calculationFunction = new Function(...Object.keys(inputValues), demoConfig.calculationScript + ' return { conceptual_R_scalar, conceptual_S };');
        // NOTE: 'conceptual_R_scalar' and 'conceptual_S' must be defined in your JSON's calculationScript
        //       as `let conceptual_R_scalar = ...` for this return to work.
        calculationResult = calculationFunction(...Object.values(inputValues));
    } catch (e) {
        console.error(`Demo calculation error in section ${sectionId}:`, e);
        // Display an error message to the user in the demo output area
        const outputContainer = event.target.nextElementSibling; // The chart-container div
        if (outputContainer) {
            const errorP = document.createElement('p');
            errorP.classList.add('text-red-600', 'mt-4');
            errorP.textContent = 'Error in calculation. Please check console for details.';
            outputContainer.appendChild(errorP);
        }
        return; // Stop execution on error
    }

    demoConfig.outputs.forEach(output => {
        const outputElem = document.getElementById(`${output.id}-${sectionId}`);
        if (outputElem) {
            let value = calculationResult[output.valueKey];
            if (typeof value === 'number' && output.format === 'toFixed(6)') {
                value = value.toFixed(6);
            }
            outputElem.textContent = value;
        }
    });
}

function handleDemoChallenge(event) {
    const sectionId = event.target.dataset.sectionId;
    const section = currentLessonData.sections.find(s => s.id === sectionId);
    const demoConfig = section.demoConfig;
    const challenge = demoConfig.challenge;
    const feedbackElem = document.getElementById(`challenge-feedback-${sectionId}`);

    const targetOutputElem = document.getElementById(`${challenge.targetOutputId}-${sectionId}`);
    const currentOutputValue = parseFloat(targetOutputElem.textContent);

    feedbackElem.classList.remove('hidden');
    if (Math.abs(currentOutputValue - challenge.targetValue) < challenge.tolerance) {
        feedbackElem.classList.remove('bg-red-200', 'text-red-800');
        feedbackElem.classList.add('bg-green-200', 'text-green-800');
        feedbackElem.textContent = challenge.feedbackCorrect;
        markSectionCompleted(sectionId);
    } else {
        feedbackElem.classList.remove('bg-green-200', 'text-red-800'); // Ensure red is applied
        feedbackElem.classList.add('bg-red-200', 'text-red-800');
        feedbackElem.textContent = challenge.feedbackIncorrect;
    }
}

// --- LLM Logic (Placeholder for your backend API call) ---
async function callLLMAPI(prompt, sectionId) {
    const loadingElem = document.getElementById(`llm-loading-${sectionId}`);
    const responseContentElem = document.getElementById(`llm-response-content-${sectionId}`);

    loadingElem.classList.remove('hidden');
    responseContentElem.textContent = 'Thinking...'; // Clear previous response

    // This is a placeholder. In a real application, you would replace this
    // with a fetch call to YOUR OWN BACKEND API that then interacts with
    // a large language model (e.g., Gemini API key should never be exposed in frontend).
    const DUMMY_LLM_RESPONSE = new Promise(resolve => setTimeout(() => {
        resolve(`(LLM placeholder response for: "${prompt}"). This is a simulated AI answer. A real AI would provide a deeper explanation.`);
    }, 2500)); // Simulate API delay

    try {
        const response = await DUMMY_LLM_RESPONSE; // Replace with: await fetch('YOUR_BACKEND_LLM_ENDPOINT', { method: 'POST', body: JSON.stringify({ prompt: prompt }) });
        // const data = await response.json(); // If your backend returns JSON
        responseContentElem.textContent = response; // Adjust based on your backend's response structure
    } catch (error) {
        console.error("LLM API call failed:", error);
        responseContentElem.textContent = "Error: Could not get response from LLM. (Check your backend API)";
    } finally {
        loadingElem.classList.add('hidden');
    }
}

function handleLLMPrompt(event) {
    const sectionId = event.target.dataset.sectionId;
    const section = currentLessonData.sections.find(s => s.id === sectionId);
    if (section && section.llmPrompt) {
        callLLMAPI(section.llmPrompt, sectionId);
    }
}

function handleLLMOpenAsk(event) {
    const sectionId = event.target.dataset.sectionId;
    const questionTextarea = document.getElementById(`llm-open-question-${sectionId}`);
    if (questionTextarea && questionTextarea.value.trim() !== '') {
        callLLMAPI(questionTextarea.value.trim(), sectionId);
    }
}

// --- Navigation Toggle for Mobile ---
if (navToggle) {
    navToggle.addEventListener('click', () => {
        navContent.classList.toggle('hidden');
    });
}

// --- Initial Lesson Load on Page Load ---
fetchAndRenderLesson();
