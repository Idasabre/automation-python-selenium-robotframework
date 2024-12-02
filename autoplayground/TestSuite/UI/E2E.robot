*** Settings ***
Documentation     Login read data from Excel Scenario
Library           SeleniumLibrary
Library           DateTime
Resource          ../../Resources/Common/Common.robot
Resource          ../../Resources/Common/variables.robot
Resource          ../../Resources/UI/Login.robot
Resource          ../../Resources/UI/Customer.robot
Library           ../../Lib/UI/autopg.py
Begin Web Test
End Web Test

#Run on cmd: python -m robot -d Result -i TC001 TestSuite/UI/E2E.robot
#run on terminal: robot -d Result -i TC001 TestSuite/UI/E2E.robot

*** Variables ***
@{MODULE_NAME}    Login    CreateCustomer

*** Test Cases ***
Test Setup        
    Begin Web Test
    Set Selenium Speed  .5s    

Login
    [Documentation]  This is TC001
    [Tags]           TC001

    Clear Folder    ${SAVE_PATH}                                                                                                                                                                                                                                                                
    Login.Verify Login page
    ${dict}=      Get Login Data     ${LOGIN_PATH}    
    FOR     ${i}   IN   @{dict} 
       Login.Login to Application       ${i['username']}   ${i['password']} 
       ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
       #${pic}=    Set Variable   ${SAVE_PATH}/${module_name}[0]/LandingPage.jpg
       #Capture Page Screenshot    ${pic}
       Capture Screenshot      ${SAVE_PATH}/${module_name}[0]/LandingPage.jpg
       Log      Login Success
       #Login.Sign Out
       #Login.Sign In
       gen_excel_file    ${SAVE_PATH}/${module_name}[0]    ${SAVE_PATH}/${module_name}[0]/Output_${timestamp}.xlsx    ${module_name}[0]
    END


Create Customer
    [Documentation]  This is TC002
    [Tags]           TC002
    
    Clear Folder        ${SAVE_PATH}/${module_name}[1]                                                                                                                                                                                                                                                                        
    Customer.Go to and Verify Customer Page
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${dict}=      Get Customer Data     ${CUST_DATA}    
    FOR     ${i}   IN   @{dict} 
        Customer.Create Customer        ${i['email']}   ${i['first name']}   ${i['last name']}  ${i['city']}    ${i['state']}   ${i['gender']}  ${i['promo']} 
        Capture Screenshot      ${SAVE_PATH}/${module_name}[1]/CustomerPage_${i}.jpg
        Customer.Submit and Verify Success Page 
        Capture Screenshot      ${SAVE_PATH}/${module_name}[1]/SuccessPage_${i}.jpg
        gen_excel_file    ${SAVE_PATH}/${module_name}[1]    ${SAVE_PATH}/${module_name}[1]/Output_${timestamp}.xlsx    ${module_name}[1]
    END


#Test Teardown     
   # End Web Test