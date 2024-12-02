*** Settings ***
Library     SeleniumLibrary

*** Variables ***

*** Keywords ***
Begin Web Test
    Open Browser  ${URL}  ${BROWSER}
    Maximize Browser Window

End Web Test
    Close All Browsers