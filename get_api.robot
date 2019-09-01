*** Settings ***
Library   REST

*** Test Cases ***
GET REQUEST
    GET      https://jsonplaceholder.typicode.com/users/1
    Output   response body
    Output schema   response body
    Object      response body            # เช็ค response body ใช่ Object หรือไม่
    Integer     response body id      2  # เช็ค response body ฟิลด์ id 9้องเป็น Integer และมีค่าเป็น 1
    String      response body name    Leanne Graham   # เช็ค response body ฟิลด์ name 9้องเป็น String และมีค่าเป็น Leanne Graham