// ==UserScript==
// @name         Force JetBrains Mono Monospace Font
// @namespace    http://tampermonkey.net/
// @version      1.0
// @description  Forces JetBrains Mono monospace font on all text elements
// @author       Your Name
// @match        *://*/*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    // First, try to load JetBrains Mono font from Google Fonts
    const fontLink = document.createElement('link');
    fontLink.rel = 'stylesheet';
    fontLink.href = 'https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;500;600;700&display=swap';
    document.head.appendChild(fontLink);

    // Create style element for our font rules
    const style = document.createElement('style');
    style.textContent = `
        /* Force JetBrains Mono on all text elements */
        * {
            font-family: 'JetBrains Mono', 'Consolas', 'Monaco', 'Menlo', 'Ubuntu Mono', monospace !important;
        }
        
        /* But preserve styling for buttons and form controls */
        button, 
        input, 
        textarea, 
        select,
        option,
        optgroup,
        .btn,
        [role="button"],
        [type="button"],
        [type="submit"],
        [type="reset"],
        [type="file"] {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, sans-serif !important;
        }
        
        /* Input placeholders should also use system font */
        ::placeholder {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, sans-serif !important;
        }
        
        /* Preserve icon fonts */
        .material-icons,
        .fa,
        .fas,
        .far,
        .fab,
        .glyphicon,
        .icon,
        [class*="icon-"] {
            font-family: inherit !important;
        }
        
        /* Code and pre elements should still use monospace */
        code,
        pre,
        kbd,
        samp,
        var {
            font-family: 'JetBrains Mono', 'Consolas', 'Monaco', 'Menlo', 'Ubuntu Mono', monospace !important;
        }
    `;
    
    document.head.appendChild(style);
    
    // Additional safety: listen for dynamically added content
    const observer = new MutationObserver(function(mutations) {
        mutations.forEach(function(mutation) {
            if (mutation.addedNodes.length) {
                // Re-apply styles to newly added elements
                mutation.addedNodes.forEach(function(node) {
                    if (node.nodeType === 1) { // Element node
                        applyFontStyles(node);
                    }
                });
            }
        });
    });
    
    observer.observe(document.body, {
        childList: true,
        subtree: true
    });
    
    function applyFontStyles(element) {
        // Skip if it's a button or form control
        const isFormControl = element.matches &&
            (element.matches('button, input, textarea, select, option, optgroup, .btn, [role="button"], [type="button"], [type="submit"], [type="reset"], [type="file"]') ||
             element.closest('button, input, textarea, select, .btn, [role="button"], [type="button"], [type="submit"], [type="reset"]'));
        
        const isIcon = element.matches &&
            element.matches('.material-icons, .fa, .fas, .far, .fab, .glyphicon, .icon, [class*="icon-"]');
        
        if (!isFormControl && !isIcon) {
            element.style.setProperty('font-family', "'JetBrains Mono', 'Consolas', 'Monaco', 'Menlo', 'Ubuntu Mono', monospace", 'important');
        }
    }
    
    // Initial application to all elements
    document.querySelectorAll('*').forEach(applyFontStyles);
    
    console.log('JetBrains Mono font forced successfully!');
})();
