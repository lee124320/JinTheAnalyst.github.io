from bs4 import BeautifulSoup
import requests

def getHTML(url):
    try:
        response = requests.get(url)
        return response.text
    except:
        print("aaa")
html = getHTML("https://webscraper.io/test-sites/tables")

soup = BeautifulSoup(html, 'html.parser')
table = soup.find('table', attrs={'class':'table'})

tbody = table.find('tbody')
print(tbody)

people = []
for row in tbody.find_all('tr'):
    cells = row.find_all('id')
    person = {}

for row in tbody.find_all('tr'):
    cells = row.find_all('td')
    person = {}
    person['id']= cells[0].string
    person['first_name'] = cells[1].string
    person['last_name'] = cells[2].string
    person['username'] = cells[3].string
    people.append(person)
print(people)