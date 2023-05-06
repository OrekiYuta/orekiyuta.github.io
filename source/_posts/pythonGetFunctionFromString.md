---
title: Python get function from String
date: 2021-01-25 02:02:46
tags: Python
---

## 从变量中获取对象的函数并执行

- 单纯的执行方法可以用 eval()、locals()、globals()
```python
    eval(func)() # func 为变量值
    locals()[func]()
    globals()[func]()

```
- 而从对象中执行方法用 `__getattribute__`
```python
    chrome.__getattribute__(itemParser) # 对象.__getattribute__(变量值)
```

<!-- more -->
## 使用场景
- 从变量中读取函数名并执行,提高复用度
```python
config = [{'name': 'qncyw', 'url': 'https://www.qncyw.com/site/signup',
           'parser': 'selector',
           'phoneInputParser': '#username',
           'sendButtonParser': '#btnSendCode'},
          {'name': '360doc', 'url': 'http://www.360doc.com/register.aspx',
           'parser': 'selector',
           'phoneInputParser': '#signMobileName',
           'sendButtonParser': '#sign_sendcode'},
          {'name': 'iwgame', 'url': 'http://passport.iwgame.com/reg/account/regpage.do',
           'parser': 'xpath',
           'phoneInputParser': '//*[@name="identityId"]',
           'sendButtonParser': '//*[@id="regPersonalForm"]/ul/li[5]/div[1]/em/a'},
          ]
          
def eboo(chrome):
    for item in config:
        itemName = item['name']
        itemUrl = item['url']
        itemParser = ''
        setDateTime = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))

        try:
            chrome.get(itemUrl)

            if item['parser'] == 'selector':
                itemParser = 'find_element_by_css_selector'
            elif item['parser'] == 'xpath':
                itemParser = 'find_element_by_xpath'

            # chrome 对象通过 __getattribute__ 方法去执行名为 itemParser 变量值的函数
            chrome.__getattribute__(itemParser)(item['phoneInputParser']).send_keys(phoneNum)
            chrome.__getattribute__(itemParser)(item['sendButtonParser']).click()

        except NoSuchElementException as error:
            print(f"{itemName} ---> {error}")
            chrome.get_screenshot_as_file('./error/' + itemName + '_' + setDateTime + '.png')
        finally:
            print(f"{itemName} already completed at {setDateTime}")


def ChromeOpen():

    headers = 'user-agent="Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101 Firefox/38.0" '
    options = ChromeOptions()
    options.add_argument(headers)
    chrome = Chrome(options=options)
    return chrome


chrome_open = ChromeOpen()
eboo(chrome_open)
```



- 👉 [Python 通过字符串调用函数或方法](https://segmentfault.com/a/1190000010476065)