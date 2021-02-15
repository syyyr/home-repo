#!/usr/bin/env python3

from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import sys

if len(sys.argv) != 2:
    print(f'Usage: {sys.argv[0]} <ulozto-link>')
    exit(1)


def waitForElem(browser, locator):
    return WebDriverWait(browser, 10).until(EC.presence_of_element_located(locator))


options = webdriver.ChromeOptions()
options.add_argument('--headless')
browser = webdriver.Chrome(options=options)
browser.get(sys.argv[1])
play_button = waitForElem(browser, (By.CLASS_NAME, 'vp-play-cta'))
play_button.click()
video = waitForElem(browser, (By.TAG_NAME, 'video'))
print(video.get_attribute('src'))
browser.quit()
