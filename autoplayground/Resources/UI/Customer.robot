*** Settings ***
Library         SeleniumLibrary
Resource        ../../Resources/Locator/createCustomerPage.robot


*** Variables ***



*** Keywords ***
Go to and Verify Customer Page
    Wait until page contains Element       ${newCustBtn}      timeout=10
    Click Button    ${newCustBtn}  
    Wait until page contains Element       ${custPage}      timeout=10
    Sleep    2s

Create Customer
    [Arguments]     ${email}     ${first name}  ${last name}   ${city}   ${state}   ${gender}   ${promo}
    Input Text    ${emailInput2}    ${email}   
    Input Text    ${fnameInput}    ${first name} 
    Input Text    ${lnameInput}    ${last name} 
    Input Text    ${cityInput}    ${city} 
    Click Element    ${stateDDL}    #.//select[contains(@id,'StateOrRegion')]//option[contains(text(),'${state}')]   
    #Select From List By Label    .//select[contains(@id,'StateOrRegion')]//option[contains(text(),'${state}')]      ${state}
    Run Keyword If      ${gender} = 'F'     Click Button    ${femaleRadioBtn}
    Run Keyword If      ${gender} = 'M'     Click Button    ${maleRadioBtn}
    Run Keyword If      ${promo} = 'Y'     Click Element   ${promoChckBox}
    Sleep    2s

Submit and Verify Success Page
    Click Button    ${custSubmit} 
    Wait until page contains Element       ${SuccessMsg}       timeout=10
