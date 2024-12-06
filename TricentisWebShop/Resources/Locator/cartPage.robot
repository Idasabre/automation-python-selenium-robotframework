*** Variables ***

${itemList}             //td/a
${cartQty}              xpath=//a/span[@class='cart-qty']
${removeItemsBtn}       xpath=//input[@value='Update shopping cart']
${removeSuccessTXt}     xpath=//div[contains(text(),'Cart is empty')]

${prodPrice}            xpath=//div[@class='product-price']/span
${addToCartBtn}         xpath=//input[contains(@id,'add-to-cart-button')]
${itemAdded}            xpath=//p[@class='content'][contains(text(),'The product has been added to your')]