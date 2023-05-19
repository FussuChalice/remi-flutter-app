from selenium.webdriver import Chrome
from selenium.webdriver import ChromeOptions
from selenium.common.exceptions import NoSuchElementException
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service as ChromeService
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.support import expected_conditions as EC
import time
import os
import json
from bs4 import BeautifulSoup
import sys

class FileManager:
    def saveFile(filename, data, encoding=None):
        with open(filename, 'w', -1, encoding) as file:
            file.write(data)

    def readFile(filename, encoding=None):
        result = ""
        with open(filename, 'r', -1, encoding) as file:
            result = file.read()

        return result
    
    def listFilesInDirecotry(directory):
        paths = os.listdir(directory)
        files = []

        for path in paths:
            if os.path.isfile(directory + "/" + path):
                files.append(directory + "/" + path)

        return files
    
    def readJsonFile(self, filename):
        file = self.readFile(filename)
        return json.loads(file)
    
    def fileLinesToList(self, filename):
        file = self.readFile(filename)
        lines = file.split('\n')

        return [line for line in lines if line.strip()]
    

def createWebdriver(base_url="https://www.selenium.dev/", arguments=["-lang=en"]):
    options = ChromeOptions();
    options.add_argument("-lang=en")

    driver = Chrome(service=ChromeService(ChromeDriverManager().install()), options=options)
    driver.get(base_url)

    return driver


# def getCitiesWithCountries(url):
#     lines = requests.get(url).text.splitlines()
#     result = [line.split(", ") for line in lines]
#     return result

def textToSearchQuery(text):
    return "https://www.google.com/maps/search/" + str(text).replace(" ", "+")


class SeleniumJavaScriptMethods:
    def __init__(self, rootElement="document"):
        self.rootElement = rootElement

    def scrollTo(self, query_selector, x, y):
        return f'{self.rootElement}.querySelector("{query_selector}").scrollTo({int(x)}, {int(y)});'
    
    def scrollHeight(self, query_selector):
        return f'return {self.rootElement}.querySelector("{query_selector}").scrollHeight;'
    

def getLinksBySource(source, a_tag_class):
    soup = BeautifulSoup(source, 'html.parser')
    a_tags = soup.find_all('a', {"class": a_tag_class, "href": True})

    links = []
    for a in a_tags:
        links.append(a['href'])

    return links


def parse(config_file):
        config = FileManager.readJsonFile(FileManager, config_file)

        question = input("You want start from zero (0), or from fetched files (1): ")
        if question == "0":
            if os.path.exists(config['directories']['parsed_data_dir']) is False:
                os.mkdir(config['directories']['parsed_data_dir'])

        
            driver = createWebdriver()

            # parse search queries
            for query in FileManager.fileLinesToList(FileManager, config['search_queries_file']):
                driver.get(textToSearchQuery(query))
                time.sleep(2)

                SJSM = SeleniumJavaScriptMethods()

                currentScrollHeight = int(driver.execute_script(SJSM.scrollHeight(config['gmp_components']['search_result_js_path'])))
                
                stopScrolling = False
                while stopScrolling == False:
                    driver.execute_script(SJSM.scrollTo(config['gmp_components']['search_result_js_path'], 0, currentScrollHeight))

                    currentScrollHeight += int(driver.execute_script(SJSM.scrollHeight(config['gmp_components']['search_result_js_path'])))
                    time.sleep(2)

                    try:
                        driver.find_element(By.CSS_SELECTOR, config['gmp_components']['result_list_stop_block'])
                        stopScrolling = True

                    except NoSuchElementException:
                        stopScrolling = False


                # Get source code of element
                result_list_src = driver.find_element(By.CSS_SELECTOR, config['gmp_components']['search_result_list']).get_attribute("outerHTML")

                FileManager.saveFile(f"{config['directories']['parsed_data_dir']}/{str(time.time())}.links", 
                                    str(getLinksBySource(result_list_src, config['gmp_components']['result_link_class'])))
                
        else:
            if os.path.exists(config['directories']['parsed_data_dir']) is False:
                print("Could not find folder")
                exit()

            if os.path.exists(config['directories']['output_dir']) is False:
                os.mkdir(config['directories']['output_dir'])


            files = FileManager.listFilesInDirecotry(config['directories']['parsed_data_dir'])
            print(files)

            driver = createWebdriver()

            for file in files:
                links = eval(FileManager.readFile(file))

                linksCount = int(config['link_parse_count_for_file'])
                pages = []

                for link in links:
                    if linksCount > 0:

                        driver.get(link)

                        # Parse link page

                        parse_fields = [
                            config['gmp_components']['title_xpath'],
                            config['gmp_components']['stars_count_xpath'],
                            config['gmp_components']['home_img_xpath'],
                            config['gmp_components']['website_xpath'],
                            config['gmp_components']['telephone_xpath'],
                            config['gmp_components']['address_xpath']
                        ]


                        elementList = []
                        for field in parse_fields:
                            try:
                                element = driver.find_element(By.XPATH, field).get_attribute("outerHTML")
                                elementList.append(element)

                            except NoSuchElementException:
                                elementList.append(None)

                        pages.append(elementList)

                        linksCount -= 1

                    else:
                        break

                FileManager.saveFile(f"{config['directories']['output_dir']}/{str(time.time())}.txt", str(pages), "utf-8")