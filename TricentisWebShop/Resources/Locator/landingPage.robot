*** Variables ***

#First header
${register}     //a[contains(text(), 'Register')]  #.//div/*[@class='header-links']/ul/li/a[contains(text(),'Register')] 
${login}        //a[contains(text(), 'Log in')]
${cart}         //a/span[contains(text(), 'Shopping cart')]
${cartQty       }xpath=//a/span[@class='cart-qty']
${wishlist}     //a/span[contains(text(), 'Wishlist')]

#Top menu
${books}    //*[contains(text(), 'Books')]/following-sibling::div[@class='top-menu-triangle'][1]
${computers}    //*[contains(text(), 'Computers')]/following-sibling::div[@class='top-menu-triangle'][1]
${electronics}    //*[contains(text(), 'Electronics')]/following-sibling::div[@class='top-menu-triangle'][1]
${apparelShoes}    //*[contains(text(), 'Apparel & Shoes')]/following-sibling::div[@class='top-menu-triangle'][1]
${digitalDownloads}    //*[contains(text(), 'Digital downloads')]/following-sibling::div[@class='top-menu-triangle'][1]
${jewelry}    //*[contains(text(), 'Jewelry')]/following-sibling::div[@class='top-menu-triangle'][1]
${giftCards}    //*[contains(text(), 'Gift Cards')]/following-sibling::div[@class='top-menu-triangle'][1]
