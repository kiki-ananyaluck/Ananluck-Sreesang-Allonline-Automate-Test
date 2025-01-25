*** Settings ***
Library     SeleniumLibrary


*** Variables ***
${URL}              https://www.allonline.7eleven.co.th/
${BROWSER}          firefox
${USERNAME}         XXXX@gmail.com
${PASSWORD}         xxxxxxxxx
${USER_FULLNAME}    นัทธา ศิริไล
${PRODUCT_NAME}     ไมโลบาร์ ช็อกโกแลต
${RESULT}           ผลการค้นหาสำหรับ »ไมโลบาร์ ช็อกโกแลต«
${PRODUCT_TITLE}    ไมโลบาร์ ช็อกโกแลต 30 กรัม
${PRODUCT_PRICE}    ฿ 61
${PHONE}            0644959819
${STORE_NUMBER}     00903
${STORE_ADDRESS}    เซเว่นอีเลฟเว่น #00903
${ALLMEMBERPOINT}    18
${CARD_NAME}        นัทธา ศิริไล    
${CARD_NUMBER}      5577554326574635
${EXPIRY_DATE}      0826
${CV_CODE}          224


*** Keywords ***
เปิดเว็บเบราว์เซอร์
    Open Browser    ${URL}    ${BROWSER}

login เข้าสู่ระบบ
    Wait Until Element Is Visible    xpath=//*[@id="page"]/header/div[4]/div/div/div/ul/li[4]/a    timeout=10s
    Click Element    xpath=//*[@id="page"]/header/div[4]/div/div/div/ul/li[4]/a
    Input Text    name=email    ${USERNAME}
    Input Text    name=password    ${PASSWORD}
    Click Element    xpath=/html/body/div[1]/div/div/div[2]/div[2]/div/div/div/div[6]/a[1]
    Wait Until Element Is Visible    class=ellipsis-330
    Element Should Contain    class=ellipsis-330    ${USER_FULLNAME}

ค้นหาและตรวจสอบผลการค้นหา
    Input Text    name=q    ${PRODUCT_NAME}
    Press Keys    name=q    RETURN
    Wait Until Page Contains    ${RESULT}

เลือกสินค้า
    Click Element    //div[contains(text(), "ไมโลบาร์ ช็อกโกแลต 30 กรัม")]

ตรวจสอบรายละเอียดสินค้า
    Wait Until Element Is Visible    id=title-product
    Element Should Contain    id=title-product    ${PRODUCT_TITLE}
    Element Should Contain    class=currentPrice    ${PRODUCT_PRICE}

ซื้อสินค้า
    Wait Until Element Is Visible    id=btn-accept-gdpr
    Click Element    id=btn-accept-gdpr
    Click Button    //button[contains(@class, "btn-proceed") and contains(@class, "buy-now")]

กรอกข้อมูลที่อยู่จัดส่ง
    #Click Element    id=alert-cookie-gdpr-allonline__button
    Input Text    name=shippingData.storeShippingData.phoneNumber    ${PHONE}
    Click Element    xpath=//*[@id="storefinder-selector-group"]/div[1]/div/button
    Wait Until Element Is Visible    xpath=//*[@id="store-number-tab"]    timeout=5s
    Input Text    id=user-storenumber-input    ${STORE_NUMBER}
    Click Element    xpath=//*[@id="btn-check-storenumber"]

ตรวจสอบข้อมูลที่อยู่จัดส่ง
    Wait Until Element Is Visible    xpath=//*[@id="store"]/div[2]/div/div[4]/div[3]
    #Element Should Contain    class=address-7_11_store-detail-header    ${STORE_ADDRESS}

กดชำระสินค้า  
    Wait Until Element Is Visible    id=continue-payment-btn
    Click Element    id=continue-payment-btn

ตรวจสอบข้อมูลสรุปการสั่งซื้อ
    Wait Until Element Is Visible    class=address
    Element Should Contain    xpath://div[@class="address-wrapper"]    ${STORE_ADDRESS}
    Element Should Contain    xpath://div[@class="address-wrapper"]    สาขา สนามกอล์ฟทหารบก
    Element Should Contain    xpath://div[@class="address-wrapper"]    เลขที่  ถ.รามอินทรา, 459, แขวงอนุสาวรีย์ เขตบางเขน กรุงเทพฯ 10220
    Element Should Contain    xpath=//*[@id="js-invoice-details-tbody"]/tr[1]/td[2]/b    ${PRODUCT_PRICE}
    Element Should Contain    xpath=//*[@id="js-invoice-details-tbody"]/tr[17]/td[2]/b    ${ALLMEMBERPOINT} 


กดชำระสินค้างเงินด้วยบัตรเครดิต
    Wait Until Element Is Visible    id=cardName    
    Input Text    id=cardName    ${CARD_NAME}  
    Input Text    id=cardNumber    ${CARD_NUMBER}
    Input Text    id=expiryDate    ${EXPIRY_DATE}
    Input Text    id=cvCode    ${CV_CODE}   
