*** Settings ***
Library         SeleniumLibrary   
Library         DateTime
Resource        ../../Resources/Locator/landingPage.robot 
Resource        ../../Resources/Locator/LoginPage.robot


*** Variables ***



*** Keywords ***
Go To Login page
    Wait Until Element Is Visible   ${login}      timeout=10
    Sleep    2s
    Click Element    ${login}

Verify Login Page
    Wait Until Element Is Visible   ${loginBtn}      timeout=10
    Sleep    2s

User Login 
    [Arguments]     ${email}          ${password}
    
    Input Text    ${emailTxt}     ${email}
    Input Text    ${passwordTxt}     ${password}
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    Capture Screenshot      ${screenshot}/${module_name}[1]/LoginPage.png 
    Click Element   ${loginBtn}
    Sleep   2s