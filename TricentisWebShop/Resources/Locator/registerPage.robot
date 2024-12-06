*** Variables ***

${registerHeader}       //h1[contains(text(), 'Register')]
${maleRadioBtn}         //input[@id='gender-male']
${femaleRadioBtn}       //input[@id='gender-female']
${firstnameTxt}         //div/*[@id='FirstName']
${lastnameTxt}          //div/*[@id='LastName']
${emailTxt}             //div/*[@id='Email']
${passwordTxt}          //div/*[@id='Password']
${confirmPasswordTxt}   //div/*[@id='ConfirmPassword']
${registerBtn}          //div/*[@id='register-button']
${regError1}            xpath=.//li[contains(text(), 'The specified email already exists')]
${regSuccess}           xpath=.//div[contains(text(),'Your registration completed')]

