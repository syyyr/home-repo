#!/usr/bin/env python3

from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support.ui import TimeoutException
from selenium.webdriver.support import expected_conditions as EC
import sys
import os.path
import pycurl

def waitForElem(browser, locator):
    try:
        return WebDriverWait(browser, 10).until(EC.presence_of_element_located(locator))
    except TimeoutException:
        sys.exit(1)

options = webdriver.ChromeOptions()
options.add_argument('--headless')

def get_ulozto_video_link(link):
    browser = webdriver.Chrome(options=options)
    browser.get(link)
    play_button = waitForElem(browser, (By.CLASS_NAME, 'vp-play-cta'))
    play_button.click()
    video = waitForElem(browser, (By.TAG_NAME, 'video'))
    res = video.get_attribute('src')
    if res is None:
        print("Unable to get a download link. Possible reasons:")
        print("    1) You didn't specify a valid ulozto link.")
        print("    2) ulozto could be blocked in your country.")
        print("    3) Your computer is so slow, that it took more than 10 seconds to load the ulozto webpage. In that case, open")
        print("the script and try to increase the timeout inside the waitForElem function.")
        sys.exit(1)
    browser.quit()
    return res

def get_file_size(link):
    c = pycurl.Curl()
    c.setopt(c.URL, link)
    c.setopt(c.NOBODY, True)
    c.perform()
    return c.getinfo(c.CONTENT_LENGTH_DOWNLOAD)

def as_megabytes(bytes):
    return bytes / 1024 / 1024

def file_size_to_string(bytes):
    return f'{as_megabytes(bytes):.2f} MB ({int(bytes)} bytes)'

if len(sys.argv) != 3:
    print(f'Usage: {sys.argv[0]} <ulozto-link>')
    exit(1)

filename = sys.argv[1]
input_link = sys.argv[2]
filemode = 'wb'

if os.path.isfile(filename):
    answer = input(f'A file called {filename} already exists, do you want to continue downloading it? (saying "n" overwrites the file) [y/n] ')
    if answer == 'y':
        print(f'Will continue downloading {filename}.')
        filemode = 'ab'
    elif answer == 'n':
        filemode = 'wb'
        print('Will overwrite {filename}.')
    else:
        print(f'Unknown answer "{answer}". Aborting.')
        sys.exit(1)

download_link = get_ulozto_video_link(input_link)
file_size = get_file_size(download_link)
remaining_size = file_size
print(f'File size: {file_size_to_string(file_size)}')

with open(filename, filemode) as f:
    remaining_size = file_size - f.tell()
    if remaining_size == 0:
        print('File was already downloaded (local size equals remote size). Aborting.')
        sys.exit(0)

    while True:
        c = pycurl.Curl()
        c.setopt(c.URL, download_link)
        c.setopt(c.WRITEDATA, f)
        c.setopt(c.TIMEOUT, 2)
        c.setopt(c.RESUME_FROM, f.tell())
        try:
            c.perform()
        except pycurl.error as e:
            code = e.args[0]
            if code == pycurl.E_PARTIAL_FILE or code == pycurl.E_RANGE_ERROR:
                print('Download link expired.')
                print('Getting new video link...')
                download_link = get_ulozto_video_link(input_link)
                print('Download resumed.')
            elif code == pycurl.E_OPERATION_TIMEDOUT:
                pass
            else:
                print(f'libcurl exited with an unknown error code ({code})')
                print(f'Error {c.errstr()}')
                sys.exit(1)

        downloaded_bytes = c.getinfo(c.SIZE_DOWNLOAD)
        remaining_size = remaining_size - downloaded_bytes
        print(f'Remaining: {file_size_to_string(remaining_size)}')

        if f.tell() == file_size:
            break

print('File downloaded.')
