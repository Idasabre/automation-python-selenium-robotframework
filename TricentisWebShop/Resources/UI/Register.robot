*** Settings ***
Library         SeleniumLibrary    
Library         DateTime
Resource        ../../Resources/Locator/landingPage.robot 
Resource        ../../Resources/Locator/registerPage.robot


*** Variables ***



*** Keywords ***
Go to Register Page
    Wait Until Element Is Visible   ${register}      timeout=10
    Sleep    2s
    Click Element    ${register}

Verify Register Page
    Wait until page contains Element       ${registerHeader}      timeout=10
    Sleep    2s

Register User
    [Arguments]     ${gender}      ${firstname}     ${lastname}      ${email}   ${password}
    
    Run Keyword If  '${gender}' == 'female'   Click Button    ${femaleRadioBtn}
    Run Keyword If  '${gender}' == 'male'     Click Button    ${maleRadioBtn}
    Input Text    ${firstnameTxt}   ${firstname}
    Input Text    ${lastnameTxt}   ${lastname}
    Input Text    ${emailTxt}     ${email}
    Input Text    ${passwordTxt}     ${password}
    Input Text    ${confirmPasswordTxt}     ${password}
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    Capture Screenshot      ${screenshot}/${module_name}[0]/RegisterPage.png    
    Click Button    ${RegisterBtn}    
    Sleep    2s
