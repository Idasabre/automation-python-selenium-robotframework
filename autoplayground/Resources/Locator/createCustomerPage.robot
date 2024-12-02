*** Variables ***
${newCustBtn}       .//a[@id='new-customer']
${custPage}         .//h2[contains(text(),'Add Customer')]
${emailInput2}      .//input[@type='email']
${fnameInput}       .//input[@id='FirstName']
${lnameInput}       id=LastName
${cityInput}        id=City
#${stateDDL}         .//select[contains(@id,'StateOrRegion')]//option[contains(text(),'${state}')]
${femaleRadioBtn}   .//input[@value='female']     
${maleRadioBtn}     .//input[@value='male']   
${promoChckBox}     .//input[@name='promos-name']  
${custSubmit}       .//*[@type='submit']
${SuccessMsg}       .//div[@id='Success']


