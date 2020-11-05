from selenium import webdriver
from datetime import datetime
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support.expected_conditions import element_to_be_clickable
from os import chmod

# Instantiate driver
chrome_options = Options()
chrome_options.add_argument('--no-sandbox')
chrome_options.add_argument('--headless')
chrome_options.add_argument('--disable-dev-shm-usage')
download_default_directory = "/Users/luciendavid/Downloads"
chmod(download_default_directory, 0o777)
profile = {"download.default_directory": download_default_directory,
           "download.prompt_for_download": False,
           "download.directory_upgrade": True,
           "plugins.plugins_disabled": ["Chrome PDF Viewer"]}
chrome_options.add_experimental_option("prefs", profile)
chrome_options.add_argument("--disable-extensions")
driver = webdriver.Chrome(executable_path='/usr/local/bin/chromedriver', options=chrome_options)
url = 'https://media.interieur.gouv.fr/deplacement-covid-19/'

# Get current time
now = datetime.now()
date = now.strftime('%d/%m/%y')
time = now.strftime('%H:%M')

# Go to url
driver.get(url)

# Get fields
firstname = driver.find_element_by_id("field-firstname")
lastname = driver.find_element_by_id("field-lastname")
birthday = driver.find_element_by_id("field-birthday")
place_of_birth = driver.find_element_by_id("field-placeofbirth")
address = driver.find_element_by_id("field-address")
city = driver.find_element_by_id("field-city")
zipcode = driver.find_element_by_id("field-zipcode")
date_sortie = driver.find_element_by_id("field-datesortie")
heure_sortie = driver.find_element_by_id("field-heuresortie")
sport_animaux = driver.find_element_by_id("checkbox-sport_animaux")

# Fill fields
firstname.send_keys("Lucien")
lastname.send_keys("David")
birthday.send_keys("24/11/1998")
place_of_birth.send_keys("Poitiers")
address.send_keys("130 allée des Chenes")
city.send_keys("Jard-sur-mer")
zipcode.send_keys("85520")
date_sortie.send_keys(date)
heure_sortie.send_keys(time)
sport_animaux.click()

# Submit
WebDriverWait(driver, 20).until(element_to_be_clickable((By.ID, "generate-btn"))).click()
