from selenium import webdriver
from datetime import datetime
from selenium.webdriver.remote.command import Command
from selenium.webdriver import ChromeOptions
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support.expected_conditions import element_to_be_clickable
from sys import argv, exit
from time import sleep

print("Generating the attestation with arguments :", argv[1:])
# Get the arguments
reason = str(argv[1])
first_name = str(argv[2])
last_name = str(argv[3])
birthday_date = str(argv[4])
place_of_birth = str(argv[5])
address_ = str(argv[6])
city_ = str(argv[7])
zip_code = str(argv[8])

# Whether it is for groceries or for an outdoor break
checkbox_id = None
if reason == 'groceries':
    checkbox_id = "checkbox-achats"
elif reason == 'walk':
    checkbox_id = "checkbox-sport_animaux"
else:
    print("Unknown reason "+reason)
    exit()


def get_status(d):
    try:
        d.execute(Command.STATUS)
        return "Alive"
    except Exception:
        return "Dead"


# Instantiate driver
print("Opening chrome ...")
chrome_options = ChromeOptions()
chrome_options.binary_location = '/usr/local/bin/google-chrome'
chrome_options.add_argument('--no-sandbox')
chrome_options.add_argument('--headless')
chrome_options.add_argument('--disable-dev-shm-usage')
download_default_directory = "/home/ec2-user/Downloads"
profile = {"download.default_directory": download_default_directory,
           "download.prompt_for_download": False,
           "download.directory_upgrade": True,
           "plugins.plugins_disabled": ["Chrome PDF Viewer"]}
chrome_options.add_experimental_option("prefs", profile)
chrome_options.add_argument("--disable-extensions")
driver = webdriver.Chrome(executable_path='/usr/local/bin/chromedriver', options=chrome_options)
print("Chrome status : "+get_status(driver))

# The url & timeout
url = 'https://media.interieur.gouv.fr/deplacement-covid-19/'
download_timeout = 5

# Get current time
now = datetime.now()
date = now.strftime('%d%m%Y')
time = now.strftime('%H:%M')

# Go to url
print("Going to url "+url+" ...")
driver.get(url)

# Reload if necessary
reload = driver.find_element_by_id("reload-btn")
if reload.size != 0:
    WebDriverWait(driver, 3).until(element_to_be_clickable((By.ID, "reload-btn"))).click()

print("Accessing the fields ...")
# Get fields
firstname = driver.find_element_by_id("field-firstname")
lastname = driver.find_element_by_id("field-lastname")
birthday = driver.find_element_by_id("field-birthday")
placeofbirth = driver.find_element_by_id("field-placeofbirth")
address = driver.find_element_by_id("field-address")
city = driver.find_element_by_id("field-city")
zipcode = driver.find_element_by_id("field-zipcode")
date_sortie = driver.find_element_by_id("field-datesortie")
heure_sortie = driver.find_element_by_id("field-heuresortie")

print("Filling the fields ...")
# Fill fields
firstname.send_keys(first_name)
print("firstname ->", first_name)
lastname.send_keys(last_name)
print("lastname ->", last_name)
birthday.send_keys(birthday_date)
print("birthday ->", birthday_date)
placeofbirth.send_keys(place_of_birth)
print("place of birth ->", place_of_birth)
address.send_keys(address_)
print("address ->", address_)
city.send_keys(city_)
print("city ->", city_)
zipcode.send_keys(zip_code)
print("zipcode ->", zip_code)
date_sortie.send_keys(date)
print("date ->", date)
heure_sortie.send_keys(time)
print("time ->", time)
WebDriverWait(driver, 3).until(element_to_be_clickable((By.ID, checkbox_id))).click()
print("reason ->", reason)

print("Submitting the form ...")
# Submit
submit = driver.find_element_by_id("generate-btn")
response = WebDriverWait(driver, 3).until(element_to_be_clickable((By.ID, "generate-btn"))).click()
sleep(download_timeout)
print("The output file should be accessible in ~/Downloads now !")
