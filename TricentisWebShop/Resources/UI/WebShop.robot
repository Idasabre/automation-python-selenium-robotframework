*** Settings ***
Library         SeleniumLibrary   
Library         Collections     #Append To List 
Library         DateTime
Library         ../../Lib/TricentisWebShop.py
Resource        ../../Resources/Locator/landingPage.robot 
Resource        ../../Resources/Locator/registerPage.robot
Resource        ../../Resources/Locator/cartPage.robot


*** Variables ***
${price}    


*** Keywords ***
Go to Cart
    Click Element   ${cart}
    Capture Screenshot    ${screenshot}/${module_name}[2]/CartPage.jpg 


Clear Shopping Cart
    Wait Until Page Contains Element    ${itemList}    timeout=10
    ${count}    Get Element Count      ${itemList}
    @{items}    Create List
    FOR    ${index}    IN RANGE    ${count}
        ${locator}    Set Variable    xpath=(${itemList})[${index}+1]
        Append To List    ${items}    ${locator}
    END
    FOR    ${i}    IN    @{items}
        ${product}   Get text    ${i}
        ${checkbox}    Set Variable    xpath=//td[a[contains(text(),"${product}")]]/parent::tr/td[@class='remove-from-cart']/input
        Wait Until Element Is Visible    ${checkbox}    timeout=10
        Click Element    ${checkbox}
     END
    Capture Screenshot    ${screenshot}/${module_name}[2]/CartPage_Checked.jpg 
    Click Element   ${removeItemsBtn}
    Wait Until Element Is Visible   ${removeSuccessTXt}       timeout=10
    ${clearCart}=   Get Text        ${cartQty}
    Run Keyword If  '${clearCart}'=='(0)'     Log     Cart is cleared
    ...       ELSE  Log     Cart is not cleared
    Capture Screenshot    ${screenshot}/${module_name}[2]/CartPage_Qty.jpg 



Select Items
    [Arguments]     ${category}    ${sub-category}    ${items} 

    Run Keyword If  '${category}'!=''    Click Element  //*[contains(text(), '${category}')][1]
    Sleep   2s
    Run Keyword If    '${sub-category}' != 'N/A'    Click Element  xpath=.//div[@class='sub-category-item']/h2/a[contains(text(),"${sub-category}")][1]
    Run Keyword If  '${items}'!=''     Click Element      //h2[@class='product-title']/a[contains(text(),'${items}')][1]
    #add price to list
    #${price}=   Get Text    ${prodPrice}
    #@{priceList}      Create List
    #Append To List    ${priceList}    ${price}
    Click Element   ${addToCartBtn}
    Sleep   2s
    Element Should Be Visible   ${itemAdded}    timeout=10

#Checkout Items
