*** Settings ***
Documentation     E2E Tricentis web shop demo
Library           SeleniumLibrary
Library           DateTime
Library           ../Lib/TricentisWebShop.py
Resource          ../Resources/common/common.robot
Resource          ../Resources/common/variables.robot
Resource          ../Resources/UI/Register.robot
Resource          ../Resources/UI/Login.robot
Resource          ../Resources/UI/WebShop.robot
Resource          ../Resources/Locator/cartPage.robot


#Run on cmd: python -m robot -d Result -i TC001 TestSuite/UI/E2E.robot
#run on terminal: robot -d Result -i TC001 TestSuite/UI/E2E.robot

*** Variables ***
@{MODULE_NAME}    Register    Login     Cart    #list of module name for reporting purposes

*** Test Cases ***
Test Setup    
    [Documentation]  Register the customer
    [Tags]           TC000    
    Begin Web Test
    Set Selenium Speed  .5s  

Register  
    [Documentation]  Register the customer
    [Tags]           TC001

    Clear Folder    ${screenshot} 
    Sleep   2s
    Capture Screenshot    ${screenshot}/${module_name}[0]/LandingPage.jpg
    Register.Go to Register Page
    Register.Verify Register Page
    ${dict}=      Get User Data     ${testData}    
    FOR     ${i}   IN   @{dict} 
       Register.Register User       ${i['gender']}   ${i['firstname']}   ${i['lastname']}   ${i['email']}   ${i['password']}
       ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
       ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${regSuccess}
       Log      ${is_visible}
       Run Keyword If   '${is_visible}' == 'True'   Run Keywords    Capture Screenshot    ${screenshot}/${module_name}[0]/SuccessPage.jpg       AND     Log      Register Success
       Run Keyword If   '${is_visible}' == 'False'  Run Keywords    Capture Screenshot     ${screenshot}/${module_name}[0]/registrationError.jpg        AND     Log      Register Failed       
    END
    gen_excel_file    ${screenshot}/${module_name}[0]    ${screenshot}/${module_name}[0]/${module_name}[0]_${timestamp}.xlsx    ${module_name}[0]

Login
    [Documentation]  User login
    [Tags]           TC002

    Login.Go To Login page
    Login.Verify Login Page
     ${dict}=      Get User Data     ${testData}    
    FOR     ${i}   IN   @{dict} 
       Login.User Login   ${i['email']}   ${i['password']}
       ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
       ${userAccount}=  Get text    ${loginSuccess}
       #${is_matched}=    Run Keyword And Return Status      '${userAccount.strip().lower()}' == '${i['email'].strip().lower()}'
       #Log      ${is_matched}
       Run Keyword If   '${userAccount.strip().lower()}' == '${i['email'].strip().lower()}'   Run Keywords    Capture Screenshot    ${screenshot}/${module_name}[1]/MainPage.jpg       
       ...              AND     Log      Login Success
       Run Keyword If   '${userAccount.strip().lower()}' != '${i['email'].strip().lower()}'  Run Keywords    Capture Screenshot     ${screenshot}/${module_name}[1]/LoginError.jpg        
       ...              AND     Log      Login Failed       
    END
    gen_excel_file    ${screenshot}/${module_name}[1]    ${screenshot}/${module_name}[1]/${module_name}[1]_${timestamp}.xlsx    ${module_name}[1]

Update Shopping Cart
    [Documentation]  User login
    [Tags]           TC003

    ${clearCart}=   Get Text        ${cartQty}
    Run Keyword If      '${clearCart}'!='(0)'
    ...     Run Keywords
    ...     WebShop.Go to Cart
    ...     WebShop.Clear Shopping Cart
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    gen_excel_file    ${screenshot}/${module_name}[2]    ${screenshot}/${module_name}[2]/${module_name}[2]_${timestamp}.xlsx    ${module_name}[2]


Add To cart
    [Documentation]  Add to cart some items
    [Tags]           TC004

    ${dict}=      Get webshop items     ${webshop}    
    FOR     ${i}   IN   @{dict} 
        WebShop.Select Items   ${i['category']}   ${i['sub-category']}   ${i['items']}
    END
    #Log    All texts in buffer: ${priceList}
    #Calculate Total
    #${total}    Set Variable    0
    #FOR    ${item}    IN    @{priceList}
    #    ${num}=    Convert To Float    ${item}
    #    ${total}    Set Variable    ${total}+${num}
    #END


#Checkout
#    [Documentation]  Checkout items
 #   [Tags]           TC005

 #   WebShop.Checkout Items