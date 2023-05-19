from parse import *
from random import *
import requests
import json
from bs4 import BeautifulSoup

class RemiAPI:
    def __init__(self, client_url) -> None:
        self.client_url = client_url

    def uuidToId(self, uuid):
        url = self.client_url + "/api/v1/utility/uuid_to_id?uuid=%s" % uuid

        return requests.get(url).text
    
    data_segments = [
        'settings', 'promocodes',
        'contacts', 'comments',
        'images', 'menu',
        'orders', 'main_image',
    ]
    
    def sendData(self, id, token, data, segment):
        url = f"{self.client_url}/api/v1/data/{segment}/{id}"

        payload = json.dumps({
            "atoken": token,
            "data": data
        })

        headers = {
            'Content-Type': 'application/json'
        }

        response = requests.request("POST", url, headers=headers, data=payload)
        return response.text
    

    class Auth:
        def __init__(self, client_url) -> None:
            self.client_url = client_url

        def signUp(self, email, password) -> str:
            url = self.client_url + "/api/v1/auth/signup"

            payload = json.dumps({
                "email": str(email),
                "password": str(password)
            })

            headers = {
                'Content-Type': 'application/json'
            }

            response = requests.request("POST", url, headers=headers, data=payload)
            return response.text

        def logIn(self, email, password):
            url = self.client_url + "/api/v1/auth/login"

            payload = json.dumps({
                "email": str(email),
                "password": str(password)
            })

            headers = {
                'Content-Type': 'application/json'
            }

            response = requests.request("POST", url, headers=headers, data=payload)
            return response.text


def emailRandomGenerator(mail_dns):
    word_list_url = "https://raw.githubusercontent.com/dwyl/english-words/master/words_alpha.txt"

    lines = requests.get(word_list_url).text.splitlines()
    word_result = [line.split(", ") for line in lines]
    
    return str(choice(word_result)[0]) + "@" + mail_dns

class Service:
    title       = None
    home_img    = None
    stars_count = None
    address     = None
    website     = None
    telephone   = None

    def __str__(self) -> str:
        return f"title: {self.title}, home_img: {self.home_img}, stars_count: {self.stars_count}, address: {self.address}, website: {self.website}, telephone: {self.telephone}"



if __name__ == '__main__':
    api = RemiAPI("http://localhost:5050")
    auth = RemiAPI.Auth(api.client_url)

    config = "config.json"

    sign_or_parse = input("Sign (0) or parse (1): ")
    if sign_or_parse == "0":

        for file in FileManager.listFilesInDirecotry(FileManager.readJsonFile(FileManager, config)["directories"]["output_dir"]):
            file_data_list = eval(FileManager.readFile(file))

            pages_count = len(file_data_list)

            for i in range(pages_count):
                current_service = file_data_list[i]

                current_service_obj = Service()

                if current_service[0]:
                    soup = BeautifulSoup(current_service[0], 'html.parser') 
                    Service.title = soup.find('h1').text

                if current_service[1]:
                    soup = BeautifulSoup(current_service[1], 'html.parser') 
                    Service.stars_count = soup.find('span').text

                if current_service[2]:
                    soup = BeautifulSoup(current_service[2], 'html.parser') 
                    Service.home_img = soup.find('img').get('src')

                if current_service[3]:
                    soup = BeautifulSoup(current_service[3], 'html.parser') 
                    Service.website = soup.find('div').text

                if current_service[4]:
                    soup = BeautifulSoup(current_service[4], 'html.parser') 
                    Service.telephone = soup.find('div').text

                if current_service[5]:
                    soup = BeautifulSoup(current_service[5], 'html.parser') 
                    Service.address = soup.find('div').text

                
                signResponse = json.loads(auth.signUp(emailRandomGenerator("remi.com"), "qwerty1234567890"))
                current_service_id = api.uuidToId(signResponse["uuid"])

                data_sets = [
                    {
                        "title": current_service_obj.title,
                        "type":"DevTest",
                        "address": current_service_obj.address,
                        "description": "None",
                        "stars_count": current_service_obj.stars_count,
                    },
                    current_service_obj.home_img,
                    {
                        "phone_numbers": current_service_obj.telephone,
                        "email": "none",
                        "website": current_service_obj.website,
                        "social_network": {
                            "twitter":"null",
                            "youtube":"null",
                            "telegram":"null",
                            "facebook":"null",
                            "instagram":"null",
                            "reddit":"null",
                            "pinterest":"null"
                        }
                    }
                ]

                sections = [
                    api.data_segments[0],
                    api.data_segments[7],
                    api.data_segments[2],
                ]

                for i in range(len(sections)):
                    print(api.sendData(current_service_id, signResponse["token"], data_sets[i], sections[i]))

                

    else:
        parse(config)