*** Settings ***
Library         SeleniumLibrary
Library         DateTime
Resource        ../../Resources/Locator/loginPage.robot


*** Variables ***



*** Keywords ***
Verify Login Page
    Wait until page contains Element       ${emailInput}      timeout=10
    Sleep    2s

Login to Application
    [Arguments]     ${username}     ${password}
    Input Text    ${emailInput}    ${username}   
    Input Text    ${pwdInput}    ${password} 
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    #${pic}=    Set Variable   ${SAVE_PATH}/${module_name}[0]/LoginPage.png
    #Capture Page Screenshot    ${pic}
    Capture Screenshot      ${SAVE_PATH}/${module_name}[0]/LoginPage.png
    Click Button    ${rememberpwd}
    Click Button    ${submitBttn}    
    Sleep    2s

Verify Landing Page
    Wait until page contains Element       ${loginTxt}       timeout=10

Sign Out
     Wait until page contains Element       ${signOut}     timeout=10
     Click Link    ${signOut}
     ${pic}=    Set Variable   ${SAVE_PATH}/${module_name}[0]/SignOut.png
    Capture Page Screenshot    ${pic}

Sign In
     Wait until page contains Element       ${signIn}     timeout=10
     Click Link    ${signIn}
