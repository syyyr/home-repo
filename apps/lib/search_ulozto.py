#!/usr/bin/env python3

from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import sys
import re
import pprint
import time
import json


if len(sys.argv) != 3:
    print(f'Usage: {sys.argv[0]} <search-term> <matching-regex>')
    exit(1)


def waitForElem(browser, locator):
    try:
        return WebDriverWait(browser, 10).until(EC.presence_of_element_located(locator))
    except:
        sys.exit(1)


options = webdriver.ChromeOptions()
options.add_argument('--headless')
browser = webdriver.Chrome(options=options)
url = f'https://uloz.to/hledej?q={sys.argv[1]}'
browser.get(url)
time.sleep(3)

link_elems = browser.find_elements_by_class_name('js-file-name')

for elem in link_elems:
    if re.search(sys.argv[2], elem.get_attribute('title')):
        out = {
            elem.get_attribute('title'): elem.get_attribute('href')
        }
        print(json.dumps(out))
        browser.quit()
        exit(0)


exit(1)
